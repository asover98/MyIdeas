//
//  IdeaTVCell.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 21.07.2021.
//

import UIKit

final class IdeaTVCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let image = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    var id = 0
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lyfecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}


//MARK: - Configurable
extension IdeaTVCell: Configurable {
    
    struct Model {
        let data: IdeaUserDefaults
    }
    
    func configure(with model: Model) {
        image.sd_setImage(with: URL(string: model.data.dataIdeas.image),
                          completed: nil)
        titleLabel.text = model.data.dataIdeas.title
        descriptionLabel.text = model.data.dataIdeas.description
        id = model.data.dataIdeas.id
    }
}


//MARK: - SetupViews
extension IdeaTVCell {
    
    private func setupViews() {
        clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        contentView.layer.cornerRadius = 4
        
        addSubview(image)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.removeConstraints(image.constraints)
//        image.setNeedsLayout()
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor,
                                       constant: 16),
            image.leftAnchor.constraint(equalTo: leftAnchor,
                                        constant: 16),
            image.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
                                          constant: -16),
            image.widthAnchor.constraint(equalTo: widthAnchor,
                                         multiplier: 2.0/5.0),
            image.heightAnchor.constraint(equalTo: image.widthAnchor,
                                          multiplier: 1.0)
        ])
        
        addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 16,
                                      weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = R.color.mainTextColor()
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant:16),
            titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor,
                                             constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor,
                                              constant: -16)
        ])
        titleLabel.setContentHuggingPriority(.defaultHigh,
                                             for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh,
                                                           for: .vertical)
        
        addSubview(descriptionLabel)
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = R.color.additionalTextColor()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: image.rightAnchor,
                                                   constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor,
                                                    constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
                                                     constant: -16)
        ])
        descriptionLabel.setContentHuggingPriority(.defaultHigh,
                                                   for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.defaultHigh,
                                                                 for: .vertical)
    }
}
