//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 30.03.21.
//

import Foundation
import Combine
import SwiftUI

public class URLImageSource: ImageSource {
    private var url: URL
    
    public var key: URL {
        return url
    }
    
    init(url: URL) {
        self.url = url
    }
    
    public func imagePublisher() -> AnyPublisher<UIImage, Error> {
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
