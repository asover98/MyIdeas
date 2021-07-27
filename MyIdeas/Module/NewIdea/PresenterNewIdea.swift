//
//  PresenterNewIdea.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 23.07.2021.
//

import Foundation

protocol NewIdeaViewOutput {
    
    func writeDownNewIdea(title: String,
                          description: String,
                          image: String)
}

final class PresenterNewIdea { }


//MARK: - NewIdeaViewOutput
extension PresenterNewIdea: NewIdeaViewOutput {
    
    func writeDownNewIdea(title: String,
                          description: String,
                          image: String) {
        
        let newIdeaId = LocalIdeasDataUserdefaults.shared.generateIdForNewIdea()
        let currentTime = Int(NSDate().timeIntervalSince1970)
        
        let newIdea = DataIdea(id: newIdeaId,
                               image: image,
                               title: title,
                               description: description,
                               dateCreated: currentTime)
        
        LocalIdeasDataUserdefaults.shared.addNewIdea(newIdea: newIdea)
    }
}
