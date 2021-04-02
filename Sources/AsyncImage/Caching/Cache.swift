//
//  ImageCache.swift
//  SmartCook
//
//  Created by Kevin Klaebe on 03.02.21.
//  Copyright © 2021 Kevin Klaebe. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public class Cache<Key, Value> where Key: Hashable {
    private var cache: NSCache<WrappedKey, Entry>
    
    public init() {
        self.cache = NSCache<WrappedKey, Entry>()
    }
    
    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        cache.setObject(entry, forKey: WrappedKey(key))
    }

    func removeValue(forKey key: Key) {
        cache.removeObject(forKey: WrappedKey(key))
    }
    
    func get(forKey key: Key) -> Value? {
        let entry = cache.object(forKey: WrappedKey(key))
        return entry?.value
    }

    func set(newValue: Value?, for key: Key) {
        guard let value = newValue else {
            removeValue(forKey: key)
            return
        }

        insert(value, forKey: key)
    }
}

extension Cache {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}

extension Cache {
    final class Entry {
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }
}
