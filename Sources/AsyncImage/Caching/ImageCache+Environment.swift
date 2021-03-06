//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 01.04.21.
//

import SwiftUI

struct ImageCacheEnvironmentKey: EnvironmentKey {
    static var defaultValue: ImageCache = Cache<AnyHashable, Image>()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get {
            return self[ImageCacheEnvironmentKey.self]
        }
        set {
            self[ImageCacheEnvironmentKey.self] = newValue
        }
    }
}
