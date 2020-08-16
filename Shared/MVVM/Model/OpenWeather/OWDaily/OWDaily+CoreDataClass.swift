//
//  OWDaily+CoreDataClass.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

@objc(OWDaily)
public class OWDaily: NSManagedObject,Codable {

    enum CodingKeys: String, CodingKey {
        case timestamp = "dt"
        case temp = "temp"
    }

    init() {
        super.init(entity: NSEntityDescription.entity(forEntityName: String.init(describing: OWDaily.self), in: CoreDataManager.shared.persistentContainer.viewContext)!, insertInto: CoreDataManager.shared.persistentContainer.viewContext)
    }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {

        self.init()

        let values = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try values.decodeIfPresent(Double.self, forKey: .timestamp) ?? 0
        temp = try values.decodeIfPresent(OWTemp.self, forKey: .temp)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(temp, forKey: .temp)
    }
}
