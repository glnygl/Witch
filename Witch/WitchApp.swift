//
//  WitchApp.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI
import CoreData

@main
struct WitchApp: App {
    var body: some Scene {
        WindowGroup {
            GameListView(viewModel: GameListViewModel(service: GameListService()))
                .onOpenURL { url in
                    print(url)
                }
        }
    }
}
