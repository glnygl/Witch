//
//  LoadingView.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import SwiftUI

struct LoadingView: View {
    
    private var text: String
    @State private var loadingIndex = 0
    private let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(loadingIndex == index ? .accent : .lilac)
                            .frame(width: 16)
                            .scaleEffect(loadingIndex == index ? 1.5 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: loadingIndex)
                    }
                }
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .padding(.horizontal, 50)
        .ignoresSafeArea()
        .onReceive(timer) { _ in
            loadingIndex = (loadingIndex + 1) % 4
        }
    }
}

#Preview {
    LoadingView(text: "Loading...")
}
