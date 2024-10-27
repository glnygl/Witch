//
//  MockRequestExecutor.swift
//  Network
//
//  Created by Glny Gl on 27/10/2024.
//

import Foundation
@testable import Network

final class MockRequestExecutor: RequestExecutorProtocol {
    var session: URLSession = .shared
    var isExecuteSuccess = true
    
    func execute(_ request: URLRequest) async -> Result<Network.RequestSuccess, any Error> {
        if isExecuteSuccess {
            return .success(RequestSuccess(data: Data(), response: HTTPURLResponse(url: URL(string: "https://api.igdb.com/v4/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!))
        } else {
            return .failure(NSError(domain: "domain", code: 1))
        }
    }
}
