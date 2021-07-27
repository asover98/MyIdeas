//
//  NewIdeaVC.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 22.07.2021.
//

import UIKit

final class NewIdeaVC: UIViewController {
    
    // MARK: - Private Properties
    
    private let stackView = UIStackView()
    
    private let viewForImageView = UIView()
    private let changePhotoInfoView = UIView()
    private let changePhotoInfoLabel = UILabel()
    private let userPhotoImageView = UIImageView()
    private let uploadPhotoButton = UIButton()
    
    private let viewForOtherView = UIView()
    private let borderTextFieldView = UIView()
    private let textField = UITextField()
    private let borderTextView = UIView()
    private let textView = UITextView()
    private var activeView: UIView!
    
    private let imageURL = BaseStringText.imageURL.rawValue
    private var edditingViewY: CGFloat = 0.0
    private var urlToUserImage = ""
    
    
    // MARK: - Public Properties
    
    var presenter = PresenterNewIdea()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.mainViewBackgroundColor()
        textField.delegate = self
        textView.delegate = self
        registrationKeyboardNotifications()
        customizeNavigationBar()
        baseSetupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupView()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size,
                                 with: coordinator)
        setupView()
    }
    
    
    //MARK: - Private Func
    
    @objc private func uploadPhotoButtonTapped() {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        
        let alert = UIAlertController(title: "Добавить фото 👇",
                                      message: "Выбери источник",
                                      preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Фото",
                                         style: .default) { action in
            picker.sourceType = .camera
            self.present(picker,
                         animated: true)
        }
        
        let lybaryAction = UIAlertAction(title: "Галерея",
                                         style: .default) { action in
            picker.sourceType = .photoLibrary
            self.present(picker,
                         animated: true)
        }
        
        alert.addAction(cameraAction)
        alert.addAction(lybaryAction)
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    private func bluringPhotoSetting() {
        
        if urlToUserImage == "" {
            userPhotoImageView.alpha = 0.5
            changePhotoInfoLabel.text = BaseStringText.uploadPhotoInfo.rawValue
        } else {
            userPhotoImageView.alpha = 1.0
            changePhotoInfoLabel.textColor = R.color.mainTextColor()
            changePhotoInfoLabel.text = BaseStringText.changePhotoInfo.rawValue
        }
    }
}


//MARK: - UIImagePickerControllerDelegate
extension NewIdeaVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userPhotoImageView.image = userImage
            if let imageData = userPhotoImageView.image?.pngData() {
                guard let directory = try? FileManager.default.url(for: .documentDirectory,
                                                                   in: .userDomainMask,
                                                                   appropriateFor: nil,
                                                                   create: false) as NSURL else { return }
                do {
                    let newUrl = LocalIdeasDataUserdefaults.shared.generateNewURLPath()
                    try imageData.write(to: directory.appendingPathComponent(newUrl)!)
                    let url = directory.appendingPathComponent(newUrl)!
                    urlToUserImage = url.absoluteString
                } catch {
                    print("Ошибка при попытке записи (\(error))")
                }
            }
        } else {
            print("неудалось получить фото")
        }
        picker.dismiss(animated: true,
                       completion: nil)
        bluringPhotoSetting()
    }
}


//MARK: - Keyboard Config
extension NewIdeaVC {
    
    private func registrationKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow() {
        
        switch stackView.axis {
        
        case .horizontal:
            guard self.edditingViewY != 0.0 else { return }
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           options: UIView.AnimationOptions.curveEaseIn,
                           animations: { self.stackView.frame = CGRect(x: 0,
                                                                       y: -64,
                                                                       width: self.view.bounds.width,
                                                                       height: self.view.bounds.height) },
                           completion: nil)
        case .vertical:
            if self.edditingViewY == 0.0 {
                UIView.animate(withDuration: 0.3,
                               delay: 0.0,
                               options: UIView.AnimationOptions.curveEaseIn,
                               animations: { self.stackView.frame = CGRect(x: 0,
                                                                           y: -(self.borderTextFieldView.frame.height + 86),
                                                                           width: self.view.bounds.width,
                                                                           height: self.view.bounds.height) },
                               completion: nil)
            } else {
                UIView.animate(withDuration: 0.3,
                               delay: 0.0,
                               options: UIView.AnimationOptions.curveEaseIn,
                               animations: { self.stackView.frame = CGRect(x: 0,
                                                                           y: -(self.textView.frame.height + 16),
                                                                           width: self.view.bounds.width,
                                                                           height: self.view.bounds.height) },
                               completion: nil)
            }
        @unknown default:
            return
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: { self.stackView.frame = CGRect(x: 0,
                                                                   y: 0,
                                                                   width: self.view.bounds.width,
                                                                   height: self.view.bounds.height)},
                       completion: nil)
    }
}

