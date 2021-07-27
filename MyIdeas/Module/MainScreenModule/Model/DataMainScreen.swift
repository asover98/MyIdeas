//
//  DataMainScreen.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Foundation

struct DataIdea: Codable, Equatable {
    
    let id: Int
    let image: String
    let title: String
    let description: String
    let dateCreated: Int
}
