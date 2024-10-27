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
        
        let result: Result<MockModel, NetworkError> = responseParser.parseResponse(data: jsonData, responseType: MockModel.self)
        
        switch result {
        case .success(let model):
            XCTAssertEqual(model.id, 1)
            XCTAssertEqual(model.name, "A")
        case .failure:
            XCTFail("parse error")
        }
    }
    
    func test_parseResponse_fail_typeMismatch() {
        let jsonData = Data("{\"id\": \"1\", \"name\": \"A\"}".utf8)
        
        let result: Result<MockModel, NetworkError> = responseParser.parseResponse(data: jsonData, responseType: MockModel.self)
        
        switch result {
        case .success:
            XCTFail("error")
        case .failure(let error):
            if case .parse(let message) = error {
                XCTAssertEqual(message, "Type mismatch error")
            }
        }
    }
}
