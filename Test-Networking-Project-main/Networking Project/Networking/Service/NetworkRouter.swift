//
//  NetworkRouter.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->()

protocol NetworkRouter : AnyObject {
    associatedtype EndPoint : EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
