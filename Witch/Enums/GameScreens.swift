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
    
    func url(string: String) -> URL? {
        
        let urlString = string.replacingOccurrences(of: "t_thumb", with: "t_\(imageSize)")
        
        var urlComponents = URLComponents(string: urlString)
        
        if urlComponents?.scheme == nil {
            urlComponents?.scheme = "https"
        }
        
        return urlComponents?.url
    }
}

