//
//  MockGameListService.swift
//  WitchTests
//
//  Created by Glny Gl on 20/10/2024.
//

import XCTest
@testable import Witch
@testable import Network

class MockGameService: GameServiceProtocol {
    
    var gameListResult: GameList?
    var similarGameListResult: GameList?
    var gameDetailResult: GameList?
    
    func getGameList() async throws (NetworkError) -> GameList {
        guard let gameListResult = gameListResult else {
            throw NetworkError.unknown
        }
        return gameListResult
    }
    
    func getSimilarGameList(ids: [Int]) async throws (NetworkError) -> GameList {
        guard let similarGameListResult = similarGameListResult else {
            throw NetworkError.unknown
        }
        return similarGameListResult
    }
    
    func getGameDetail(id: Int) async throws(NetworkError) -> GameList {
        guard let gameDetailResult = gameDetailResult else {
            throw NetworkError.unknown
        }
        return gameDetailResult
    }
}
