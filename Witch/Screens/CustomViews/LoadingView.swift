//
//  LoadingView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

struct LoadingView: View {
    
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        ZStack {
            ProgressView(text)
                .font(.headline)
                .tint(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 50)
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingView(text: "Loading...")
}
