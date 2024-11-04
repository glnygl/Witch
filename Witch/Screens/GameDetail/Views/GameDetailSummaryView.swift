//
//  GameDetailSummaryView.swift
//  Witch
//
//  Created by Glny Gl on 04/11/2024.
//

import SwiftUI

struct GameDetailSummaryView: View {
    
    @Environment(GameDetailViewModel.self) private var viewModel: GameDetailViewModel
    
    var body: some View {
        DisclosureGroup("Summary", isExpanded: Binding(get: { viewModel.showSummary }, set: { viewModel.showSummary = $0 })) {
            VStack {
                Text(viewModel.summary)
                    .font(.subheadline)
            }.padding(8)
        }
        .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
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
    }
}

#Preview {
    GameDetailSummaryView()
}
