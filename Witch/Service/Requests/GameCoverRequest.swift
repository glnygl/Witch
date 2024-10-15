//
//  GameCoverRequest.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Network
import Foundation

struct GameCoverRequest: URLRequestable {
    
    var method: HTTPMethod = .post
    var path: String = URLPath.gameCover.rawValue
    var parameters: Codable?
    
}

