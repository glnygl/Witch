//
//  MockGameListService.swift
//  WitchTests
//
//  Created by Glny Gl on 20/10/2024.
//

import XCTest
@testable import Witch
@testable import Network

class MockGameListService: GameListServiceProtocol {
    var gameListResult: Result<GameList, NetworkError>?
    var similarGameListResult: Result<GameList, NetworkError>?

    func getGameList() async -> Result<GameList, NetworkError> {
        return gameListResult ?? .failure(.unknown)
    }

    func getSimilarGameList(ids: [Int]) async -> Result<GameList, NetworkError> {
        return similarGameListResult ?? .failure(.unknown)
    }
}
