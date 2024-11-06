//
//  GameDetailHeaderView.swift
//  Witch
//
//  Created by Glny Gl on 04/11/2024.
//

import SwiftUI
import NukeUI

struct GameDetailHeaderView: View {
    
    @Environment(GameDetailViewModel.self) private var viewModel: GameDetailViewModel
    
    var body: some View {
        VStack {
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
        }
    }
}

