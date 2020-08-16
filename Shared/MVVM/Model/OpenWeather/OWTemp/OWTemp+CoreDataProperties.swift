//
//  OWTemp+CoreDataProperties.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

extension OWTemp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OWTemp> {
        return NSFetchRequest<OWTemp>(entityName: "OWTemp")
    }

    @NSManaged public var day: Double
    @NSManaged public var min: Double
    @NSManaged public var max: Double
    @NSManaged public var night: Double
    @NSManaged public var eve: Double
    @NSManaged public var morn: Double

}
