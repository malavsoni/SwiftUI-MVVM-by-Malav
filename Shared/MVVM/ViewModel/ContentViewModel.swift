//
//  ContentViewModel.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

//import UIKit
import SwiftUI
import Combine

private protocol ContentViewModelInput:class {
    func fetchLocation()
    func fetchWeatherInfo()
}

class ContentViewModel: ObservableObject, ContentViewModelInput {

    // MARK: - Published Properties
    @Published private(set) var locationInfo:MSLocation?
    @Published private(set) var errorMessage:String?
    @Published var selectedHourIndex:Int = 0

    // MARK: - Properties
    var city:String {
        if (locationInfo != nil) {
            return locationInfo?.city ?? ""
        } else {
            return "N/A"
        }
    }
    var country:String {
        if (locationInfo != nil) {
            return locationInfo?.country ?? ""
        } else {
            return "N/A"
        }
    }
    var currentDate:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
    var hourlyInfo:[HourlyViewModel] = []
    var selectedHourInfo:HourlyViewModel? {
        return !hourlyInfo.isEmpty ? hourlyInfo[selectedHourIndex] : nil
    }

    /// Fetch current location 
    func fetchLocation() {
        if MTAPIClient.isInternetAvailable == false {
            self.fetchFromLocalStorage()
        } else {
            MSLocationManager.shared.start {  (result) in
                switch result {
                case .success(let info):
                    OperationQueue.main.addOperation {
                        self.errorMessage = nil
                        self.locationInfo = info
                        self.fetchWeatherInfo()
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    /// Fetch weather based on location
    func fetchWeatherInfo() {
        MTAPIClient.shared.getWeatherInfo(
            forLatitude: locationInfo?.latitude,
            andLongtitude: locationInfo?.longitude,
            expectedClass: OWResponse.self) {(result) in
            switch result {
            case .success(let weatherInfo):
                OperationQueue.main.addOperation {
                    self.hourlyInfo = self.getHourlyInfoModel(fromInfo: weatherInfo)
                    self.locationInfo?.weatherInfo = weatherInfo
                    self.selectedHourIndex = 0
                    self.errorMessage = nil
                    CoreDataManager.shared.saveContext()
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.fetchFromLocalStorage()
            }
        }
    }

    func fetchFromLocalStorage() {
        let result = CoreDataManager.shared.fetchLastLocationInfo()
        switch result {
        case .success(let location):
            if let weatherInfo = location.weatherInfo {
                self.hourlyInfo = self.getHourlyInfoModel(fromInfo: weatherInfo)
            }
            if !MTAPIClient.isInternetAvailable {
                self.errorMessage = ErrorMessages.youAreOffline
            }
            self.locationInfo = location
        case .failure(let error):
            self.errorMessage = "\(error.localizedDescription)\(MTAPIClient.isInternetAvailable ? "" : "\n\(ErrorMessages.youAreOffline)")"
        }
    }

    private func getHourlyInfoModel(fromInfo weatherInfo:OWResponse) -> [HourlyViewModel] {
        return weatherInfo.orderedHourly.map({ (hourly) -> HourlyViewModel in
            return HourlyViewModel.init(withModel: hourly)
        })
    }
}
