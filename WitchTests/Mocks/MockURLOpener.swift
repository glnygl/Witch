//
//  MockURLOpener.swift
//  Witch
//
//  Created by Glny Gl on 19/10/2024.
//

import SwiftUI
@testable import Witch

final class MockURLOpener: URLOpener {
    
    var canOpenURLCalled = false
    var openURLCalled = false
    var canOpenURLReturnValue = true
    
    func canOpenURL(_ url: URL) -> Bool {
        canOpenURLCalled = true
        return canOpenURLReturnValue
    }
    
    func open(_ url: URL) {
        if canOpenURL(url) {
            openURLCalled = true
        } else {
            return
        }
    }
    
}
