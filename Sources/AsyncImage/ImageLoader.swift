//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 30.03.21.
//

import Combine
import SwiftUI

extension DispatchQueue {
    static let imageProcessingQueue = DispatchQueue(label: "image-processing")
}

class ImageLoader<Source>: ObservableObject where Source: ImageSource {
    @Published var result: ImageLoaderResult = .pending
    
    private let source: Source
    private var cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    init(source: Source, cache: ImageCache?) {
        self.source = source
        self.cache = cache
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        guard result == .pending else {
            return
        }

        if let image = cache?[source.key] {
            self.result = .success(image)
            return
        }
        
        cancellable = source
            .imagePublisher()
            .handleEvents(receiveOutput: { [weak self, source] image in
                self?.cache?[source.key] = image
            })
            .map { ImageLoaderResult.success($0) }
            .catch { Just(ImageLoaderResult.failure($0)) }
            .subscribe(on: DispatchQueue.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.result = $0 }
    }
}

enum ImageLoaderResult {
    case empty
    case pending
    case loading
    case failure(Error)
    case success(UIImage)
}

extension ImageLoaderResult: Equatable {
    static func == (lhs: ImageLoaderResult, rhs: ImageLoaderResult) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        case (.pending, .pending):
            return true
        case (.loading, .loading):
            return true
        case (.failure(_), .failure(_)):
            return true
        case (.success(let lhsImage), .success(let rhsImage)):
            return lhsImage == rhsImage
        default:
            return false
        }
    }
}
