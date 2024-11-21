//
//  Coordinator.swift
//  Coordinator
//
//  Created by Glny Gl on 20/11/2024.
//

import SwiftUI

public protocol Routable: View, Hashable, Identifiable {}

@Observable
public class Coordinator<Route: Routable> {

    public var path: NavigationPath = NavigationPath()
    public var sheet: Route?
    public var fullscreenCover: Route?
    
    public init() {}

    public enum PushType {
        case push
        case sheet
        case fullScreenCover
    }

    public enum PopType {
        case push(last: Int)
        case sheet
        case fullScreenCover
    }

    public func push(page: Route, type: PushType = .push) {
        switch type {
        case .push:
            path.append(page)
        case .sheet:
            sheet = page
        case .fullScreenCover:
            fullscreenCover = page
        }
    }

    public func pop(type: PopType = .push(last: 1)) {
        switch type {
        case .push(let last):
            path.removeLast(last)
        case .sheet:
            sheet = nil
        case .fullScreenCover:
            fullscreenCover = nil
        }
    }

    public func popToRoot() {
        path.removeLast(path.count)
    }
}