//MARK: - CustomizeNavigationBar
extension NewIdeaVC {
    
    private func customizeNavigationBar() {
        
        title = BaseStringText.title.rawValue
        navigationController?.setNavigationBarHidden(false,
                                                     animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                           landscapeImagePhone: nil,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(leftButtonAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.seal.fill"),
                                                            landscapeImagePhone: nil,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(rightButtonAction))
        navigationItem.leftBarButtonItem?.tintColor = R.color.mainButtonTintColor()
        navigationItem.rightBarButtonItem?.tintColor = R.color.mainButtonTintColor()
    }
    
    @objc private func rightButtonAction(sender: UIBarButtonItem) {
        
        ///проверка правильного заполнения данных для создания новой идеи
        if urlToUserImage != "",
           textField.text != "",
           textView.text != "" {
            presenter.writeDownNewIdea(title: textField.text!,
                                        description: textView.text!,
                                        image: urlToUserImage)
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Упс - ты что то пропустил 👇",
                                          message: "Отнесись серьезнее - вообще-то мы тут идеи записываем 😒",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK",
                                                                   comment: "Default action"),
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func leftButtonAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - UITextViewDelegate
extension NewIdeaVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.red {
            textView.text = nil
            textView.textColor = R.color.mainTextColor()
        }
        activeView = textView
        edditingViewY = borderTextFieldView.frame.origin.y
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.textColor = UIColor.red
            textView.text = BaseStringText.placeholderTextView.rawValue
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}


//MARK: - TextFieldDelegate
extension NewIdeaVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeView = textField
        edditingViewY = textField.frame.origin.y
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - BaseStringText
extension NewIdeaVC {
    
    private enum BaseStringText: String {
        case title = "Новая идея!"
        case imageURL = "https://i.pinimg.com/originals/57/ce/a7/57cea7fba1e235628a139e55c0b82b3d.jpg"
        case uploadPhotoInfo = "Нажми на изображение для того что бы загрузить свое фото"
        case changePhotoInfo = "Для замены фото нажми на изображение"
        case placeholderTextField = "Назовите вашу идею!"
        case placeholderTextView = "Вкратце расскажи какая гениальная мысль тебя посетила сегодня !"
    }
}


//MARK: - SetupViews
extension NewIdeaVC {
    
    private func baseSetupView() {

        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: 0),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                            constant: 0),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                             constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: 0)
        ])
        
        stackView.addArrangedSubview(viewForImageView)
        stackView.addArrangedSubview(viewForOtherView)
        
        viewForImageView.addSubview(userPhotoImageView)
        userPhotoImageView.clipsToBounds = true
        userPhotoImageView.layer.cornerRadius = 4
        userPhotoImageView.sd_setImage(with: URL(string: imageURL),
                                       completed: nil)
        userPhotoImageView.contentMode = .scaleToFill
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        viewForImageView.addSubview(changePhotoInfoView)
        changePhotoInfoView.translatesAutoresizingMaskIntoConstraints = false
        changePhotoInfoView.backgroundColor = R.color.opacityViewColor()
        
        changePhotoInfoView.addSubview(changePhotoInfoLabel)
        changePhotoInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        changePhotoInfoLabel.attributedText = NSAttributedString(
            string: BaseStringText.uploadPhotoInfo.rawValue,
            attributes: [   NSAttributedString.Key.foregroundColor: UIColor.red,
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12,
                                                                           weight: .light)])
        changePhotoInfoLabel.numberOfLines = 2
        
        viewForImageView.addSubview(uploadPhotoButton)
        uploadPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        uploadPhotoButton.addTarget(self,
                                    action: #selector(uploadPhotoButtonTapped),
                                    for: .touchUpInside)
        
        viewForOtherView.addSubview(borderTextFieldView)
        borderTextFieldView.layer.borderWidth = 1
        borderTextFieldView.layer.borderColor = UIColor(named: "BorderViewColor")?.cgColor
        borderTextFieldView.layer.cornerRadius = 4
        borderTextFieldView.clipsToBounds = true
        borderTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        borderTextFieldView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: BaseStringText.placeholderTextField.rawValue ,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        
        
        viewForOtherView.addSubview(borderTextView)
        borderTextView.layer.borderWidth = 1
        borderTextView.layer.borderColor = UIColor(named: "BorderViewColor")?.cgColor
        borderTextView.layer.cornerRadius = 4
        borderTextView.translatesAutoresizingMaskIntoConstraints = false
        
        borderTextView.addSubview(textView)
        textView.text = BaseStringText.placeholderTextView.rawValue
        textView.textColor = .red
        textView.backgroundColor = R.color.mainViewBackgroundColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupView() {
        
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }

        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: viewForImageView.topAnchor,
                                                    constant: 8),
            userPhotoImageView.leftAnchor.constraint(equalTo: viewForImageView.leftAnchor,
                                                     constant: 16),
            userPhotoImageView.rightAnchor.constraint(equalTo: viewForImageView.rightAnchor,
                                                      constant: -16),
            userPhotoImageView.bottomAnchor.constraint(equalTo: viewForImageView.bottomAnchor,
                                                       constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            changePhotoInfoView.topAnchor.constraint(equalTo: userPhotoImageView.topAnchor,
                                                     constant: 0),
            changePhotoInfoView.leftAnchor.constraint(equalTo: userPhotoImageView.leftAnchor,
                                                      constant: 0),
            changePhotoInfoView.rightAnchor.constraint(equalTo: userPhotoImageView.rightAnchor,
                                                       constant: 0),
            changePhotoInfoView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            changePhotoInfoLabel.topAnchor.constraint(equalTo: changePhotoInfoView.topAnchor,
                                                      constant: 8),
            changePhotoInfoLabel.leftAnchor.constraint(equalTo: changePhotoInfoView.leftAnchor,
                                                       constant: 8),
            changePhotoInfoLabel.rightAnchor.constraint(equalTo: changePhotoInfoView.rightAnchor,
                                                        constant: -8),
            changePhotoInfoLabel.bottomAnchor.constraint(equalTo: changePhotoInfoView.bottomAnchor,
                                                         constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            uploadPhotoButton.topAnchor.constraint(equalTo: userPhotoImageView.topAnchor,
                                                   constant: 0),
            uploadPhotoButton.leftAnchor.constraint(equalTo: userPhotoImageView.leftAnchor,
                                                    constant: 0),
            uploadPhotoButton.rightAnchor.constraint(equalTo: userPhotoImageView.rightAnchor,
                                                     constant: 0),
            uploadPhotoButton.bottomAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor,
                                                      constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            borderTextFieldView.heightAnchor.constraint(equalToConstant: 40),
            borderTextFieldView.topAnchor.constraint(equalTo: viewForOtherView.topAnchor,
                                                     constant: 8),
            borderTextFieldView.leftAnchor.constraint(equalTo: viewForOtherView.leftAnchor,
                                                      constant: 16),
            borderTextFieldView.rightAnchor.constraint(equalTo: viewForOtherView.rightAnchor,
                                                       constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: borderTextFieldView.topAnchor,
                                           constant: 0),
            textField.leftAnchor.constraint(equalTo: borderTextFieldView.leftAnchor,
                                            constant: 8),
            textField.rightAnchor.constraint(equalTo: borderTextFieldView.rightAnchor,
                                             constant: -8),
            textField.bottomAnchor.constraint(equalTo: borderTextFieldView.bottomAnchor,
                                              constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            borderTextView.topAnchor.constraint(equalTo: borderTextFieldView.bottomAnchor,
                                                constant: 8),
            borderTextView.leftAnchor.constraint(equalTo: viewForOtherView.leftAnchor,
                                                 constant: 16),
            borderTextView.rightAnchor.constraint(equalTo: viewForOtherView.rightAnchor,
                                                  constant: -16),
            borderTextView.bottomAnchor.constraint(equalTo: viewForOtherView.bottomAnchor,
                                                   constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: borderTextView.topAnchor,
                                          constant: 0),
            textView.leftAnchor.constraint(equalTo: borderTextView.leftAnchor,
                                           constant: 8),
            textView.rightAnchor.constraint(equalTo: borderTextView.rightAnchor,
                                            constant: -8),
            textView.bottomAnchor.constraint(equalTo: borderTextView.bottomAnchor,
                                             constant: 0)
        ])
    }
}
