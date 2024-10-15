//
//  RequestExecutor.swift
//  Network
//
//  Created by Glny Gl on 15/10/2024.
//

import Foundation

protocol RequestExecutorProtocol {
    var session: URLSession { get }
    func execute(_ request: URLRequest) async -> Result<RequestSuccess, Error>
}


final class RequestExecutor: RequestExecutorProtocol {
    
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }

    func execute(_ request: URLRequest) async -> Result<RequestSuccess, Error> {
        do {
            if #available(iOS 15.0, *) {
                let (data, response) = try await session.data(for: request)
                return .success(RequestSuccess(data: data, response: response))
            } else {
                return .failure(NetworkError.executionError)
            }
        } catch let error {
            return .failure(error)
        }
    }
}
