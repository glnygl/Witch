//
//  LoadingView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            ProgressView("Loading...")
                .font(.headline)
                .tint(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 50)
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
