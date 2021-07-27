//
//  EndpointProtocol.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Foundation
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias HTTPHeaders = Alamofire.HTTPHeaders

public protocol EndpointProtocol {
    
    var baseUrl: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
    var cacheKey: String? { get }
    var bodyData: Data? { get }
}

// MARK: - Default implementation
public extension EndpointProtocol {
    
    var baseUrl: URL? {
        return URL(string: server.server)
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:      return URLEncoding()
        default:        return JSONEncoding()
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var cacheKey: String? {
        return nil
    }
    
    var bodyData: Data? {
        return nil
    }
}
