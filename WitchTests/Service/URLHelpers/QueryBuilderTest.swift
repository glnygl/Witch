//
//  QueryBuilderTest.swift
//  WitchTests
//
//  Created by Glny Gl on 20/10/2024.
//

import XCTest
@testable import Witch

final class QueryBuilderTest: XCTestCase {

    private var queryBuilder: QueryBuilder!
    
    override func setUp() {
        super.setUp()
        queryBuilder = QueryBuilder()
    }
    
    override func tearDown() {
        queryBuilder = nil
        super.tearDown()
    }
    
    func test_addLimit() {

        let queryString = queryBuilder
            .addLimit(3)
            .build()
        
        XCTAssertEqual(queryString, "\nlimit3;")
    }
    
    
    func test_addFields() {

        let queryString = queryBuilder
            .addField(.name)
            .addField(.cover)
            .build()
        
        XCTAssertEqual(queryString, "\nfields name,cover.url; ")
    }
    
    func test_addConditions() {

        let queryString = queryBuilder
            .addCondition(field: .id, operator: .notEqual, value: "null")
            .addCondition(field: .name, operator: .notEqual, value: "null")
            .build()
        
        XCTAssertEqual(queryString, "\nwhere id != null&name != null; ")
    }
    
    func test_addFieldAndCondition() {

        let queryString = queryBuilder
            .addField(.name)
            .addCondition(field: .id, operator: .notEqual, value: "null")
            .build()
        
        XCTAssertEqual(queryString, "\nfields name; \nwhere id != null; ")
    }
    
    func test_addLimitFieldAndCondition() {

        let queryString = queryBuilder
            .addField(.name)
            .addCondition(field: .id, operator: .notEqual, value: "null")
            .addLimit(3)
            .build()
        
        XCTAssertEqual(queryString, "\nfields name; \nwhere id != null; \nlimit3;")
    }

}
