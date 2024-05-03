//
//  NewHabbitScreenVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 14.04.24.
//

import UIKit

class NewHabbitScreenVC: UIViewController {
    
    private var schedule = [
        WeekDay(name: .monday, isChosen: false),
        WeekDay(name: .tuesday, isChosen: false),
        WeekDay(name: .wendsday, isChosen: false),
        WeekDay(name: .thursday, isChosen: false),
        WeekDay(name: .friday, isChosen: false),
        WeekDay(name: .saturday, isChosen: false),
        WeekDay(name: .sunday, isChosen: false)
    ]
    
    private let emojies: [Character] = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
            
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
    
    private lazy var categoriesLabel: UILabel = {
        let categoriesLabel = UILabel()
        categoriesLabel.textColor = .ypGray
        categoriesLabel.text = "Домашний уют"
        categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoriesLabel
    }()
    
    private lazy var scheduleVStack = UIStackView()
    
    private lazy var weekDaysLabel: UILabel = {
        let weekDaysLabel = UILabel()
        weekDaysLabel.textColor = .ypGray
        weekDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        return weekDaysLabel
    }()
    
    private lazy var optionsCellsBackgroundView: UIView = {
        let optionsCellsBackgroundView = UIView()
        optionsCellsBackgroundView.backgroundColor = .ypBackgroundGray
        optionsCellsBackgroundView.layer.cornerRadius = Constant.cornerRadius
                
        let categoryLabel = UILabel()
        categoryLabel.text = "Категория"
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let categoryVStack = UIStackView()
        categoryVStack.axis = .vertical
        categoryVStack.spacing = 2
        categoryVStack.addArrangedSubview(categoryLabel)
        if let text = categoriesLabel.text, !text.isEmpty {
            categoryVStack.addArrangedSubview(categoriesLabel)
        }
        categoryVStack.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(categoryVStack)

        let chevronImage = UIImage(systemName: "chevron.right")
        
        let chevronImageView = UIImageView()
        chevronImageView.image = chevronImage
        chevronImageView.tintColor = .ypGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        optionsCellsBackgroundView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            optionsCellsBackgroundView.heightAnchor.constraint(equalToConstant: isIrregularHabbit ? Constant.cellHeihgt : Constant.cellHeihgt * 2),
            categoryVStack.centerYAnchor.constraint(equalTo: optionsCellsBackgroundView.topAnchor, constant: Constant.cellHeihgt / 2),
            categoryVStack.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: Constant.paddingValue),
            categoryVStack.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor, constant: -Constant.paddingValue),
            chevronImageView.centerYAnchor.constraint(equalTo: categoryVStack.centerYAnchor),
        ])
        
        if !isIrregularHabbit {
            let line = DividerLineView()
            line.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(line)
            
            let scheduleLabel = UILabel()
            scheduleLabel.text = "Расписание"
            scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(scheduleLabel)
            
            scheduleVStack.axis = .vertical
            scheduleVStack.spacing = 2
            scheduleVStack.addArrangedSubview(scheduleLabel)
            if let text = weekDaysLabel.text, !text.isEmpty {
                scheduleVStack.addArrangedSubview(weekDaysLabel)
            }
            scheduleVStack.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(scheduleVStack)
            
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
                scheduleVStack.centerYAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor, constant: -(Constant.cellHeihgt / 2)),
                scheduleVStack.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor, constant: Constant.paddingValue),
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
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: SixColumnFlowLayout()
        )
        collectionView.register(EmojyCell.self, forCellWithReuseIdentifier: EmojyCell.reuseIdentifier)
        collectionView.register(TrackerOptionsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrackerOptionsHeaderView.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLogo(to: "Новая привычка")

        collectionView.dataSource = self
        collectionView.delegate = self
        
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
            collectionView
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
            categoryButton.heightAnchor.constraint(equalToConstant: Constant.cellHeihgt),
            
            collectionView.topAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constant.paddingValue),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.paddingValue),
            collectionView.bottomAnchor.constraint(equalTo: buttonHStack.topAnchor, constant: -Constant.paddingValue)
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
        self.schedule = schedule
        updateWeekDaysLabel()
    }
    
    private func updateWeekDaysLabel() {
        var weekDaysString = ""
        var isEveryDay = true
        
        for weekDay in schedule {
            if !weekDay.isChosen {
                isEveryDay = false
                break
            }
        }
        
        guard !isEveryDay else {
            weekDaysLabel.text = "Каждый день"
            return
        }
        
        for weekday in schedule {
            if weekday.isChosen {
                if !weekDaysString.isEmpty {
                    weekDaysString.append(", ")
                }
                weekDaysString.append(weekday.name.shortDescription)
            }
        }
        if !weekDaysString.isEmpty {
            weekDaysLabel.text = weekDaysString
            scheduleVStack.addArrangedSubview(weekDaysLabel)
        } else if let lastLabel = scheduleVStack.arrangedSubviews.last {
            scheduleVStack.removeArrangedSubview(lastLabel)
            lastLabel.removeFromSuperview()
        }
        view.layoutIfNeeded()
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

extension NewHabbitScreenVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TrackerOptionsHeaderView.reuseIdentifier, for: indexPath) as! TrackerOptionsHeaderView
        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emojies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let emoji = emojies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojyCell.reuseIdentifier, for: indexPath) as! EmojyCell
        cell.setEmojy(emoji)
        return cell
    }
}

extension NewHabbitScreenVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 50)
    }
}

#Preview {
    NewHabbitScreenVC(isIrregularHabbit: false)
}
