//
//  IdeaDetailsVC.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 22.07.2021.
//

import UIKit

final class IdeaDetailsVC: UIViewController {
    
    //MARK: - Private Properties
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let scrollView = UIScrollView()
    
    
    //MARK: - Public Properties
    
    var data: DataIdea
    
    
    //MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupViews()
    }
    
    
    //MARK: - Public Init
    
    init(data: DataIdea) {
        self.data = data
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - CustomizeNavigationBar
extension IdeaDetailsVC {
    
    private func customizeNavigationBar() {
        
        navigationController?.setNavigationBarHidden(false,
                                                     animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                           landscapeImagePhone: nil,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(leftButtonAction))
        navigationItem.leftBarButtonItem?.tintColor = R.color.mainButtonTintColor()
    }
    
    @objc private func leftButtonAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - SetupViews
extension IdeaDetailsVC {
    
    private func setupViews() {
        
        title = data.title
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = R.color.mainViewBackgroundColor()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: 0),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                             constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                              constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: 0),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor,
                                                constant: 0),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                constant: 0)
        ])
        
        scrollView.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.sd_setImage(with: URL(string: data.image), completed: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setNeedsLayout()
        imageView.removeConstraints(imageView.constraints)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: 16),
            imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor,
                                            constant: 16),
            imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor,
                                             constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,
                                              multiplier: 1)
        ])
        
        scrollView.addSubview(titleLabel)
        titleLabel.text = data.title
        titleLabel.font = .systemFont(ofSize: 18,
                                      weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = R.color.mainTextColor()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                            constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor,
                                             constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor,
                                              constant: -8)
        ])
        titleLabel.setContentHuggingPriority(.defaultHigh,
                                             for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh,
                                                           for: .vertical)
        
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.text = data.description
        descriptionLabel.font = .systemFont(ofSize: 14,
                                            weight: .thin)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.textColor = R.color.additionalTextColor()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: 24),
            descriptionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor,
                                                   constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor,
                                                    constant: -8),
            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor,
                                                     constant: -24)
        ])
        titleLabel.setContentHuggingPriority(.defaultHigh,
                                             for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh,
                                                           for: .vertical)
    }
}
