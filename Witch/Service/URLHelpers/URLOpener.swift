//
//  URLOpener.swift
//  Witch
//
//  Created by Glny Gl on 19/10/2024.
//

import SwiftUI

protocol URLOpener {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

extension UIApplication: URLOpener {
    public func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
