//
//  NetworkError.swift
//  Network
//
//  Created by Glny Gl on 15/10/2024.
//

import Foundation

public enum NetworkError: Error {
    case unknown
    case clientError
    case serverError
    case serialization
    case noHTTPResponse
    case parse(message: String)
    case executionError
    case noInternetConnection
    case requestTimedOut
    case requestCancelled
}

enum URLResponseStatus {
    case success
    case failure(NetworkError)
}

public struct RequestSuccess {
    let data: Data
    let response: URLResponse
}

extension URLResponse {
    var responseStatus: URLResponseStatus {
        guard let httpResponse = self as? HTTPURLResponse else {
            return .failure(.noHTTPResponse)
        }
        switch httpResponse.statusCode {
        case 200...299:
            return .success
        case 400...499:
            return .failure(NetworkError.clientError)
        case 500...:
            return .failure(NetworkError.serverError)
        default:
            return .failure(NetworkError.unknown)
        }
    }
}
