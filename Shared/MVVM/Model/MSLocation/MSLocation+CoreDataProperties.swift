//
//  MSLocation+CoreDataProperties.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

extension MSLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MSLocation> {
        return NSFetchRequest<MSLocation>(entityName: "MSLocation")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var date: Date?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var weatherInfo: OWResponse?

}
