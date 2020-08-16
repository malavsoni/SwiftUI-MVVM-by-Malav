//
//  OWDaily+CoreDataProperties.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

extension OWDaily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OWDaily> {
        return NSFetchRequest<OWDaily>(entityName: "OWDaily")
    }

    @NSManaged public var timestamp: Double
    @NSManaged public var temp: OWTemp?

}
