//
//  GameDetailView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

struct GameDetailView: View {
    
    var game: Game
    @State private var showMore = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let urlString = game.cover?.url {
                    AsyncImage(
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
                    Group {
                        Text("\(showMore ? storyline : String(storyline.prefix(200)))")
                        +
                        Text(showMore || (storyline.count < 200) ? "" : " more")
                            .foregroundStyle(.accent)
                        
                    }
                    .font(.subheadline)
                    .onTapGesture {
                        withAnimation {
                            showMore.toggle()
                        }
                    }
                }
            }
        }
        .padding()
    }
}
