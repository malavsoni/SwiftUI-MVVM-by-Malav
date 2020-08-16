//
//  OWResponse+CoreDataClass.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

@objc(OWResponse)
public class OWResponse: NSManagedObject,Codable {

    enum CodingKeys: String, CodingKey {

        case latitude = "lat"
        case longitude = "lon"
        case timezone = "timezone"
        case hourly
        case daily
        case id
    }

    init() {
        super.init(entity: NSEntityDescription.entity(forEntityName: String.init(describing: OWResponse.self), in: CoreDataManager.shared.persistentContainer.viewContext)!, insertInto: CoreDataManager.shared.persistentContainer.viewContext)
    }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {

        self.init()

        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)!
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)!
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)!
        hourly = try values.decodeIfPresent(Set<OWHourly>.self, forKey: .hourly) ?? []
        daily = try values.decodeIfPresent(Set<OWDaily>.self, forKey: .daily) ?? []
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(timezone, forKey: .timezone)
        try container.encode(hourly, forKey: .hourly)
        try container.encode(daily, forKey: .daily)
    }
}
