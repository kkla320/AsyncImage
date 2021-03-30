//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 30.03.21.
//

import SwiftUI
import Combine

public protocol ImageSource {
    func imagePublisher() -> AnyPublisher<UIImage, Error>
}
