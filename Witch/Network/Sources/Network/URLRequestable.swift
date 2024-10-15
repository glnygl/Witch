//
//  URLRequestable.swift
//  Network
//
//  Created by Glny Gl on 15/10/2024.
//

public protocol URLRequestable {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Codable? { get }
    var headers: [String: String] { get }
}
