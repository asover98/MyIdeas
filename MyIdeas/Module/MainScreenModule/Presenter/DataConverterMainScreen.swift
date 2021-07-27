//
//  DataConverterMainScreen.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import UIKit

protocol MainScreenDataConverterInput {
    func convert(data: [IdeaUserDefaults],
                 delegate: AnyObject?) -> ViewModelMainScreen
}

final class DataConverterMainScreen {  }


//MARK: - MainScreenDataConverterInput
extension DataConverterMainScreen: MainScreenDataConverterInput {
    
    //MARK: - Private typealias
    
    private typealias Row = ViewModelMainScreen.Row
    private typealias IdeaCellConfigurator = TableCellConfigurator<IdeaTVCell,
                                                                   IdeaTVCell.Model>
    
    //MARK: - Public Func
    
    func convert(data: [IdeaUserDefaults],
                 delegate: AnyObject?) -> ViewModelMainScreen {
        
        var rows: [ViewModelMainScreen.Row] = []
        
        let ideaCell = ideaTVCell(data: data,
                                  delegate: nil)
        rows.append(contentsOf: ideaCell)
        
        return ViewModelMainScreen(rows: rows)
    }
    
    
    //MARK: - Private Func
    private func ideaTVCell(data: [IdeaUserDefaults],
                            delegate: AnyObject?) -> [Row] {
        
        var rows: [Row] = []
        
        for item in data {
            let cellModel = IdeaTVCell.Model(data: item)
            let configurator = IdeaCellConfigurator(item: cellModel)
            rows.append(Row(configurator: configurator))
        }
        return rows
    }
}
