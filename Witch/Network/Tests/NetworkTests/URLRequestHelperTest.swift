//
//  URLRequestHelperTest.swift
//  Network
//
//  Created by Glny Gl on 25/10/2024.
//

import XCTest
@testable import Network

final class URLRequestHelperTest: XCTestCase {
    
    var urlRequestHelper: URLRequestHelper!
    
    override func setUp() {
        super.setUp()
        urlRequestHelper = URLRequestHelper()
    }
    
    override func tearDown() {
        urlRequestHelper = nil
        super.tearDown()
    }
    
    func test_makeURLRequest_success() {
        let request = MockRequest()
        do {
            let urlRequest = try urlRequestHelper.makeURLRequest(requestable: request)
            XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.igdb.com/v4/games")
            XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_makeURLRequest_withParams_success() {
        var request = MockRequest()
        request.parameters = "limit=20"
        let paramsData = request.parameters?.data(using: .utf8)
        do {
            let urlRequest = try urlRequestHelper.makeURLRequest(requestable: request)
            XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.igdb.com/v4/games")
            XCTAssertEqual(urlRequest.httpBody, paramsData)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
