//
//  MockNetworking.swift
//  WitchTests
//
//  Created by Glny Gl on 20/10/2024.
//

import XCTest
@testable import Witch
@testable import Network

final class MockNetworking: NetworkingProtocol {
    
    var resultToReturn: Result<GameList, NetworkError>?
    
    func request<T: Decodable, R: URLRequestable>(requestable: R, responseType: T.Type) async -> Result<T, NetworkError> {
        if let resultToReturn = resultToReturn as? Result<T, NetworkError> {
            return resultToReturn
        }
        return .failure(.unknown)
    }
}
