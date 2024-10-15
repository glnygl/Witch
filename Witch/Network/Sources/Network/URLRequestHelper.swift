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
        
        var encodedParameters: Data?
        if let parameters = requestable.parameters {
            if let params = parameters as? String {
                encodedParameters =  params.data(using: .utf8)
            } else {
                guard let encoded = try? jsonEncoder.encode(parameters) else {
                    throw NetworkError.serialization
                }
                encodedParameters = encoded
            }
        }
        
        switch requestable.method.type {
        case .urlEncoding:
            return try urlRequestForURLEncoding(url: url,parameters: encodedParameters,
                                                headers: requestable.headers, httpMethod: requestable.method)
        case .jsonEncoding:
            return urlRequestForJSONEncoding(url: url,parameters: encodedParameters,
                                             headers: requestable.headers, httpMethod: requestable.method)
        }
    }
    
    private func urlRequestForURLEncoding(url: URL, parameters: Data?, headers: [String: String]?, httpMethod: HTTPMethod) throws -> URLRequest {
        if let parameters = parameters,
           let queryParameters = try? JSONSerialization.jsonObject(with: parameters, options: .fragmentsAllowed) as? [String:Any], !queryParameters.isEmpty {
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw NetworkError.invalidURL
            }

            components.queryItems = queryParameters.map {
  
                if type(of: $0.value) == type(of: NSNumber(value: true)),
                   let value = $0.value as? Bool {
                    return URLQueryItem(name: $0.key, value: "\(value)")
                }
                return URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
            guard let finalURL = components.url else {
                throw NetworkError.invalidURL
            }
            var urlRequest = URLRequest(url: finalURL)
            urlRequest.httpMethod = httpMethod.rawValue
            addHeaders(headers: headers, for: &urlRequest)
            return urlRequest
        } else {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            addHeaders(headers: headers, for: &urlRequest)
            return urlRequest
        }
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

