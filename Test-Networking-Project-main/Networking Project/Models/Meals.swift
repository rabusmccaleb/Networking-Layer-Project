//
//  meals.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/10/22.
//

import Foundation

struct Meals {
    let meals : [Meal]
}

extension Meals : Decodable {
    private enum MealsDataCodingKeys: String, CodingKey {
        case meals
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MealsDataCodingKeys.self)
        meals = try container.decode([Meal].self, forKey: .meals)
    }
}

