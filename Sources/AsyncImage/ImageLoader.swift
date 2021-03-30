//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 30.03.21.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var result: ImageLoaderResult = .empty
    
    private(set) var isLoading = false
    
    private let source: ImageSource
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(source: ImageSource) {
        self.source = source
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        guard !isLoading else {
            return
        }

//        if let image = cache?[url] {
//            self.image = image
//            return
//        }
        
        cancellable = source
            .imagePublisher()
            .map { ImageLoaderResult.success($0) }
            .catch { Just(ImageLoaderResult.failure($0)) }
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.result = $0 }
    }
}

enum ImageLoaderResult {
    case empty
    case loading
    case failure(Error)
    case success(UIImage)
}
