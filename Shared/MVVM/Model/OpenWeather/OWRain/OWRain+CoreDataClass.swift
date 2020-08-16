//
//  OWRain+CoreDataClass.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//
//

import Foundation
import CoreData

@objc(OWRain)
public class OWRain: NSManagedObject,Codable {

    enum CodingKeys: String, CodingKey {
        case chances = "1h"
        case id
    }

    init() {
        super.init(entity: NSEntityDescription.entity(forEntityName: String.init(describing: OWRain.self), in: CoreDataManager.shared.persistentContainer.viewContext)!, insertInto: CoreDataManager.shared.persistentContainer.viewContext)
    }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chances = try values.decodeIfPresent(Double.self, forKey: .chances)!
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(chances, forKey: .chances)
    }
}
