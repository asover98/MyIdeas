//
//  TableViewManagerMainScreen.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import UIKit

protocol MainScreenTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: ViewModelMainScreen)
}

protocol MainScreenTableViewDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath)
    func removeRow(cellId: Int)
}

final class TableViewManagerMainScreen: NSObject {
    
    // MARK: - Properties
    
    private weak var tableView: UITableView?
    private var viewModel: ViewModelMainScreen?
    weak var delegate: MainScreenTableViewDelegate?
}


//MARK: - MainScreenTableViewManagerInput
extension TableViewManagerMainScreen: MainScreenTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IdeaTVCell.self,
                           forCellReuseIdentifier: "\(IdeaTVCell.self)")
        tableView.reloadData()
    }
    
    func update(with viewModel: ViewModelMainScreen) {
        
        self.viewModel = viewModel
        tableView?.reloadData()
    }
}


//MARK: - UITableViewDataSource
extension TableViewManagerMainScreen: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
   
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        guard let countRows = viewModel?.rows.count else { return 1 }
        return countRows
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = viewModel?.rows[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseId, for: indexPath)
        row.configurator.configure(cell: cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath)
    }
}


//MARK: - UITableViewDelegate
extension TableViewManagerMainScreen: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? IdeaTVCell else { return }
        viewModel?.rows.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath],
                             with: .fade)
        delegate?.removeRow(cellId: cell.id)
        tableView.reloadData()
    }
}
