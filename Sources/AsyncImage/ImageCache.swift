//
//  Protocol.swift
//  
//
//  Created by Kevin Klaebe on 01.04.21.
//

import SwiftUI

public protocol ImageCache {
    var id: String { get }
    
    subscript<Key>(key: Key) -> UIImage? where Key: Hashable { get set }
}

class EquatableImageCache: ImageCache, Equatable {
    private var cache: ImageCache
    
    var id: String {
        return cache.id
    }
    
    subscript<Key>(key: Key) -> UIImage? where Key : Hashable {
        get {
            return cache[key]
        }
        set {
            cache[key] = newValue
        }
    }
    
    init(_ cache: ImageCache) {
        self.cache = cache
    }
    
    public static func == (lhs: EquatableImageCache, rhs: EquatableImageCache) -> Bool {
        return lhs.id == rhs.id
    }
}
