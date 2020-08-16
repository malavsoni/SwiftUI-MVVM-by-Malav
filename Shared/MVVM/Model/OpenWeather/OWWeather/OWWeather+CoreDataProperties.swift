//
//  OWWeather+CoreDataProperties.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

extension OWWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OWWeather> {
        return NSFetchRequest<OWWeather>(entityName: "OWWeather")
    }

    @NSManaged public var main: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var icon: String?

}
