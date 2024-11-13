//
//  GameDetailView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

struct GameDetailView: View {
    
    @State var viewModel: GameDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                
                GameDetailHeaderView()
                GameDetailSummaryView()

                VStack(alignment: .leading) {
                    Text("Similar Games").font(.system(size: 16))
                        .fontWeight(.medium).underline()
                        .foregroundStyle(.primary)
                    SimilarGamesView(games: viewModel.gameList)
                }
                .hide(viewModel.gameList.isEmpty)
                
                YoutubeVideoView(videoId: viewModel.videoId)
                    .frame(maxWidth: .infinity, idealHeight: 260)
                    .padding()
                
            }.toolbar {
                GameDetailToolBarView()
            }
        }
        .alert(isPresented: .constant(viewModel.error != nil), error: viewModel.error, actions: {
            Button("Ok") { }
        })
        .onViewDidLoad(perform: {
            viewModel.showSummary = viewModel.summary.count < 400
            Task {
                guard let ids = viewModel.game.similarGameIds else { return }
                try await viewModel.fetchSimilarGameList(ids: ids)
            }
        })
        .environment(viewModel)
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 6, trailing: 12))
    }
}
