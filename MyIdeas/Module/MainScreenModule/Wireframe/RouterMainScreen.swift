//
//  RouterMainScreen.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import UIKit

protocol MainScreenRouterInput {
    func openIdeaDetails(data: DataIdea)
}


final class RouterMainScreen {
    
    // MARK: - Properties
    
    private unowned let view: UIViewController
    
    
    // MARK: - Init
    
    init(view: UIViewController) {
        self.view = view
    }
}


// MARK: - MainScreenRouterInput
extension RouterMainScreen: MainScreenRouterInput {
    
    func openIdeaDetails(data: DataIdea) {
        let viewController = IdeaDetailsVC(data: data)
        view.navigationController?.pushViewController(viewController,
                                                      animated: true)
    }
}

