//
//  ContentViewModelTests.swift
//  Tests iOS
//
//  Created by Malav Soni on 16/08/20.
//

import XCTest
@testable import SwiftUI_MVVM_Sample

class ContentViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let model = ContentViewModel()
        XCTAssert(model.city == "N/A", "City should return N/A when data is not available")
        XCTAssert(model.country == "N/A", "Country should return N/A when data is not available")
        // Location and API Test Cases are writtin in respective tests classes
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
