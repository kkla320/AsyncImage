//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 12.05.21.
//

import Foundation
#if os(iOS) || os(watchOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(watchOS)
public typealias Image = UIImage
#elseif os(macOS)
public typealias Image = NSImage
#endif
