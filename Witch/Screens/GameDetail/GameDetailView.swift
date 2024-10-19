//
//  GameDetailView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI
import CachedAsyncImage

struct GameDetailView: View {
    
    var game: Game
    @State var viewModel = GameDetailViewModel(service: GameListService())
    
    @State private var showMore = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let urlString = game.cover?.url {
                    CachedAsyncImage(
                        url: GameScreens.detail.url(string: urlString),
                        content: { image in
                            image.resizable()
                                .frame(height: 400)
                        },
                        placeholder: {
                            Rectangle()
                                .fill(.gray.opacity(0.4))
                                .frame(width: 400, height: 400)
                        }
                    )
                    .cornerRadius(40)
                }
                Text(game.name ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                
                if let storyline = game.storyline {
                    VStack(alignment: .trailing, spacing: 4){
                        Text("\(showMore ? storyline : String(storyline.prefix(300)))")
                        Text("\(showMore || (storyline.count < 300) ? "Less info" : "More info")")
                            .foregroundStyle(.accent)
                            .underline().bold()
                    }
                    .font(.subheadline)
                    .onTapGesture {
                        withAnimation {
                            showMore.toggle()
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Similar Games").font(.system(size: 20)).fontWeight(.semibold)
                    SimilarGamesView(games: viewModel.gameList)
                }
                .shouldHide(viewModel.gameList.isEmpty)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("", systemImage: "link") {
                        viewModel.openURL(urlString: game.url)
                    }
                    .shouldHide((game.url == nil))
                }
            }
        }
        .onViewDidLoad(perform: {
            Task {
                guard let ids = game.similarGameIds else { return }
                await viewModel.fetchSimilarGameList(ids: ids)
            }
        })
        .padding()
    }
}
