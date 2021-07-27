//
//  PresenterMainScreen.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Foundation

protocol MainScreenInteractorOutput: AnyObject {
    
    func didSuccesToObtain(with model: [IdeaUserDefaults])
    func didFailureToObtain(with error: Error)
}


protocol MainScreenViewOutput: ViewOutput { }


final class PresenterMainScreen {
    
    // MARK: - Private properties
    
    private unowned let view: MainScreenViewInput
    private let router: MainScreenRouterInput
    private let interactor: MainScreenInteractorInput
    private let dataConverter: MainScreenDataConverterInput
    private var data: [IdeaUserDefaults] = []
    
    
    // MARK: - Public Init
    
    init(view: MainScreenViewInput,
         router: MainScreenRouterInput,
         interactor: MainScreenInteractorInput,
         dataConverter: MainScreenDataConverterInput) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataConverter = dataConverter
    }
    
    
    // MARK: - Private Func
    
    private func updateData() {
        data = LocalIdeasDataUserdefaults.shared.ideasArray
        let viewModel = dataConverter.convert(data: data,
                                              delegate: self)
        view.updateView(with: viewModel)
    }
}


// MARK: - MainScreenViewOutput
extension PresenterMainScreen: MainScreenViewOutput {
        
    func viewIsReady() {
        
        guard data != LocalIdeasDataUserdefaults.shared.ideasArray || LocalIdeasDataUserdefaults.shared.ideasArray.isEmpty else { return }
        interactor.obtainMainScreen()
    }
    
    func viewWillAppear() {
        updateData()
    }
}


// MARK: - MainScreenInteractorOutput
extension PresenterMainScreen: MainScreenInteractorOutput {
    
    func didSuccesToObtain(with model: [IdeaUserDefaults]) {
        updateData()
    }
    
    func didFailureToObtain(with error: Error) {
        print(error.localizedDescription)
    }
}


// MARK: - MainScreenTableViewDelegate
extension PresenterMainScreen: MainScreenTableViewDelegate {
    
    func didSelectItem(at indexPath: IndexPath) {
        router.openIdeaDetails(data: data[indexPath.row].dataIdeas)
    }
    
    func removeRow(cellId: Int) {
        LocalIdeasDataUserdefaults.shared.removeDataIdea(ideaId: cellId)
        updateData()
    }
}
