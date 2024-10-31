//
//  ResponseParserTests.swift
//  Network
//
//  Created by Glny Gl on 27/10/2024.
//

import XCTest
@testable import Network

final class ResponseParserTests: XCTestCase {
    var responseParser: ResponseParser!
    
    override func setUp() {
        super.setUp()
        responseParser = ResponseParser()
    }
    
    override func tearDown() {
        responseParser = nil
        super.tearDown()
    }
    
    func test_parseResponse_success() {
        
        let jsonData = Data("{\"id\": 1, \"name\": \"A\"}".utf8)
        
        do {
            let result: MockModel = try responseParser.parseResponse(data: jsonData, responseType: MockModel.self)
            XCTAssertEqual(result.id, 1)
            XCTAssertEqual(result.name, "A")
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_parseResponse_fail_typeMismatch() {
        
        let jsonData = Data("{\"id\": \"1\", \"name\": \"A\"}".utf8)
        
        do {
            let result: MockModel = try responseParser.parseResponse(data: jsonData, responseType: MockModel.self)
            XCTAssertNil(result)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
