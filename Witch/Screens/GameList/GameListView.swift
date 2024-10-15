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
        NavigationView {
            if viewModel.showLoading {
                LoadingView()
            } else {
                List {
                    ForEach(viewModel.gameList, id: \.id) { game in
                        GameListItemView(game: game)
                            .background(.purple.opacity(0.4))
                            .cornerRadius(20)
                            .frame(height: 160)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .task {
            await viewModel.getGameList()
        }
    }
}

#Preview {
    GameListView()
}

