//
//  Protocol.swift
//  
//
//  Created by Kevin Klaebe on 01.04.21.
//

import SwiftUI

public protocol ImageCache {
    associatedtype Key: Hashable
    
    subscript(key: Key) -> UIImage? { get set }
}
