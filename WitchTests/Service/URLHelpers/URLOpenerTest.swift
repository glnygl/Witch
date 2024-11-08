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
    private var service: GameServiceProtocol!
    private var game: Game!
    
    override func setUp() {
        super.setUp()
        mockOpener = MockURLOpener()
        service = GameService()
        game = Game(id: 1, name: "A", cover: nil, url: nil, storyline: nil, summary: nil, rating: nil, similarGameIds: nil, videos: nil, slug: nil)
    }
    
    override func tearDown() {
        mockOpener = nil
        service = nil
        game = nil
        super.tearDown()
    }

    func test_canOpenURL_true() {
        
        mockOpener.canOpenURLResult = true
        let viewModel = GameDetailViewModel(service: service, game: game, urlOpener: mockOpener)
        
        viewModel.openURL(urlString: "www.google.com")
        
        XCTAssertTrue(mockOpener.canOpenURLCalled)
        XCTAssertTrue(mockOpener.openURLCalled)
    }
    
    func test_canOpenURL_false() {
        
        mockOpener.canOpenURLResult = false
        let viewModel = GameDetailViewModel(service: service, game: game, urlOpener: mockOpener)
        
        viewModel.openURL(urlString: "//")
        
        XCTAssertTrue(mockOpener.canOpenURLCalled)
        XCTAssertFalse(mockOpener.openURLCalled)
    }


}
