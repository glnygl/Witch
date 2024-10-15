//
//  URLRequestHelper.swift
//  Network
//
//  Created by Glny Gl on 15/10/2024.
//

import Foundation

protocol URLRequestHelperProtocol {
    func makeURLRequest(requestable: URLRequestable) throws -> URLRequest
}

struct URLRequestHelper: URLRequestHelperProtocol {
    private let jsonEncoder = JSONEncoder()
    
    func makeURLRequest(requestable: URLRequestable) throws -> URLRequest {
        guard var url = URL(string: requestable.baseURL) else {
            throw NetworkError.invalidURL
        }
        
        url.appendPathComponent(requestable.path)
        
        var paramData: Data?
        if let parameters = requestable.parameters {
            paramData =  parameters.data(using: .utf8)
        }
        
        return urlRequestForJSONEncoding(url: url,parameters: paramData,
                                         headers: requestable.headers, httpMethod: requestable.method)
    }
    
    private func urlRequestForJSONEncoding(url: URL, parameters: Data?, headers: [String: String]?, httpMethod: HTTPMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = parameters
        urlRequest.httpMethod = httpMethod.rawValue
        addHeaders(headers: headers, for: &urlRequest)
        return urlRequest
    }
    
    private func addHeaders(headers: [String: String]?, for request: inout URLRequest) {
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}

