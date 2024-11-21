//
//  GameDetailCoordinatorView.swift
//  Witch
//
//  Created by Glny Gl on 21/11/2024.
//

import SwiftUI
import Coordinator

struct GameDetailCoordinatorView: View {
    
    @Environment(Coordinator<AppRoutes>.self) private var appCoordinator
    @Environment(\.gameService) private var gameService: GameServiceProtocol
    
    let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    var body: some View {
        GameDetailView(viewModel: GameDetailViewModel(service: gameService, game: game))
            .removeNavigationBackButtonTitle()
    }
}
