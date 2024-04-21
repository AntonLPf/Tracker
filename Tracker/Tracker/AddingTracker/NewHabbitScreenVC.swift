//
//  NewHabbitScreenVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 14.04.24.
//

import UIKit

class NewHabbitScreenVC: UIViewController {
    
    var tracker = Tracker(id: UUID(), name: "", color: "", icon: Character(""), schedule: [])
        
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
        textFieldBackgroundView.layer.cornerRadius = Constant.cornerRadius
        
        NSLayoutConstraint.activate([
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: Constant.cellHeihgt)
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
        optionsCellsBackgroundView.layer.cornerRadius = Constant.cornerRadius
                
        let categoryLabel = UILabel()
        categoryLabel.text = "Категория"
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(categoryLabel)
        
        let chevronImage = UIImage(systemName: "chevron.right")
        let chevronImageView = UIImageView()
        chevronImageView.image = chevronImage
        chevronImageView.tintColor = .ypGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            optionsCellsBackgroundView.heightAnchor.constraint(equalToConstant: isIrregularHabbit ? Constant.cellHeihgt : Constant.cellHeihgt * 2),
            categoryLabel.centerYAnchor.constraint(equalTo: optionsCellsBackgroundView.topAnchor, constant: Constant.cellHeihgt / 2),
            categoryLabel.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: Constant.paddingValue),
            
            chevronImageView.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -Constant.paddingValue),
            chevronImageView.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
        ])
        
        if !isIrregularHabbit {
            let line = DividerLineView()
            line.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(line)
            
            let scheduleLabel = UILabel()
            scheduleLabel.text = "Расписание"
            scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(scheduleLabel)
            
            let chevron2ImageView = UIImageView()
            chevron2ImageView.image = chevronImage
            chevron2ImageView.tintColor = .ypGray
            chevron2ImageView.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(chevron2ImageView)
            
            NSLayoutConstraint.activate([
                line.heightAnchor.constraint(equalToConstant: 0.5),
                line.bottomAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor,constant: -Constant.cellHeihgt),
                line.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: Constant.paddingValue),
                line.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -Constant.paddingValue),
                scheduleLabel.centerYAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor, constant: -(Constant.cellHeihgt / 2)),
                scheduleLabel.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: Constant.paddingValue),
                chevron2ImageView.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -Constant.paddingValue),
                chevron2ImageView.centerYAnchor.constraint(equalTo: scheduleLabel.centerYAnchor)
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
    
    private let createButton = ActionButton(title: "Создать")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLogo(to: "Новая привычка")
        
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        createButton.setIsActive(to: isFormValid)
        
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
        ])
        
        addAndConstrainBottomBlock(buttonHStack)
        
        NSLayoutConstraint.activate([
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constant.paddingValue),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.paddingValue),
            textFieldBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.logoHeight + Constant.rowSpaceValue),
            
            optionsCellsBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constant.paddingValue),
            optionsCellsBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.paddingValue),
            optionsCellsBackgroundView.topAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: Constant.rowSpaceValue),
            
            nameTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: Constant.paddingValue),
            nameTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -Constant.paddingValue),
            nameTextField.centerYAnchor.constraint(equalTo: textFieldBackgroundView.centerYAnchor),
                                    
            categoryButton.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor),
            categoryButton.topAnchor.constraint(equalTo: optionsCellsBackgroundView.topAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: Constant.cellHeihgt)
        ])
        
        if !isIrregularHabbit {
            view.addSubview(scheduleButton)
            NSLayoutConstraint.activate([
                scheduleButton.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor),
                scheduleButton.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor),
                scheduleButton.heightAnchor.constraint(equalToConstant: Constant.cellHeihgt),
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
        let schedule = [
            WeekDay(name: "Понедельник", state: false),
            WeekDay(name: "Вторник", state: false),
            WeekDay(name: "Среда", state: false),
            WeekDay(name: "Четверг", state: false),
            WeekDay(name: "Пятница", state: false),
            WeekDay(name: "Суббота", state: false),
            WeekDay(name: "Воскресенье", state: false)
        ]
        let vc = ScheduleVC(schedule: schedule)
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
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
        button.layer.cornerRadius = Constant.cornerRadius
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: Constant.logoHeight)
        ])
    }
    
    private func updateTrackerSchedule(_ schedule: [WeekDay]) {
        let newTracker = Tracker(id: tracker.id, 
                                 name: tracker.name,
                                 color: tracker.color,
                                 icon: tracker.icon,
                                 schedule: schedule)
        tracker = newTracker
    }
}

extension NewHabbitScreenVC: ScheduleVCDelegate {
    func didDoneButtonPressed(schedule: [WeekDay]) {
        updateTrackerSchedule(schedule)
        if let firstvc = presentationController?.presentedViewController {
            firstvc.dismiss(animated: true)
        }
    }
}

#Preview {
    NewHabbitScreenVC(isIrregularHabbit: false)
}
