//
//  ViewController.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let button = UIButton()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "RootVC"
        view.backgroundColor = R.color.mainViewBackgroundColor()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false,
                                                     animated: true)
    }
    
    
    // MARK: - Private Func
    
    @objc private func buttonPressed() {
        let mainVC = MainScreenAssembly.assembleModule()
        navigationController?.pushViewController(mainVC,
                                                 animated: true)
    }
}


//MARK: - SetupViews
extension ViewController {
    
    private func setupViews() {
        
        view.addSubview(titleLabel)
        titleLabel.text = "Тестовый билд"
        titleLabel.font = .systemFont(ofSize: 32,
                                      weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = R.color.mainTextColor()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: 24),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,
                                             constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor,
                                              constant: 0)
        ])
        
        view.addSubview(button)
        button.setTitle("Open Main Screen", for: .normal)
        button.backgroundColor = R.color.mainButtonTintColor()
        button.setTitleColor(R.color.buttonTitleColor(), for: .normal)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                           constant: -80),
            button.leftAnchor.constraint(equalTo: view.leftAnchor,
                                         constant: 16),
            button.rightAnchor.constraint(equalTo: view.rightAnchor,
                                          constant: -16),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
        button.addTarget(self,
                         action: #selector(buttonPressed),
                         for: .touchUpInside)
    }
}


