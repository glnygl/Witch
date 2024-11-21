//
//  WitchAppStack.swift
//  Witch
//
//  Created by Glny Gl on 20/11/2024.
//

import SwiftUI
import Coordinator
import Foundation

struct WitchAppStack<Route: Routable>: View {
    let root: Route
    @State private var coordinator = Coordinator<Route>()

    init(root: Route) {
        self.root = root
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            root
                .navigationDestination(for: Route.self) { $0 }
                .sheet(item: $coordinator.sheet) { $0 }
                .fullScreenCover(item: $coordinator.fullscreenCover) { $0 }
        }
        .environment(coordinator)
    }
}
