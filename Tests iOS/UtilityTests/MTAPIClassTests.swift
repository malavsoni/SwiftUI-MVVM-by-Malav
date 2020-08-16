//
//  MTAPIClassTests.swift
//  Tests iOS
//
//  Created by Malav Soni on 16/08/20.
//

import XCTest
@testable import SwiftUI_MVVM_Sample

class MTAPIClassTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherAPIPositive() {
        let expectation = XCTestExpectation.init(description: "API Call Success")

        MTAPIClient.shared.getWeatherInfo(
        forLatitude: 23,
        andLongtitude: 72,
        expectedClass: OWResponse.self) {(result) in
            switch result {
            case .success(let response):
                XCTAssert(response.hourly != nil, "API Should return hourly data")
                XCTAssert(response.daily != nil, "API Should return daily data")
                XCTAssert(MSLocationManager.shared.isValid(latitude: response.latitude, andLongitude: response.longitude), "Coordinate should be valid")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error, "Error should not return")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testWeatherAPI_InvalidInput() {
        let expectation = XCTestExpectation.init(description: "InvalidInput")

        MTAPIClient.shared.getWeatherInfo(
        forLatitude: 91,
        andLongtitude: 90,
        expectedClass: OWResponse.self) { (result) in
            switch result {
            case .success:
                XCTFail("Should return error")
            case .failure(let error):
                switch error {
                case MTOpenWeatherAPIClientError.invalidParameters:
                    expectation.fulfill()
                default:
                    XCTFail("Error should return invalid parameters")
                }
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
