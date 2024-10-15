//
//  GameListView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

struct GameListView: View {
    @State var viewModel = GameListViewModel(service: GameListService())
    
    var body: some View {
        List(viewModel.gameList, id: \.id) { game in
            Text(game.name ?? "")
        }
        .task {
            await viewModel.getGameList()
        }
    }
}

#Preview {
    GameListView()
}
