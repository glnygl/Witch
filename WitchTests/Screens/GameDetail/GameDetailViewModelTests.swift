//
//  GameDetailViewModelTests.swift
//  WitchTests
//
//  Created by Glny Gl on 20/10/2024.
//

import XCTest
@testable import Witch

final class GameDetailViewModelTests: XCTestCase {
    
    var viewModel: GameDetailViewModel!
    var mockService: MockGameListService!
    var mockURLOpener: MockURLOpener!
    
    var game: Game!
    var similarGames: [Game]!
    
    override func setUp() {
        super.setUp()
        mockService = MockGameListService()
        mockURLOpener = MockURLOpener()
        game = Game(id: 1, name: "Game", cover: nil, url: "www.google.com", storyline: nil, summary: nil, rating: 94.0, similarGameIds: nil)
        similarGames = [Game(id: 2, name: "Similar", cover: nil, url: nil, storyline: nil, summary: nil, rating: nil, similarGameIds: nil)]
        viewModel = GameDetailViewModel(service: mockService, game: game, urlOpener: mockURLOpener)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        game = nil
        similarGames = nil
        super.tearDown()
    }
    
    func test_fetchSimilarGameList_success() async {
        
        mockService.similarGameListResult = .success(similarGames)
        await viewModel.fetchSimilarGameList(ids: [2])
        
        XCTAssertEqual(viewModel.gameList.count, 1)
        XCTAssertEqual(viewModel.gameList.first?.name, "Similar")
    }
    
    
    func test_fetchSimilarGameList_fail() async {
        
        mockService.similarGameListResult = .failure(.clientError)
        await viewModel.fetchSimilarGameList(ids: [2])
        
        XCTAssertTrue(viewModel.gameList.isEmpty)
    }
    
    func test_openUrl_true() {
        
        mockURLOpener.canOpenURLResult = true
        viewModel.openURL(urlString: game.url)
        
        XCTAssertTrue(mockURLOpener.openURLCalled)
    }
    
    func test_openUrl_false() {
        
        mockURLOpener.canOpenURLResult = false
        viewModel.openURL(urlString: "//")
        
        XCTAssertFalse(mockURLOpener.openURLCalled)
    }
    
    
    func test_openUrl_nil() {
        
        viewModel.openURL(urlString: similarGames.first?.url)
        XCTAssertFalse(mockURLOpener.openURLCalled)
    }
    
    func test_convertRating_true() {

         let rating = viewModel.convertStarRating()
         XCTAssertEqual(rating, 4.7)
     }
     
     func test_convertRating_nil() {
         
         let game = Game(id: 1, name: "Game", cover: nil, url: nil, storyline: nil, summary: nil, rating: nil, similarGameIds: nil)
         viewModel = GameDetailViewModel(service: mockService, game: game, urlOpener: mockURLOpener)
         let rating = viewModel.convertStarRating()
         
         XCTAssertEqual(rating, 0.0)
     }
    
}
