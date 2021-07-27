//
//  LocalIdeasData.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 23.07.2021.
//

import UIKit

struct IdeaUserDefaults: Codable, Equatable {
    
    var dataIdeas: DataIdea
}

final class LocalIdeasDataUserdefaults {
    
    //MARK: - Singleton
    
    static let shared = LocalIdeasDataUserdefaults()
    
    
    //MARK: - Keys
    
    let KEY_URL_SLOT_FOR_DOCUMENT = "KEY_URL_SLOT_FOR_DOCUMENT"
    let KEY_DATS_IDEAS = "KEY_DATS_IDEAS"
    let KEY_IDEAS_ID = "KEY_IDEAS_ID"
    
    
    //MARK: - Public Properties
    
    var newURLPath = ".png"
    var newURLSlot = 0 {
        didSet {
            UserDefaults.standard.removeObject(forKey: KEY_URL_SLOT_FOR_DOCUMENT)
            UserDefaults.standard.setValue(newURLSlot,
                                           forKey: KEY_URL_SLOT_FOR_DOCUMENT)
        }
    }
    var allIdeasId: [Int] = [] {
        didSet {
            UserDefaults.standard.removeObject(forKey: KEY_IDEAS_ID)
            UserDefaults.standard.setValue(allIdeasId,
                                           forKey: KEY_IDEAS_ID)
        }
    }
    var ideasArray: [IdeaUserDefaults] = [] {
        didSet {
            UserDefaults.standard.removeObject(forKey: KEY_DATS_IDEAS)
            if let encoded = try? JSONEncoder().encode(ideasArray) {
                UserDefaults.standard.setValue(encoded,
                                               forKey: KEY_DATS_IDEAS)
            }
            guard ideasArray.count > 1 else { return }
            ideasArray.sort(by: {$0.dataIdeas.dateCreated > $1.dataIdeas.dateCreated})
        }
    }
    
    
    //MARK: - Public Func
    
    func retriveDataFromUserDefaults() {
        
        if let urlSlotForDocument = UserDefaults.standard.object(forKey: KEY_URL_SLOT_FOR_DOCUMENT) as? Int {
            newURLSlot = urlSlotForDocument
        }
        
        if let identifiers = UserDefaults.standard.object(forKey: KEY_IDEAS_ID) as? [Int] {
            allIdeasId = identifiers
        }
        
        if let dataIdeasJSON = UserDefaults.standard.object(forKey: KEY_DATS_IDEAS) as? Data {
            if let decodeDataIdea = try? JSONDecoder().decode([IdeaUserDefaults].self,
                                                              from: dataIdeasJSON) {
                ideasArray = decodeDataIdea
            }
        }
    }
    
    func removeDataIdea(ideaId: Int) {
        
        ideasArray.removeAll(where: { $0.dataIdeas.id == ideaId})
        allIdeasId.append(ideaId)
    }
    
    func generateNewURLPath() -> String {
        
        newURLSlot += 1
        let value = "image\(newURLSlot).png"
        return value
    }
    
    
    func addNewIdea(newIdea: DataIdea) {
        
        if allIdeasId.first(where:{$0 == newIdea.id}) != nil {
          return
        } else {
            allIdeasId.append(newIdea.id)
            let newItem = IdeaUserDefaults(dataIdeas: newIdea)
            ideasArray.append(newItem)
        }
    }
    
    func generateIdForNewIdea() -> Int {
        
        var currentMaxValue = 0
        for idea in allIdeasId {
            if currentMaxValue < idea {
                currentMaxValue = idea
            }
        }
        return currentMaxValue + 1
    }
}
