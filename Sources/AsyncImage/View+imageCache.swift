//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 01.04.21.
//

import SwiftUI

extension View {
    public func imageCache(_ cache: ImageCache) -> some View {
        return self
            .environment(\.imageCache, EquatableImageCache(cache))
    }
}
