//
//  GameDetailView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI
import CachedAsyncImage

struct GameDetailView: View {
    
    @State var viewModel: GameDetailViewModel
    
    @State private var showMore = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let urlString = viewModel.game.cover?.url {
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
                Text(viewModel.name)
                    .font(.title)
                    .fontWeight(.semibold)
                
                RatingView(rating: viewModel.convertRating())
                
                DisclosureGroup("Summary") {
                    Text(viewModel.summary)
                        .font(.subheadline)
                }.shouldHide(viewModel.summary.isEmpty)
                
                if let storyline = viewModel.game.storyline {
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
                VStack(alignment: .leading) {
                    Text("Similar Games").font(.system(size: 16))
                        .fontWeight(.medium).underline()
                        .foregroundStyle(.primary)
                    SimilarGamesView(games: viewModel.gameList)
                }
                .shouldHide(viewModel.gameList.isEmpty)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("", systemImage: "link") {
                        viewModel.openURL(urlString: viewModel.url)
                    }
                    .shouldHide((viewModel.url.isEmpty))
                }
            }
        }
        .onViewDidLoad(perform: {
            Task {
                guard let ids = viewModel.game.similarGameIds else { return }
                await viewModel.fetchSimilarGameList(ids: ids)
            }
        })
        .padding()
    }
}
