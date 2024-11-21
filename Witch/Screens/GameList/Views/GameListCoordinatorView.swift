//
//  GameListCoordinatorView.swift
//  Witch
//
//  Created by Glny Gl on 21/11/2024.
//

import SwiftUI

struct GameListCoordinatorView: View {
    
    @Environment(PersistenceController.self) private var persistenceController
    @Environment(\.gameService) private var gameService: GameServiceProtocol
    
    var body: some View {
        GameListView(viewModel: GameListViewModel(service: gameService, persistenceController: persistenceController))
    }
}
