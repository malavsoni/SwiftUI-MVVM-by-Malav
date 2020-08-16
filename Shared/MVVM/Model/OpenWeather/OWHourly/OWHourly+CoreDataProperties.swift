//
//  OWHourly+CoreDataProperties.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

extension OWHourly {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OWHourly> {
        return NSFetchRequest<OWHourly>(entityName: "OWHourly")
    }

    @NSManaged public var timestamp: Double
    @NSManaged public var temperature: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var humidity: Double
    @NSManaged public var rain: OWRain?
    @NSManaged public var weather: Set<OWWeather>?

}

// MARK: Generated accessors for weather
extension OWHourly {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: OWWeather)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: OWWeather)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}
