//
//  MSLocationManager.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/08/20.
//

import Foundation
import CoreLocation

class MSLocationManager: NSObject {
    typealias LocationInfo = ((Result<MSLocation,Error>) -> Void)

    // Singlton Shared Instance
    static let shared:MSLocationManager = MSLocationManager()

    // Location Manager
    private var locationManager = CLLocationManager()
    private var completionHandler:LocationInfo?
    private let geocoder:CLGeocoder = CLGeocoder()

    // Init
    override private init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.requestWhenInUseAuthorization()
    }

    // Start Updating Location
    public func start(withHandler handler:@escaping LocationInfo) {
        if CLLocationManager.locationServicesEnabled() {
            self.completionHandler = handler
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        } else {
            handler(.failure(MTLocationManagerError.locationServiceDisable))
        }
    }

    public func isValid(latitude lat:Double,andLongitude long:Double) -> Bool {
        return CLLocationCoordinate2DIsValid(CLLocationCoordinate2DMake(lat, long))
    }

    private func getInfo(forLatitude lat:Double,andLongtitude long:Double,withHandler handler:@escaping LocationInfo) {
        let loc: CLLocation = CLLocation(latitude:lat, longitude: long)
        self.geocoder.reverseGeocodeLocation(loc) { (placemarks, _) in
            guard let placemarks = placemarks, let info = placemarks.first else {
                // Call completion handler here...
                handler(.failure(MTLocationManagerError.failedToGetLocationInfo))
                return
            }
            let locationInfo = MSLocation.init()
            locationInfo.latitude = lat
            locationInfo.longitude = long
            locationInfo.city = info.locality ?? "N/A"
            locationInfo.country = info.country ?? "N/A"
            locationInfo.save()
            handler(.success(locationInfo))
        }
    }
}

extension MSLocationManager:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            break
        case .denied:
            completionHandler?(.failure(MTLocationManagerError.requestDenied))
            completionHandler = nil
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionHandler?(.failure(MTLocationManagerError.failedToGetLocationInfo))
        completionHandler = nil
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location = locations.last {
            self.getInfo(forLatitude: location.coordinate.latitude, andLongtitude: location.coordinate.longitude, withHandler: {[weak self](result) in
                switch result {
                case .success(let location):
                    self?.completionHandler?(.success(location))
                case .failure(let error):
                    switch error {
                    case MTLocationManagerError.failedToGetLocationInfo:
                        let locationInfo = MSLocation()
                        locationInfo.latitude = location.coordinate.latitude
                        locationInfo.longitude = location.coordinate.longitude
                        self?.completionHandler?(.success(locationInfo))
                        self?.completionHandler = nil
                    default:
                        self?.completionHandler?(.failure(error))
                        self?.completionHandler = nil
                    }
                }
            })
        }
    }
}
