//
//  HourlyViewModelTests.swift
//  Tests iOS
//
//  Created by Malav Soni on 16/08/20.
//

import XCTest
@testable import SwiftUI_MVVM_Sample

class HourlyViewModelTests: XCTestCase {
    func testModel_Positive() {
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

        let viewModel = HourlyViewModel.init(withModel: hourly)

        XCTAssert(viewModel.temprature == "10", "Temprature should be 10")
        XCTAssert(viewModel.icon == "weather-clouds", "Should show rain icon")
        XCTAssert(viewModel.time == "18:30", "Time should be 13:00 insted of \(viewModel.time)")

        XCTAssert(viewModel.precipitation.value == "10%", "Precipitation should be 10%")
        XCTAssert(viewModel.windy.value == "36 km/h", "Wind speed should be 36 km/h")
        XCTAssert(viewModel.humidity.value == "10%", "Humidity should be 10%")
    }
}
