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
    
    override func setUp() {
        super.setUp()
        mockOpener = MockURLOpener()
    }
    
    override func tearDown() {
        mockOpener = nil
        super.tearDown()
    }

    func test_canOpenURL_true() {
        
        mockOpener.canOpenURLReturnValue = true
        let viewModel = GameDetailViewModel(urlOpener: mockOpener)
        
        viewModel.openURL(urlString: "www.google.com")
        
        XCTAssertTrue(mockOpener.canOpenURLCalled)
        XCTAssertTrue(mockOpener.openURLCalled)
    }
    
    func test_canOpenURL_false() {
        
        mockOpener.canOpenURLReturnValue = false
        let viewModel = GameDetailViewModel(urlOpener: mockOpener)
        
        viewModel.openURL(urlString: "//")
        
        XCTAssertTrue(mockOpener.canOpenURLCalled)
        XCTAssertFalse(mockOpener.openURLCalled)
    }


}
