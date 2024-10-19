//
//  RatingView.swift
//  Witch
//
//  Created by Glny Gl on 19/10/2024.
//

import SwiftUI

struct RatingView: View {
    
    var rating: Double 
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { _ in
                Text(Image(systemName: "star"))
                    .foregroundColor(.yellow)
                    .aspectRatio(contentMode: .fill)
            }
        }.overlay(
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(0..<5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .clipShape(
                    ClipShape(width: (reader.size.width / CGFloat(5)) * CGFloat(rating))
                )
            }
        )
    }
}

struct ClipShape: Shape {
    let width: Double
    
    func path(in rect: CGRect) -> Path {
        Path(CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height))
    }
}

#Preview {
    RatingView(rating: 3.5)
}
