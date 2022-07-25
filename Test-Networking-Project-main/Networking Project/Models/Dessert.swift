//
//  dessert.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/10/22.
//

import Foundation

struct Dessert {
    let meals : [DessertDetail]
}

extension Dessert : Decodable {
    private enum desserDataCodingKeys: String, CodingKey {
        case meals
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: desserDataCodingKeys.self)
        meals = try container.decode([DessertDetail].self, forKey: .meals)
    }
}
