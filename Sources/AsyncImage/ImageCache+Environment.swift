//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 01.04.21.
//

import SwiftUI

struct ImageCacheEnvironmentKey: EnvironmentKey {
    static var defaultValue: EquatableImageCache? = nil
}

extension EnvironmentValues {
    var imageCache: EquatableImageCache? {
        get {
            return self[ImageCacheEnvironmentKey.self].map({ EquatableImageCache($0) })
        }
        set {
            self[ImageCacheEnvironmentKey.self] = newValue
        }
    }
}
