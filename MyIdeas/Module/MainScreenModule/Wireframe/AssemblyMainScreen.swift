//
//  AssemblyMainScreen.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Foundation

final class MainScreenAssembly {
    
    static func assembleModule() -> MainScreenVC {
        
        let view = MainScreenVC()
        let router = RouterMainScreen(view: view)
        let dataConverter = DataConverterMainScreen()
        let service = MainScreenServiceImp(networkLayer: NetworkLayerImp())
        let interactor = InteractorMainScreen(mainScreenService: service,
                                              dataIeas: LocalIdeasDataUserdefaults.shared.ideasArray)
        let presenter = PresenterMainScreen(view: view,
                                            router: router,
                                            interactor: interactor,
                                            dataConverter: dataConverter)
        let tableViewManager = TableViewManagerMainScreen()
        
        interactor.presenter = presenter
        view.tableViewManager = tableViewManager
        view.presenter = presenter
        tableViewManager.delegate = presenter
        
        return view
    }
}
