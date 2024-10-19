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
    var viewModel = GameDetailViewModel()
    
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
                                .frame(width: 120)
                        }
                    )
                    .cornerRadius(40)
                }
                Text(game.name ?? "")
                    .fontWeight(.bold)
    
                if let storyline = game.storyline {

                    VStack(alignment: .trailing, spacing: 4){
                        Text("\(showMore ? storyline : String(storyline.prefix(300)))")
                        Text("More info ").shouldHide(showMore || (storyline.count < 300))
                            .foregroundStyle(.accent)
                            .underline()
                            .bold()
                    }
                    .font(.subheadline)
                    .onTapGesture {
                        withAnimation {
                            showMore.toggle()
                        }
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("", systemImage: "link") {
                        viewModel.openURL(urlString: game.url)
                    }
                }
            }
        }
        .padding()
    }
}
