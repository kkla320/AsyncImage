//
//  Protocol.swift
//  
//
//  Created by Kevin Klaebe on 01.04.21.
//

import SwiftUI

public protocol ImageCache {
    subscript(key: AnyHashable) -> Image? { get set }
}
