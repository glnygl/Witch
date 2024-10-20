//
//  GameListViewModelTests.swift
//  WitchTests
//
//  Created by Glny Gl on 20/10/2024.
//

import XCTest
@testable import Witch

final class GameListViewModelTests: XCTestCase {
    
    var viewModel: GameListViewModel!
    var mockService: MockGameListService!
    var mockPersistenceController: MockPersistenceController!
    
    var games: [Game]!
    var cachedGames: [Game]!
    
    override func setUp() {
        super.setUp()
        mockService = MockGameListService()
        mockPersistenceController = MockPersistenceController()
        viewModel = GameListViewModel(service: mockService, persistenceController: mockPersistenceController)
        games = [Game(id: 1, name: "Game", cover: nil, url: nil, storyline: nil, summary: nil, rating: nil, similarGameIds: nil)]
        cachedGames = [Game(id: 1, name: "Cached game", cover: nil, url: nil, storyline: nil, summary: nil, rating: nil, similarGameIds: nil)]
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockPersistenceController = nil
        games = nil
        cachedGames = nil
        super.tearDown()
    }
    
    func test_fetchGameList_success() async {
        
        mockService.gameListResult = .success(games)
        let result = await viewModel.fetchGameList()
        
        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?.first?.name, "Game")
    }
    
    func test_fetchGameList_fail() async {
        
        mockService.gameListResult = .failure(.clientError)
        let result = await viewModel.fetchGameList()
        
        XCTAssertNil(result)
        XCTAssertTrue(viewModel.gameList.isEmpty)
    }
    
    func test_getGameData_getFromCache() async {
        
        mockPersistenceController.cachedGames = cachedGames
        await viewModel.getGameData()
        
        XCTAssertEqual(viewModel.gameList.count, 1)
        XCTAssertEqual(viewModel.gameList.first?.name, "Cached game")
        XCTAssertFalse(mockPersistenceController.saveCalled)
    }
    
    func test_getGameData_saveToCache() async {
        
        mockService.gameListResult = .success(games)
        mockPersistenceController.cachedGames = nil
        await viewModel.getGameData()
        
        XCTAssertEqual(viewModel.gameList.count, 1)
        XCTAssertEqual(viewModel.gameList.first?.name, "Game")
        XCTAssertTrue(mockPersistenceController.saveCalled)
    }
    
    func test_getGameData_saveToCache_whenFetchGamesError() async {
        
        mockService.gameListResult = .failure(.clientError)
        mockPersistenceController.cachedGames = nil
        await viewModel.getGameData()
        
        XCTAssertEqual(viewModel.gameList.count, 0)
        XCTAssertTrue(mockPersistenceController.saveCalled)
    }
    
}
