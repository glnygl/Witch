//
//  URLRequestableExtension.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Network
import SwiftUI

enum URLPath: String {
    case gameList = "games"
}

extension URLRequestable {
    
    public var baseURL: String {
        "https://api.igdb.com/v4/"
    }
    
    public var headers: [String: String] {
        [
            "Client-ID" : "d1gbjxwol6uv96w49juek9ow5lv2vt",
            "Authorization" : "Bearer khm0oegwmz7kew5y1rbwyk4litdu5z"  
        ]
    }
    public var parameters: String? {
        nil
    }
}
