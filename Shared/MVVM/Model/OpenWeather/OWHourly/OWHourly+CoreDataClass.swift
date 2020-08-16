//
//  OWHourly+CoreDataClass.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

@objc(OWHourly)
public class OWHourly: NSManagedObject,Codable {
    enum CodingKeys: String, CodingKey {
        case weather
        case timestamp = "dt"
        case temperature = "temp"
        case windSpeed = "wind_speed"
        case humidity
        case rain
        case id
    }

    init() {
        super.init(entity: NSEntityDescription.entity(forEntityName: String.init(describing: OWHourly.self), in: CoreDataManager.shared.persistentContainer.viewContext)!, insertInto: CoreDataManager.shared.persistentContainer.viewContext)

    }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {

        self.init()

        let values = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try values.decodeIfPresent(Double.self, forKey: .timestamp)!
        temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)!
        weather = try values.decodeIfPresent(Set<OWWeather>.self, forKey: .weather)!
        windSpeed = try values.decodeIfPresent(Double.self, forKey: .windSpeed)!
        humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)!
        rain = try values.decodeIfPresent(OWRain.self, forKey: .rain)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(weather, forKey: .weather)
        try container.encode(windSpeed, forKey: .windSpeed)
        try container.encode(humidity, forKey: .humidity)
        try container.encode(rain, forKey: .rain)
    }
}
