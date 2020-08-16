//
//  OWResponse+CoreDataProperties.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

extension OWResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OWResponse> {
        return NSFetchRequest<OWResponse>(entityName: "OWResponse")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var timezone: String?
    @NSManaged public var hourly: Set<OWHourly>?
    @NSManaged public var daily: Set<OWDaily>?

    var orderedHourly:[OWHourly] {
        hourly?.sorted(by: { (left, right) -> Bool in
            return left.timestamp < right.timestamp
        }) ?? []
    }
}

// MARK: Generated accessors for hourly
extension OWResponse {

    @objc(addHourlyObject:)
    @NSManaged public func addToHourly(_ value: OWHourly)

    @objc(removeHourlyObject:)
    @NSManaged public func removeFromHourly(_ value: OWHourly)

    @objc(addHourly:)
    @NSManaged public func addToHourly(_ values: Set<OWHourly>)

    @objc(removeHourly:)
    @NSManaged public func removeFromHourly(_ values: Set<OWHourly>)

}

// MARK: Generated accessors for daily
extension OWResponse {

    @objc(addDailyObject:)
    @NSManaged public func addToDaily(_ value: OWDaily)

    @objc(removeDailyObject:)
    @NSManaged public func removeFromDaily(_ value: OWDaily)

    @objc(addDaily:)
    @NSManaged public func addToDaily(_ values: Set<OWDaily>)

    @objc(removeDaily:)
    @NSManaged public func removeFromDaily(_ values: Set<OWDaily>)

}
