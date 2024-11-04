//
//  GameDetailView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI
import NukeUI

struct GameDetailView: View {
    
    @State var viewModel: GameDetailViewModel
    
    init(viewModel: GameDetailViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                if let urlString = viewModel.coverUrl {
                    LazyImage(url:GameScreens.detail.url(string: urlString)) { state in
                        if let image = state.image {
                            image.resizable()
                                .frame(width: 200, height: 200)
                        } else {
                            Rectangle()
                                .fill(.gray.opacity(0.4))
                                .frame(width: 200, height: 200)
                        }
                    }
                    .cornerRadius(40)
                }
                Text(viewModel.name)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                
                RatingView(rating: viewModel.convertStarRating())
                
                DisclosureGroup("Summary", isExpanded: $viewModel.showSummary) {
                    VStack {
                        Text(viewModel.summary)
                            .font(.subheadline)
                    }.padding(8)
                }
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                
                .background(viewModel.showSummary ? .accent.opacity(0.1) : .clear)
                .shouldHide(viewModel.summary.isEmpty)
                
                if let storyline = viewModel.storyline {
                    VStack(alignment: .trailing, spacing: 4){
                        Text("\(viewModel.showMore ? storyline : String(storyline.prefix(300)))")
                        Text("\(viewModel.showMore || (storyline.count < 300) ? "Less info" : "More info")")
                            .foregroundStyle(.accent)
                            .underline().bold()
                    }
                    .font(.subheadline)
                    .onTapGesture {
                        withAnimation {
                            viewModel.showMore.toggle()
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
        .alert(isPresented: $viewModel.hasError, error: viewModel.error, actions: {
            Button("Ok") { }
        })
        .onViewDidLoad(perform: {
            viewModel.showSummary = viewModel.summary.count < 400
            Task {
                guard let ids = viewModel.game.similarGameIds else { return }
                try await viewModel.fetchSimilarGameList(ids: ids)
            }
        })
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 6, trailing: 12))
    }
}
