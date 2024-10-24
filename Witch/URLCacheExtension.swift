//
//  URLCacheExtension.swift
//  Witch
//
//  Created by Glny Gl on 24/10/2024.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
