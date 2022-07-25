//
//  URLParameterEncoder.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import Foundation

public struct URLParameterEncoder : ParametersEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value : "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: requestValue.type.rawValue) == nil {
            urlRequest.setValue(requestValue.webPageValue.rawValue, forHTTPHeaderField: requestValue.type.rawValue)
        }
    }
}

