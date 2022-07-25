//
//  JSONParameterEncoder.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import Foundation

public struct JSONParameterEncoder : ParametersEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: requestValue.type.rawValue) == nil {
                urlRequest.setValue(requestValue.jsonValue.rawValue, forHTTPHeaderField: requestValue.type.rawValue)
            }
        }catch{
            throw NetworkError.encodingFailed
        }
    }
}
