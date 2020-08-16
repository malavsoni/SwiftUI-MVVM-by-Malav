//
//  AppErrors.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/08/20.
//

import Foundation
enum MTLocationManagerError:Error,LocalizedError {
    case requestDenied
    case locationServiceDisable
    case failedToGetLocationInfo

    public var errorDescription: String? {
        switch self {
        case .requestDenied:
            return ErrorMessages.requestDenied
        case .failedToGetLocationInfo:
            return ErrorMessages.failedToGetLocationInfo
        case .locationServiceDisable:
            return ErrorMessages.locationServiceDisable
        }
    }
}

enum MTCoreDataError:Error,LocalizedError {
    case noDataAvailable

    public var errorDescription: String? {
        switch self {
        case .noDataAvailable:
            return ErrorMessages.noDataAvailable
        }
    }
}

enum MTOpenWeatherAPIClientError:Error,LocalizedError {
    case invalidParameters
    case failedToParseResponse
    case internetNotAvailable

    public var errorDescription: String? {
        switch self {
        case .invalidParameters:
            return ErrorMessages.invalidParameters
        case .failedToParseResponse:
            return ErrorMessages.failedToParseResponse
        case .internetNotAvailable:
            return ErrorMessages.internetNotAvailable
        }
    }
}
