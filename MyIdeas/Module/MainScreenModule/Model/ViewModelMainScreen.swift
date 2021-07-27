//
//  ViewModelMainScreen.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//


struct ViewModelMainScreen {
    
    // MARK: - Properties
    
    var rows: [Row]
    
    
    // MARK: - Row
    
    struct Row {
            
        // MARK: - Properties
        
        let configurator: TableCellConfiguratorProtocol
       
        var reuseId: String {
            return type(of: configurator).reuseId
        }
    }
}
