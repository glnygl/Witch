//
//  ImageURLTests.swift
//  Witch
//
//  Created by Glny Gl on 25/10/2024.
//

import XCTest
@testable import Witch

final class ImageURLTests: XCTestCase {
    
    func test_imageURL_withScheme() {
        let url = "https://images.igdb.com/t_thumb/1.jpg"
        
        let listURL = GameScreens.list.url(string: url)
        let detailURL = GameScreens.detail.url(string: url)
        
        XCTAssertEqual(listURL?.absoluteString, "https://images.igdb.com/t_cover_big/1.jpg")
        XCTAssertEqual(detailURL?.absoluteString, "https://images.igdb.com/t_720p/1.jpg")
    }
    
    func test_imageURL_withoutScheme() {
        let url = "//images.igdb.com/t_thumb/1.jpg"
        
        let listURL = GameScreens.list.url(string: url)
        let detailURL = GameScreens.detail.url(string: url)
        
        XCTAssertEqual(listURL?.absoluteString, "https://images.igdb.com/t_cover_big/1.jpg")
        XCTAssertEqual(detailURL?.absoluteString, "https://images.igdb.com/t_720p/1.jpg")
    }
}
