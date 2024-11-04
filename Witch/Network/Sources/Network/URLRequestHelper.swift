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
        
        var url = URL(string: requestable.baseURL)!
        
        url.appendPathComponent(requestable.path)
        
        var paramData: Data?
        if let parameters = requestable.parameters {
            paramData =  parameters.data(using: .utf8) // Body parameters text
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpBody = paramData
        urlRequest.httpMethod =  requestable.method.rawValue
        
        requestable.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
    }
}

