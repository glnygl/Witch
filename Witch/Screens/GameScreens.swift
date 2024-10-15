//
//  GameScreens.swift
//  Witch
//
//  Created by Glny Gl on 16/10/2024.
//

import Foundation

enum GameScreens {
    case list
    case detail
    
    var imageSize: String {
        switch self {
        case .list:
            return "cover_big"
        default:
            return "720p"
        }
    }
    
    func urlString(string: String) -> URL? {
        return URL(string: "https:\(string.replacingOccurrences(of: "t_thumb", with: "t_\(self.imageSize)"))")
    }
}

