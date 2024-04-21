//
//  NewHabbitScreenVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 14.04.24.
//

import UIKit

class NewHabbitScreenVC: UIViewController {
    
    static let cellHeight: CGFloat = 75
    static let cornerRadius: CGFloat = 16
    static let padding: CGFloat = 16
    
    private let isIrregularHabbit: Bool
    
    private var isNameValid: Bool {
        if let text = nameTextField.text {
            return !text.isEmpty && text.count > 3
        }
        return false
    }
    
    private var isFormValid: Bool {
        isNameValid
    }
    
    private lazy var textFieldBackgroundView: UIView = {
        let textFieldBackgroundView = UIView()
        textFieldBackgroundView.backgroundColor = .ypBackgroundGray
        textFieldBackgroundView.layer.cornerRadius = Self.cornerRadius
        
        NSLayoutConstraint.activate([
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: Self.cellHeight)
        ])

        return textFieldBackgroundView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название трекера"
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    private lazy var optionsCellsBackgroundView: UIView = {
        let optionsCellsBackgroundView = UIView()
        optionsCellsBackgroundView.backgroundColor = .ypBackgroundGray
        optionsCellsBackgroundView.layer.cornerRadius = Self.cornerRadius
                
        let topLabel = UILabel()
        topLabel.text = "Категория"
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(topLabel)
        
        let chevronImage = UIImage(systemName: "chevron.right")
        let chevronImageView = UIImageView()
        chevronImageView.image = chevronImage
        chevronImageView.tintColor = .ypGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            optionsCellsBackgroundView.heightAnchor.constraint(equalToConstant: isIrregularHabbit ? Self.cellHeight : Self.cellHeight * 2),
            topLabel.centerYAnchor.constraint(equalTo: optionsCellsBackgroundView.topAnchor, constant: Self.cellHeight / 2),
            topLabel.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: Self.padding),
            
            chevronImageView.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -Self.padding),
            chevronImageView.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor),
        ])
        
        if !isIrregularHabbit {
            let line = DividerLineView()
            line.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(line)

            
            let bottomLabel = UILabel()
            bottomLabel.text = "Расписание"
            bottomLabel.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(bottomLabel)
            
            let chevron2ImageView = UIImageView()
            chevron2ImageView.image = chevronImage
            chevron2ImageView.tintColor = .ypGray
            chevron2ImageView.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(chevron2ImageView)
            
            NSLayoutConstraint.activate([
                line.heightAnchor.constraint(equalToConstant: 0.5),
                line.bottomAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor,constant: -Self.cellHeight),
                line.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: 16),
                line.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -16),
                bottomLabel.centerYAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor, constant: -(Self.cellHeight / 2)),
                bottomLabel.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: Self.padding),
                chevron2ImageView.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -Self.padding),
                chevron2ImageView.centerYAnchor.constraint(equalTo: bottomLabel.centerYAnchor)
            ])
        }
        
        return optionsCellsBackgroundView
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var scheduleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
                
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    private lazy var createButton = ActionButton(title: "Создать", action: #selector(createButtonTapped), isActive: isFormValid)
    
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
             
        view.addSubviews([
            textFieldBackgroundView,
            nameTextField,
            optionsCellsBackgroundView,
            categoryButton,
            buttonHStack,
        ])
        
        NSLayoutConstraint.activate([
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Self.padding),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Self.padding),
            textFieldBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 84),
            
            optionsCellsBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Self.padding),
            optionsCellsBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Self.padding),
            optionsCellsBackgroundView.topAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: 24),
            
            nameTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -16),
            nameTextField.centerYAnchor.constraint(equalTo: textFieldBackgroundView.centerYAnchor),
                        
            buttonHStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonHStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonHStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            buttonHStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            categoryButton.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor),
            categoryButton.topAnchor.constraint(equalTo: optionsCellsBackgroundView.topAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: Self.cellHeight)
        ])
        
        if !isIrregularHabbit {
            view.addSubview(scheduleButton)
            NSLayoutConstraint.activate([
                scheduleButton.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor),
                scheduleButton.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor),
                scheduleButton.heightAnchor.constraint(equalToConstant: Self.cellHeight),
                scheduleButton.bottomAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor),
            ])
        }
        
    }
    
    init(isIrregularHabbit: Bool) {
        self.isIrregularHabbit = isIrregularHabbit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    @objc func categoryButtonTapped() {
        
    }
    
    @objc func scheduleButtonTapped() {
        
    }
    
    @objc func cancelButtonTapped() {
        if let firstvc = presentationController?.presentedViewController {
            firstvc.dismiss(animated: true)
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func createButtonTapped() {
        
    }
    
    private func configureStyleFor(button: UIButton,
                                   action: Selector) {
        button.layer.cornerRadius = Self.cornerRadius
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}

#Preview {
    NewHabbitScreenVC(isIrregularHabbit: false)
}
