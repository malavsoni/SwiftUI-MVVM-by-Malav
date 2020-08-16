//
//  MTLocationManagerTests.swift
//  Tests iOS
//
//  Created by Malav Soni on 16/08/20.
//

import XCTest
@testable import SwiftUI_MVVM_Sample

class MTLocationManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //
    func testLocationAPI_Positive() {
        let expectation = XCTestExpectation.init(description: "Location should return proper info")
        MSLocationManager.shared.start { (result) in
            switch result {
            case .success(let locationInfo):
                XCTAssert(MSLocationManager.shared.isValid(latitude: locationInfo.latitude, andLongitude: locationInfo.longitude), "Should return valid coordinate")
                XCTAssert(locationInfo.country != nil, "Country can not be nil")
                XCTAssert(locationInfo.city != nil, "City can not be nil")
                XCTAssert(locationInfo.date != nil, "Date can not be nil")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request must not return error : \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    /// When location is not available
    /// Steps to follow
    ///     1) Turn off location service from Settings
    ///     2) Run the test
    func testLocationAPI_LocationTurnOffFromSetting() {
        let expectation = XCTestExpectation.init(description: "Location Request Failed because location is turned off from settings.")
        MSLocationManager.shared.start { (result) in
            switch result {
            case .success:
                XCTFail("Should not return data when location is turn off from settings.")
            case .failure(let error):
                switch error {
                case MTLocationManagerError.locationServiceDisable:
                    expectation.fulfill()
                default:
                    XCTFail("Should return MTLocationManagerError.locationServiceDisable.")
                }
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

    /// When location is not available
    /// Steps to follow
    ///     1) Set location to none from simulator
    ///     2) Run the test
    func testLocationAPI_LocationNotAvailable() {
        let expectation = XCTestExpectation.init(description: "Location is not available.")
        MSLocationManager.shared.start { (result) in
            switch result {
            case .success:
                XCTFail("Should not return data when location is not available.")
            case .failure(let error):
                switch error {
                case MTLocationManagerError.locationServiceDisable,
                     MTLocationManagerError.failedToGetLocationInfo,
                     MTLocationManagerError.requestDenied:
                    XCTFail("Should return error from location manager")
                default:
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 20.0)
    }
}
