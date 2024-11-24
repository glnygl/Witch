//
//  GameListView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI
import CoreData
import Coordinator

struct GameListView: View {
    @State var viewModel: GameListViewModel
    @AppStorage("appTheme") var appTheme: AppTheme = .light
    @Environment(Coordinator<AppRoutes>.self) private var appCoordinator
    
    var body: some View {
        NavigationView {
            if viewModel.showLoading {
                LoadingView(text: viewModel.loadingText)
            } else {
                List {
                    ForEach(viewModel.gameList, id: \.id) { game in
                        GameListItemView(game: game)
                            .modifier(EmbedInSection())
                            .background(
                                LinearGradient(colors: [.deeppurple, .bluep, .softlilac, .pastelpurple], startPoint: .bottomLeading, endPoint: .topTrailing).opacity(0.5)
                            )
                            .cornerRadius(20)
                            .frame(height: 160)
                            .onTapGesture {
                                appCoordinator.push(page: .gameDetail(dependencies: GameDetailDependencies(game: game)))
                            }
                    }
                    .plainList()
                    .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .refreshable {
                    viewModel.isRefreshing.toggle()
                    Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        // Added 2 second non-blocking delay before refreshing data to prevent rapid refresh
                        try await viewModel.getGameData()
                        viewModel.isRefreshing.toggle()
                    }
                }
                .navigationTitle("Games")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            appTheme.toggle()
                        } label: {
                            Image(systemName: appTheme == .light ? "sun.max" : "moon")
                        }
                    }
                }
            }
        }
        .alert(isPresented: .constant(viewModel.error != nil), error: viewModel.error, actions: {
            Button("Ok") { }
        })
        .onViewDidLoad {
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                try await viewModel.getGameData()
            }
        }
    }
}
