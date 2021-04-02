//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 02.04.21.
//

import Foundation
import SwiftUI

extension Cache: ImageCache where Key == AnyHashable, Value == UIImage {
    public subscript(key: AnyHashable) -> UIImage? {
        get {
            get(forKey: key)
        }
        set {
            set(newValue: newValue, for: key)
        }
    }
}
