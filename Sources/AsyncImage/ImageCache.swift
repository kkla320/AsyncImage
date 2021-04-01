//
//  Protocol.swift
//  
//
//  Created by Kevin Klaebe on 01.04.21.
//

import SwiftUI

public protocol ImageCache {
    var id: String { get }
    
    subscript(key: AnyHashable) -> UIImage? { get set }
}
