//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 30.03.21.
//

import Foundation
import Combine
import SwiftUI

class URLImageSource: ImageSource {
    private var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    static func == (lhs: URLImageSource, rhs: URLImageSource) -> Bool {
        return lhs.url == rhs.url
    }
    
    func hash(into hasher: inout Hasher) {
        url.hash(into: &hasher)
    }
    
    func imagePublisher() -> AnyPublisher<UIImage, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response in
                guard let image = UIImage(data: response.data) else {
                    throw Errors.imageNotInitializable
                }
                return image
            }
            .eraseToAnyPublisher()
    }
}

extension URLImageSource {
    enum Errors: Error {
        case imageNotInitializable
    }
}
