//
//  OWWeather+CoreDataClass.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

@objc(OWWeather)
public class OWWeather: NSManagedObject,Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }

    init() {
        super.init(entity: NSEntityDescription.entity(forEntityName: String.init(describing: OWWeather.self), in: CoreDataManager.shared.persistentContainer.viewContext)!, insertInto: CoreDataManager.shared.persistentContainer.viewContext)
    }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {

        self.init()

        let values = try decoder.container(keyedBy: CodingKeys.self)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        weatherDescription = try values.decodeIfPresent(String.self, forKey: .weatherDescription)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(main, forKey: .main)
        try container.encode(weatherDescription, forKey: .weatherDescription)
        try container.encode(icon, forKey: .icon)
    }
}
