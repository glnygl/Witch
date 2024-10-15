//
//  HTTPMethod.swift
//  Network
//
//  Created by Glny Gl on 15/10/2024.
//

enum NetworkEncodingType {
    case urlEncoding
    case jsonEncoding
}

public enum HTTPMethod: String, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    
    var type: NetworkEncodingType {
        switch self {
        case .get, .delete : return .urlEncoding
        case .post, .put, .patch : return .jsonEncoding
        }
    }
}
