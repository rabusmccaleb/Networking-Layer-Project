//
//  HTTPTask.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import Foundation

public typealias HTTPHeaders = [ String : String ]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters : Parameters?, urlParameters : Parameters?)
    case requestParametersAndHeaders(bodyParameters : Parameters?, urlParameters : Parameters?, additionalHeaders : HTTPHeaders?
    )
}
