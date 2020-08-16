//
//  OWTemp+CoreDataClass.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

@objc(OWTemp)
public class OWTemp: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case id = ""
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }

    init() {
       super.init(entity: NSEntityDescription.entity(forEntityName: String.init(describing: OWTemp.self), in: CoreDataManager.shared.persistentContainer.viewContext)!, insertInto: CoreDataManager.shared.persistentContainer.viewContext)
   }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {

        self.init()

        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Double.self, forKey: .day) ?? 0.0
        min = try values.decodeIfPresent(Double.self, forKey: .min) ?? 0.0
        max = try values.decodeIfPresent(Double.self, forKey: .max) ?? 0.0
        night = try values.decodeIfPresent(Double.self, forKey: .night) ?? 0.0
        eve = try values.decodeIfPresent(Double.self, forKey: .eve) ?? 0.0
        morn = try values.decodeIfPresent(Double.self, forKey: .morn) ?? 0.0
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(day, forKey: .day)
        try container.encode(min, forKey: .min)
        try container.encode(max, forKey: .max)
        try container.encode(night, forKey: .night)
        try container.encode(eve, forKey: .eve)
        try container.encode(morn, forKey: .morn)
    }
}
