//
//  Meal.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/10/22.
//

import Foundation

struct Meal {
    let idMeal : String?
    let strMeal : String?
    let strMealThumb : String?
}

extension Meal : Decodable {
    private enum MealDataCodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MealDataCodingKeys.self)
        idMeal = try container.decodeIfPresent(String.self, forKey: .idMeal)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
    }
}
