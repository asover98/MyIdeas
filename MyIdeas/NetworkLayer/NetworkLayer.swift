//
//  NetworkLayer.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Foundation
import Alamofire

enum Result<Model> {
    case success(model: Model)
    case failure(error: Error)
}

protocol NetworkLayer {
    func request<T: Decodable>(_ endpoint: EndpointProtocol, completion: @escaping (Result<T>) -> Void)
    func request(_ endpoint: EndpointProtocol, completion: @escaping (Result<Data>) -> Void)
}

final class NetworkLayerImp: NetworkLayer {
    
    // MARK: - Properties
    
    private let sessionManager: Session
    
    
    // MARK: - Init
    
    init() {
        let session = Session()
        self.sessionManager = session
    }
    
    // MARK: - NetworkLayer
    
    func request(_ endpoint: EndpointProtocol, completion: @escaping (Result<Data>) -> Void) {
        
        let request = sessionManager.request(endpoint: endpoint)
        
        request?.debugLog().responseData(completionHandler: { response in
            
            switch response.result {
            
            case .success(let data):
                completion(.success(model: data))
                
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
    }

func request<T>(_ endpoint: EndpointProtocol, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        
        request(endpoint) { result in
            
            switch result {
            
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model: result))
                } catch {
                    completion(.failure(error: error))
                }
                
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}

