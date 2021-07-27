//
//  InteractorMainScreen.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Foundation
import Alamofire

protocol MainScreenInteractorInput {
    func obtainMainScreen()
}

final class InteractorMainScreen {
    
    // MARK: - Properties
    
    weak var presenter: MainScreenInteractorOutput?
    private let mainScreenService: MainScreenService
    var dataIeas: [IdeaUserDefaults]
    
    
    // MARK: - Init
    init(mainScreenService: MainScreenService, dataIeas: [IdeaUserDefaults]) {
        self.mainScreenService = mainScreenService
        self.dataIeas = dataIeas
    }
}


// MARK: - LandingInteractorInput
extension InteractorMainScreen: MainScreenInteractorInput {
    
    func obtainMainScreen() {
        
        mainScreenService.obtainMainScreen() { [weak self] result in

            switch result {

            case .success(let model):
                for idea in model {
                    LocalIdeasDataUserdefaults.shared.addNewIdea(newIdea: idea)
                }
                self?.presenter?.didSuccesToObtain(with: LocalIdeasDataUserdefaults.shared.ideasArray)

            case .failure(let error):
                self?.presenter?.didFailureToObtain(with: error)

            }
        }
    }
}
    


