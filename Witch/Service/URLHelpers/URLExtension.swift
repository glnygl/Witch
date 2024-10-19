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
            "Client-ID" : "ctgyj1u5eoe8ynxsoi0anhpctz1oo6",
            "Authorization" : "Bearer iawmqtbgk5h47jjglcn4v7sofkue9v"
        ]
    }
    public var parameters: String? {
        nil
    }
}

protocol URLOpener: AnyObject {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

extension UIApplication: URLOpener {
    public func open(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
