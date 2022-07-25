//
//  NetworkError.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import Foundation

public enum NetworkError : String, Error {
    case parametersNil  = "Parameters returned nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL     = "URL is nil."
}
