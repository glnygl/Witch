//
//  GameListRequest.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Network

struct GameListRequest: URLRequestable {
    
    var method: HTTPMethod = .post
    var path: String = URLPath.gameList.rawValue
    var parameters: String?
    
}

