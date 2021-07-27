//
//  MainScreenService.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Foundation

protocol MainScreenService {
    func obtainMainScreen(completion: @escaping (Result<[DataIdea]>) -> Void)
}


final class MainScreenServiceImp: MainScreenService {
    
    // MARK: - Properties
    
    private let networkLayer: NetworkLayer
    
    
    // MARK: - Init
    
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    
    // MARK: - MainScreenService
    
    func obtainMainScreen(completion: @escaping (Result<[DataIdea]>) -> Void) {
        networkLayer.request(MainScreenEndpoint.getMainScreen, completion: completion)
    }
}
