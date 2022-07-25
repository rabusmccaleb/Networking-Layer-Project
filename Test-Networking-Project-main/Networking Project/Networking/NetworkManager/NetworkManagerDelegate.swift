//
//  NetworkManagerDelegate.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/10/22.
//

import Foundation

typealias returnType = ([DessertDetail]? , String? )

protocol NetworkManagerDelegate  {
    
    var router: Router<MealAPI> { get }
        
    func getDesserts(completion : @escaping ( _ desserts : [Meal]? , _ error: String?) ->() )
    
    func getDessertsDetails( mealID : String , completion : @escaping (_ dessert : [DessertDetail]? , _ error: String? ) -> ())
    
}

enum NetworkResponse : String {
    case success
    case authenticationError = "You are unauthorized to make this request"
    case badRequest = "Bad Request"
    case outdated = "The URL you requested is out of date"
    case failed = "Network Request Faild"
    case noData = "Response returned with not data"
    case unableToDecode = "Response could not be decoded."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager : NetworkManagerDelegate {
    
    var router = Router<MealAPI>()
    
    func getDesserts(completion : @escaping (_ desserts : [Meal]? , _ error: String? ) ->()) {
        router.request(.getMeals) { data , response , error in
            if error != nil {
                completion(nil, "Please check your network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success :
                    guard let repsonseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        
                        let dataResponse = try JSONDecoder().decode(Meals.self, from: repsonseData )
                        return completion(dataResponse.meals, nil)
                        
                    }catch{
                        
                        return completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getDessertsDetails( mealID : String , completion : @escaping (_ dessert : [DessertDetail]? , _ error: String? ) -> () ) {
        router.request(.getDessertDetail(idMeal: mealID)) { data , response , error in
            if error != nil {
                completion(nil, "Please check your network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success :
                    guard let repsonseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        
                        let dataResponse = try JSONDecoder().decode(Dessert.self, from: repsonseData )
                        return completion(dataResponse.meals, nil)
                        
                    }catch{
                        
                        return completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
    fileprivate func handleNetworkResponse(_ response : HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299 : return .success
        case 401...500 : return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599 : return .failure(NetworkResponse.badRequest.rawValue)
        case 600 : return .failure(NetworkResponse.outdated.rawValue)
        default : return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
