//
//  MSLocation+CoreDataClass.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MSLocation)
public class MSLocation: NSManagedObject {
    enum CodingKeys: String, CodingKey {
       case latitude
       case longitude
       case city
       case country
       case date
        case weatherInfo
    }

    init() {
        super.init(entity: NSEntityDescription.entity(forEntityName: String.init(describing: MSLocation.self), in: CoreDataManager.shared.persistentContainer.viewContext)!, insertInto: CoreDataManager.shared.persistentContainer.viewContext)
        self.date = Date()
    }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {

        self.init()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? "N/A"
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? "N/A"
        self.date = try container.decodeIfPresent(Date.self, forKey: .date) ?? Date()
        self.weatherInfo = try container.decodeIfPresent(OWResponse.self, forKey: .weatherInfo)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(city, forKey: .city)
        try container.encode(country, forKey: .country)
        try container.encode(date, forKey: .date)
        try container.encode(weatherInfo, forKey: .weatherInfo)
    }
}
