//
//  MTAPIClient.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/08/20.
//

import Foundation
import Alamofire

class MTAPIClient: NSObject {

    // Singleton Class
    static let shared:MTAPIClient = MTAPIClient()

    // Privates
    fileprivate static let apiKey = "c81e452ef8a78be39dc840ff6cef9dbd"
    fileprivate static let baseUrl:String = "http://api.openweathermap.org/data/2.5/"

    enum Endpoint {
        case openWeather(lat:Double,long:Double)

        var url:URL? {
            switch self {
            case .openWeather(let lat, let long):
                return URL.init(string: "\(MTAPIClient.baseUrl)onecall?exclude=minutely,current&lat=\(lat)&lon=\(long)&units=metric&appid=\(MTAPIClient.apiKey)")
            }
        }
    }

    static var isInternetAvailable:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

// MARK: - Private Methods
extension MTAPIClient {
    private func callApi<T:Decodable>(withURL apiURL:URL,expectedClass:T.Type,methodType type:HTTPMethod = .get,parameters:[String:Any] = [:],headers:HTTPHeaders=[:],completion:((Result<T,Error>) -> Void)?) {

        // Check for internet
        guard MTAPIClient.isInternetAvailable else {
            completion?(.failure(MTOpenWeatherAPIClientError.internetNotAvailable))
            return
        }

        // Call the API
        AF.request(
            apiURL,
            method: .get,
            parameters: parameters,
            headers: headers
        ).responseData(completionHandler: { (dataResponse) in
            if let data = dataResponse.data {
                if let owResponse = try? JSONDecoder().decode(expectedClass.self,from: data) {
                  completion?(.success(owResponse))
                } else {
                    completion?(.failure(MTOpenWeatherAPIClientError.failedToParseResponse))
                }
            } else {
                if let error = dataResponse.error {
                  completion?(.failure(error))
                }
            }
        })
    }
}

// MARK: - APP API CALLS
extension MTAPIClient {
    func getWeatherInfo<T:Decodable>(forLatitude lat:Double?, andLongtitude long:Double?,expectedClass:T.Type, completion:((Result<T,Error>) -> Void)?) {

        // Validate Inputs
        guard
            let lat = lat,
            let long = long,
            MSLocationManager.shared.isValid(latitude: lat, andLongitude: long)
            else {
            completion?(.failure(MTOpenWeatherAPIClientError.invalidParameters))
            return
        }

        // Call the API
        if let apiURL = Endpoint.openWeather(lat: lat, long: long).url {
            self.callApi(withURL: apiURL, expectedClass: expectedClass, completion: completion)
        } else {
            completion?(.failure(MTOpenWeatherAPIClientError.invalidParameters))
        }
    }
}
