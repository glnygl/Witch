//
//  GameListItemView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI
import NukeUI

struct GameListItemView: View {
    
    var game: Game?
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            if let urlString = game?.cover?.url {
                LazyImage(url:  GameScreens.list.url(string: urlString)) { state in
                    if let image = state.image {
                        image.resizable()
                            .cornerRadius(8)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120)
                    } else {
                        Rectangle()
                            .fill(.gray.opacity(0.4))
                            .frame(width: 120)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(game?.name ?? "")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(game?.summary ?? "")
                    .font(.subheadline)
                    .fontWeight(.thin)
            }
            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
            .multilineTextAlignment(.leading)
        }
        .padding(8)
    }
}

#Preview {
    GameListItemView()
}
