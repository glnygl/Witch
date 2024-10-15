//
//  GameListItemView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

struct GameListItemView: View {
    
    var game: Game?
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            if let url = game?.cover?.url {
                AsyncImage(
                      url: GameScreens.list.urlString(string: url),
                      content: { image in
                          image.resizable()
                              .cornerRadius(8)
                              .aspectRatio(contentMode: .fit)
                              .frame(width: 120)
                      },
                      placeholder: {
                          ProgressView()
                      }
                  )
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(game?.name ?? "")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(game?.summary ?? "")
                    .font(.subheadline)
                    .fontWeight(.thin)
                Spacer()
            }
            .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(8)
    }
}

#Preview {
    GameListItemView()
}
