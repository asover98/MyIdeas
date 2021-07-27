//
//  MainScreenVC.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 21.07.2021.
//

import UIKit

protocol MainScreenViewInput: AnyObject {
    func updateView(with viewModel: ViewModelMainScreen)
}

final class MainScreenVC: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    var tableViewManager: MainScreenTableViewManagerInput?
    var presenter: MainScreenViewOutput?

    
    //MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.mainViewBackgroundColor()
        presenter?.viewIsReady()
        tableViewManager?.setup(tableView: tableView)
        customizeNavigationBar()
        baseSetupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
        setupViews()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size,
                                 with: coordinator)
        
        setupViews()
    }
}


//MARK: - MainScreenViewInput
extension MainScreenVC: MainScreenViewInput {
    
    func updateView(with viewModel: ViewModelMainScreen) {
        tableViewManager?.update(with: viewModel)
    }
}


//MARK: - CustomizeNavigationBar
extension MainScreenVC {
    
    private func customizeNavigationBar() {
        
        title = "MainScreen"
        navigationController?.setNavigationBarHidden(false,
                                                     animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                           landscapeImagePhone: nil,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(leftButtonAction))
        navigationItem.leftBarButtonItem?.tintColor = R.color.mainButtonTintColor()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            landscapeImagePhone: nil,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(rightButtonAction))
        navigationItem.rightBarButtonItem?.tintColor = R.color.mainButtonTintColor()
    }
    
    @objc private func leftButtonAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func rightButtonAction(sender: UIBarButtonItem) {
        navigationController?.pushViewController(NewIdeaVC(), animated: true)
    }
}


//MARK: - SetupViews
extension MainScreenVC {
    
    private func setupViews() {
        
//        titleLabel.removeConstraints(titleLabel.constraints)
//        titleLabel.setNeedsLayout()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,
                                             constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor,
                                              constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
//        tableView.removeConstraints(tableView.constraints)
//        tableView.setNeedsLayout()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: 8),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                            constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                             constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: 0)
        ])
    }
    
    private func baseSetupViews() {
        
        view.addSubview(titleLabel)
        titleLabel.text = "Hello world"
        titleLabel.font = .systemFont(ofSize: 20,
                                      weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = R.color.mainTextColor()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.clipsToBounds = true
        tableView.backgroundColor = R.color.mainViewBackgroundColor()
        tableView.clearsContextBeforeDrawing = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

