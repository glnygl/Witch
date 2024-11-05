//
//  WitchApp.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

@main
struct WitchApp: App {
    
    let persistentContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            GameListView(viewModel: GameListViewModel(service: GameListService(), persistenceController: persistentContainer))
                .onOpenURL { url in
                    print(url)
                }
        }
    }
}
