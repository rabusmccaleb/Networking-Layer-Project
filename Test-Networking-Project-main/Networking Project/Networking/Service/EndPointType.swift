//
//  EndPointType.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import Foundation

protocol EndPointType {
    var baseURL : URL { get }
    var path : String { get }
    var httpMethod : HTTPMethod { get }
    var task : HTTPTask { get }
    var headers : HTTPHeaders? { get }
}
