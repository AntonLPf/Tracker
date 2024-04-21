//
//  NewHabbitScreenVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 14.04.24.
//

import UIKit

class NewHabbitScreenVC: UIViewController {
    
    static let cellHeight: CGFloat = 75
    static let cellCornerRadius: CGFloat = 16
    
    private lazy var textFieldBackgroundView: UIView = {
        let textFieldBackgroundView = UIView()
        textFieldBackgroundView.backgroundColor = .ypBackgroundGray
        textFieldBackgroundView.layer.cornerRadius = Self.cellCornerRadius
        textFieldBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: Self.cellHeight)
        ])

        return textFieldBackgroundView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название трекера"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var optionsCellsBackgroundView: UIView = {
        let optionsCellsBackgroundView = UIView()
        optionsCellsBackgroundView.backgroundColor = .ypBackgroundGray
        optionsCellsBackgroundView.layer.cornerRadius = Self.cellCornerRadius
        optionsCellsBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let line = DividerLineView()
        line.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(line)
        
        let topLabel = UILabel()
        topLabel.text = "Категория"
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(topLabel)
        
        let bottomLabel = UILabel()
        bottomLabel.text = "Расписание"
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(bottomLabel)
        
        let chevronImage = UIImage(systemName: "chevron.right")
        let chevronImageView = UIImageView()
        chevronImageView.image = chevronImage
        chevronImageView.tintColor = .ypGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(chevronImageView)
        
        let chevron2ImageView = UIImageView()
        chevron2ImageView.image = chevronImage
        chevron2ImageView.tintColor = .ypGray
        chevron2ImageView.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(chevron2ImageView)
        
        NSLayoutConstraint.activate([
            optionsCellsBackgroundView.heightAnchor.constraint(equalToConstant: Self.cellHeight * 2),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            line.bottomAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor,constant: -Self.cellHeight),
            line.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -16),
            
            topLabel.centerYAnchor.constraint(equalTo: optionsCellsBackgroundView.topAnchor, constant: Self.cellHeight / 2),
            topLabel.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: 16),
            
            bottomLabel.centerYAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor, constant: -(Self.cellHeight / 2)),
            bottomLabel.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: 16),
            chevronImageView.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor),
            chevron2ImageView.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -16),
            chevron2ImageView.centerYAnchor.constraint(equalTo: bottomLabel.centerYAnchor)
        ])

        return optionsCellsBackgroundView
    }()
                
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать", for: .normal)
        button.backgroundColor = .ypBlack
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLogo(to: "Новая привычка")
        configureStyleFor(button: cancelButton, action: #selector(cancelButtonTapped))
        
        configureStyleFor(button: createButton, action: #selector(createButtonTapped))
        
        let buttonHStack = UIStackView()
        buttonHStack.axis = .horizontal
        buttonHStack.spacing = 8
        buttonHStack.distribution = .fillEqually
        buttonHStack.addArrangedSubview(cancelButton)
        buttonHStack.addArrangedSubview(createButton)
        buttonHStack.translatesAutoresizingMaskIntoConstraints = false
                
        view.addSubview(buttonHStack)
        view.addSubview(textFieldBackgroundView)
        view.addSubview(nameTextField)
        view.addSubview(optionsCellsBackgroundView)
        
        NSLayoutConstraint.activate([
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textFieldBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 84),
            
            optionsCellsBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            optionsCellsBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            optionsCellsBackgroundView.topAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: 24),
            
            nameTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -16),
            nameTextField.centerYAnchor.constraint(equalTo: textFieldBackgroundView.centerYAnchor),
                        
            buttonHStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonHStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonHStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            buttonHStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureStyleFor(button: UIButton,
                                   action: Selector) {
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func cancelButtonTapped() {
        if let firstvc = presentationController?.presentedViewController {
            firstvc.dismiss(animated: true)
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func createButtonTapped() {
        
    }
    
}

#Preview {
    NewHabbitScreenVC()
}
