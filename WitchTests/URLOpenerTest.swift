//
//  URLOpenerTest.swift
//  WitchTests
//
//  Created by Glny Gl on 19/10/2024.
//

import XCTest
@testable import Witch

final class URLOpenerTest: XCTestCase {
    
    private var mockOpener: MockURLOpener!
    private var game: Game!
    
    override func setUp() {
        super.setUp()
        mockOpener = MockURLOpener()
        game = Game(id: 1, name: "A", cover: nil, url: nil, storyline: nil, summary: nil, rating: nil, similarGameIds: nil)
    }
    
    override func tearDown() {
        mockOpener = nil
        game = nil
        super.tearDown()
    }

    func test_canOpenURL_true() {
        
        mockOpener.canOpenURLReturnValue = true
        let viewModel = GameDetailViewModel(service: GameListService(), game: game, urlOpener: mockOpener)
        
        viewModel.openURL(urlString: "www.google.com")
        
        XCTAssertTrue(mockOpener.canOpenURLCalled)
        XCTAssertTrue(mockOpener.openURLCalled)
    }
    
    func test_canOpenURL_false() {
        
        mockOpener.canOpenURLReturnValue = false
        let viewModel = GameDetailViewModel(service: GameListService(), game: game, urlOpener: mockOpener)
        
        viewModel.openURL(urlString: "//")
        
        XCTAssertTrue(mockOpener.canOpenURLCalled)
        XCTAssertFalse(mockOpener.openURLCalled)
    }


}
