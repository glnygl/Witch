//
//  GameDetailCoordinatorView.swift
//  Witch
//
//  Created by Glny Gl on 21/11/2024.
//

import SwiftUI
import Coordinator

struct GameDetailDependencies: Hashable {
    
    var id: UUID { UUID() }
    let game: Game
    
    init(game: Game ) {
        self.game = game
    }
    
    static func == (lhs: GameDetailDependencies, rhs: GameDetailDependencies) -> Bool {
        lhs.id == rhs.id
    }
}

struct GameDetailCoordinatorView: View {
    
    @Environment(Coordinator<AppRoutes>.self) private var appCoordinator
    @Environment(\.gameService) private var gameService: GameServiceProtocol
    
    let dependencies: GameDetailDependencies
    
    init(dependencies: GameDetailDependencies) {
        self.dependencies = dependencies
    }
    
    var body: some View {
        GameDetailView(viewModel: GameDetailViewModel(service: gameService, game: dependencies.game))
            .removeNavigationBackButtonTitle()
    }
}
