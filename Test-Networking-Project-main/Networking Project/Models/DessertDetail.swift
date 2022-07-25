//
//  DessertDetail.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/10/22.
//

import Foundation

struct DessertDetail : Decodable {
    let idMeal : String
    let strMeal : String?
    let strDrinkAlternate : String?
    let strCategory : String?
    let strArea : String?
    let strInstructions : String?
    let strMealThumb : String?
    let strTags : String?
    let strYoutube : String?
    var ingredients : [String]?
    var measurement : [String]?

    private enum desserDataCodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
    }
    
    private struct DynamicDessertCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: desserDataCodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        
        var ingredientsList = [String]()
        var measurementList = [String]()
        let dynamicContainer = try decoder.container(keyedBy: DynamicDessertCodingKeys.self)
        for key in dynamicContainer.allKeys {
            if key.stringValue.contains("strIngredient") {
                    
                let decodedObject = try dynamicContainer.decodeIfPresent(String.self, forKey: DynamicDessertCodingKeys(stringValue: key.stringValue)!)
                if let decodedObjectValue = decodedObject, !decodedObjectValue.isEmptyOrWhitespace  {
                    ingredientsList.append(String(decodedObjectValue))
                    self.ingredients = ingredientsList
                }
                
            } else if key.stringValue.contains("strMeasure") {
                
                let decodedObject = try dynamicContainer.decodeIfPresent(String.self, forKey: DynamicDessertCodingKeys(stringValue: key.stringValue)!)
                if let decodedObjectValue = decodedObject, !decodedObjectValue.isEmptyOrWhitespace {
                    measurementList.append(String(decodedObjectValue))
                    self.measurement = measurementList
                }
             
            }
        }
    }
}
