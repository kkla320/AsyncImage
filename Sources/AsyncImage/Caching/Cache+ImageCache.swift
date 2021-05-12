//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 02.04.21.
//

import Foundation
import SwiftUI

extension Cache: ImageCache where Key == AnyHashable, Value == Image {
    public subscript(key: AnyHashable) -> Image? {
        get {
            get(forKey: key)
        }
        set {
            set(newValue: newValue, for: key)
        }
    }
}
