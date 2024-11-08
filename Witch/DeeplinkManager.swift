//
//  DeeplinkManager.swift
//  Witch
//
//  Created by Glny Gl on 03/11/2024.
//

import Foundation

protocol DeeplinkManagerProtocol {
    func url(host: LinkType, path: String, queryItems: [String: String]) -> URL
}

enum LinkType: String {
    case gameList = "-gl-"
    case gameDetail = "-gd-"
    
    static func type(urlString: String) -> LinkType {

        let linkTypeTuple: [(scheme: String, type: LinkType)] = [
            ("-gl-", .gameList),
            ("-gd-", .gameDetail)
        ]
        
        for (scheme, type) in linkTypeTuple {
            if urlString.contains(scheme) {
                return type
            }
        }
        return .gameList
    }
}

class DeeplinkManager: DeeplinkManagerProtocol {

    func url(host: LinkType, path: String, queryItems: [String: String]) -> URL {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "witchapp"
        urlComponents.host = host.rawValue
        urlComponents.path = "/" + path
        urlComponents.queryItems = queryItems.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
        return urlComponents.url!
    }
}
