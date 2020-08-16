//
//  HourlyViewModel.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import UIKit

struct AdditionalHourInfo {
    let name:String
    let value:String
}

class HourlyViewModel: NSObject {

    // Weather Icon Enum Possible Values
    private enum WeatherIcon:String {
        case clearSky = "01"
        case fewClouds = "02"
        case scatteredClouds = "03"
        case brokenCloud = "04"
        case showerRain = "09"
        case rain = "10"
        case thunderStorm = "11"
        case snow = "13"
        case mist = "50"

        func getImageName() -> String {
            switch self {
            case .clearSky:
                return "weather-sun"
            case .fewClouds,.scatteredClouds,.brokenCloud:
                return "weather-cloud"
            case .showerRain,.rain:
                return "weather-clouds"
            case .thunderStorm,.snow,.mist:
                return "weather-cloud-thunder-rain"
            }
        }
    }
    // MARK: - Private Properties
    private let model:OWHourly

    // MARK: - Init
    init(withModel model:OWHourly) {
        self.model = model
    }

    // MARK: - Properties
    var time:String {
        let date = Date(timeIntervalSince1970: model.timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    var temprature:String {
        "\(Int(self.model.temperature))"
    }

    var icon:String {
        if let name = model.weather?.first?.icon {
            if let icon = WeatherIcon.init(rawValue: String(name.dropLast())) {
                return icon.getImageName()
            }
        }
        return WeatherIcon.clearSky.getImageName()
    }

    var precipitation:AdditionalHourInfo {
        var value = 0
        if let rainChances = self.model.rain?.chances {
            value = Int(rainChances * 100)
        }
        return AdditionalHourInfo(name: Titles.precipitation, value: "\(Int(value))%")
    }
    var humidity:AdditionalHourInfo {
        return AdditionalHourInfo(name: Titles.humidity, value: "\(Int(self.model.humidity))%")
    }
    var windy:AdditionalHourInfo {
        return AdditionalHourInfo(name: Titles.windy, value: "\(Int(self.model.windSpeed.toKmPerHour())) km/h")
    }
}
