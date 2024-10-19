//
//  SimilarGamesView.swift
//  Witch
//
//  Created by Glny Gl on 19/10/2024.
//

import SwiftUI
import CachedAsyncImage

struct SimilarGamesView: View {
    
    var games: [Game]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(games, id: \.id) { game in
                    NavigationLink {
                        GameDetailView(viewModel: GameDetailViewModel(service: GameListService(), game: game))
                            .removeNavigationBackButtonTitle()
                    } label: {
                        if let urlString = game.cover?.url {
                            CachedAsyncImage(
                                  url: GameScreens.list.url(string: urlString),
                                  content: { image in
                                      image.resizable()
                                          .cornerRadius(8)
                                          .aspectRatio(contentMode: .fit)
                                          .frame(width: 100)
                                  },
                                  placeholder: {
                                      Rectangle()
                                          .fill(.gray.opacity(0.4))
                                          .frame(width: 100)
                                  }
                              )
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
