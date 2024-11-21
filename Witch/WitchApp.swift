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
    let gameService = GameService()
    @AppStorage("appTheme") var appTheme: AppTheme = .light
    
    var body: some Scene {
        WindowGroup {
            WitchAppStack(root: AppRoutes.gameList)
                .onOpenURL { url in
                    print(url)
                }
                .environment(\.gameService, gameService)
                .environment(persistentContainer)
                .preferredColorScheme(appTheme.scheme)
        }
    }
}
