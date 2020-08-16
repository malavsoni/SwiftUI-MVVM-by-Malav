//
//  OWRain+CoreDataProperties.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

extension OWRain {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OWRain> {
        return NSFetchRequest<OWRain>(entityName: "OWRain")
    }

    @NSManaged public var chances: Double

}
