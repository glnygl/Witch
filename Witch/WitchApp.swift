//
//  WitchApp.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

@main
struct WitchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
