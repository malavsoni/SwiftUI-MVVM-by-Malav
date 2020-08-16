//
//  CoreDataManagerTests.swift
//  Tests iOS
//
//  Created by Malav Soni on 16/08/20.
//

import XCTest
@testable import SwiftUI_MVVM_Sample

class CoreDataManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRemoveLocation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(CoreDataManager.shared.removeAllLocationInfo(), "Should remove previous locations.")
    }
    func testInsertLocation() throws {

        CoreDataManager.shared.removeAllLocationInfo()

        let location = MSLocation()
        location.latitude = 23
        location.longitude = 72
        location.city = "Ahmedabad"
        location.country = "India"

        let response = OWResponse()
        response.timezone = "india"
        response.latitude = 23
        response.longitude = 72

        let hourly = OWHourly()
        hourly.humidity = 10
        hourly.timestamp = 1589720413
        hourly.temperature = 10.0
        hourly.humidity = 10.0
        hourly.windSpeed = 10

        let weather = OWWeather()
        weather.icon = "10n"
        hourly.weather = Set<OWWeather>.init([weather])

        let rain = OWRain()
        rain.chances = 0.1
        hourly.rain = rain

        response.hourly = [hourly]
        location.weatherInfo = response
        location.save()

        let result = CoreDataManager.shared.fetchLastLocationInfo()
        switch result {
        case .success(let location):
            XCTAssert(location.weatherInfo != nil, "Weather info should be returned")
            XCTAssert(location.weatherInfo?.hourly?.count == 1, "Hourly info should return 1 count")
        case .failure(let error):
            XCTFail("Result should return valid value not error \(error)")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
