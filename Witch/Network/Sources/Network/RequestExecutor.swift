//
//  RequestExecutor.swift
//  Network
//
//  Created by Glny Gl on 15/10/2024.
//

import Foundation

protocol RequestExecutorProtocol {
    var session: URLSession { get }
    func execute(_ request: URLRequest) async throws -> RequestSuccess
}

final class RequestExecutor: RequestExecutorProtocol {
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func execute(_ request: URLRequest) async throws -> RequestSuccess {
        let (data, response) = try await session.data(for: request)
        return RequestSuccess(data: data, response: response)
    }
}
