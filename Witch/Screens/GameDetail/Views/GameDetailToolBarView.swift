//
//  GameDetailToolBarView.swift
//  Witch
//
//  Created by Glny Gl on 04/11/2024.
//

import SwiftUI

struct GameDetailToolBarView: ToolbarContent {
    
    @Environment(GameDetailViewModel.self) private var viewModel: GameDetailViewModel
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button("", systemImage: "link") {
                    viewModel.openURL(urlString: viewModel.url)
                }
                .hide((viewModel.url.isEmpty))
                ShareLink(item: viewModel.deeplinkUrl) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}
