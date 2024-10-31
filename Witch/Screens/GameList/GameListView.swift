//
//  GameListView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI
import CoreData

struct GameListView: View {
    @State private var viewModel = GameListViewModel(service: GameListService())
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            if viewModel.showLoading || isRefreshing {
                LoadingView(text: isRefreshing ? "Refreshing..." : "Loading...")
            } else {
                List {
                    ForEach(viewModel.gameList, id: \.id) { game in
                        GameListItemView(game: game)
                            .modifier(EmbedInSection())
                            .background(
                                LinearGradient(colors: [.deeppurple, .bluep, .softlilac, .pastelpurple ], startPoint: .bottomLeading, endPoint: .topTrailing).opacity(0.5)
                            )
                            .cornerRadius(20)
                            .frame(height: 160)
                            .navigationLink {
                                GameDetailView(viewModel: GameDetailViewModel(service: GameListService(), game: game))
                                    .removeNavigationBackButtonTitle()
                            }
                    }
                    .plainList()
                    .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .refreshable {
                    isRefreshing.toggle()
                    Task {
                        try? await Task.sleep(nanoseconds: 1_000_000_000) // added 1 second non-blocking delay before refreshing data to prevent rapid refresh
                        try await viewModel.getGameData()
                        isRefreshing.toggle()
                    }
                }
                .navigationTitle("Games")
            }
        }
        .onViewDidLoad {
            Task {
                try await viewModel.getGameData()
            }
        }
    }
}

#Preview {
    GameListView()
}
