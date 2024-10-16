//
//  GameDetailView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

struct GameDetailView: View {
    
    var game: Game
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let url = game.cover?.url {
                    AsyncImage(
                        url: GameScreens.detail.urlString(string: url),
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
                    .clipShape(
                        .rect(cornerRadii: RectangleCornerRadii(bottomLeading: 40, bottomTrailing: 40)))
                }
            }
        }
        .background(
            LinearGradient(colors: [.deeppurple, .bluep, .softlilac, .pastelpurple], startPoint: .bottomLeading, endPoint: .topTrailing).opacity(0.4)
        )
        .ignoresSafeArea()
    }
}
