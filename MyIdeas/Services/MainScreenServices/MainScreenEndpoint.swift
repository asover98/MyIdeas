//
//  MainScreenEndpoint.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Alamofire

enum MainScreenEndpoint: EndpointProtocol {
    
    case getMainScreen
    
    var path: String {
        
        switch self {
        
        case .getMainScreen:
            return "/mockForTest.json"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        
        case .getMainScreen:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        
        switch self {
        
        case .getMainScreen:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding()
    }
}

