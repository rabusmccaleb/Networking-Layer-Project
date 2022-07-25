//
//  mealAPI.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import Foundation

enum MealAPI : EndPointType {
    case getMeals
    case getDessertDetail(idMeal : String)
    
    var baseURL: URL {
        guard let baseUrl = URL(string: "https://www.themealdb.com") else {fatalError("baseURL could not be configured.")}
        return baseUrl
    }
    
    var path: String {
        switch self {
            case .getMeals :
                return String("/api/json/v1/1/filter.php")
            case .getDessertDetail(_) :
                return String("/api/json/v1/1/lookup.php")
        }
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.get
    }
    
    var task: HTTPTask {
        switch self {
            case .getMeals :
                return HTTPTask.requestParameters(bodyParameters: nil, urlParameters: ["c": "Dessert"])
            case .getDessertDetail(let idMeal) :
                return HTTPTask.requestParameters(bodyParameters: nil, urlParameters: ["i": idMeal])
        }
    }
    
    var headers: HTTPHeaders? {
        return [ requestValue.type.rawValue : requestValue.jsonValue.rawValue]
    }
    
}
