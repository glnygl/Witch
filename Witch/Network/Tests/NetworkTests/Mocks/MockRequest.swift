//
//  MockRequest.swift
//  Network
//
//  Created by Glny Gl on 27/10/2024.
//

@testable import Network

struct MockRequest: URLRequestable {
    var baseURL: String = "https://api.igdb.com/v4/"
    var parameters: String? = nil
    var headers: [String : String] =
    [
        "Client-ID" : "ctgyj1u5eoe8ynxsoi0anhpctz1oo6",
        "Authorization" : "Bearer iawmqtbgk5h47jjglcn4v7sofkue9v"
    ]
    var method: HTTPMethod = .post
    var path: String = "games"
}


