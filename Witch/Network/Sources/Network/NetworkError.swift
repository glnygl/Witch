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
    case noHTTPResponse
    case parse(message: String)
    case executionError
    case noInternetConnection
    case requestTimeOut
    case requestCancelled
    case requestFailed(message: String)
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

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .clientError:
            return "Client Error"
        case .serverError:
            return "Server Error"
        case .noHTTPResponse:
            return "No HTTP Response"
        case .parse (let message):
            return "Parsing Error \(message.capitalized)"
        case .executionError:
            return "Execution Error"
        case .noInternetConnection:
            return "No Internet Connection"
        case .requestTimeOut:
            return "Request Time Out"
        case .requestCancelled:
            return "Request Canceled"
        case .requestFailed (let message):
            return "Request Failed \(message.capitalized)"
        }
    }
}
