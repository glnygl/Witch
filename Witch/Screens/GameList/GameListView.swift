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
                            .background(
                                LinearGradient(colors: [.deeppurple, .bluep, .softlilac, .pastelpurple ], startPoint: .bottomLeading, endPoint: .topTrailing).opacity(0.5)
                            )
                            .cornerRadius(20)
                            .frame(height: 160)
                            .navigationLink {
                                GameDetailView(game: game)
                                    .removeNavigationBackButtonTitle()
                            }
                    }
                    .plainList()
                    .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .refreshable {
                    //Todo 
                }
                .navigationTitle("Games")
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

