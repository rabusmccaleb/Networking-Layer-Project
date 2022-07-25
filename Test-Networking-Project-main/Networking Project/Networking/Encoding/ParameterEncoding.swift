//
//  ParameterEncoding.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import Foundation

public typealias Parameters = [ String : Any ]

public protocol ParametersEncoder {
    static func encode(urlRequest : inout URLRequest, with parameters : Parameters) throws
}
