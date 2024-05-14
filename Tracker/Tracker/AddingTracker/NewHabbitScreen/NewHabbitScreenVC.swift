//
//  NewHabbitScreenVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 14.04.24.
//

import UIKit

protocol NewHabbitScreenDelegate: AnyObject {
    func createNewTracker(trackerData: TrackerData)
}

class NewHabbitScreenVC: UIViewController {
    
    weak var delegate: NewHabbitScreenDelegate? = nil
        
    private var schedule = [
        WeekDay(name: .monday, isChosen: true),
        WeekDay(name: .tuesday, isChosen: true),
        WeekDay(name: .wendsday, isChosen: true),
        WeekDay(name: .thursday, isChosen: true),
        WeekDay(name: .friday, isChosen: true),
        WeekDay(name: .saturday, isChosen: true),
        WeekDay(name: .sunday, isChosen: true)
    ]
    
    private let emojies: [Character] = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    private let categoryColors = CategoryColor.allCases
    
    private var selectedEmojiIndexPath = IndexPath(item: 0, section: 0)
    private var selectedColorIndexPath = IndexPath(item: 0, section: 1)
    
    private var selectedEmojy: Character {
        emojies[selectedEmojiIndexPath.row]
    }
    
    private var selectedColor: CategoryColor {
        categoryColors[selectedColorIndexPath.row]
    }
                
    private let isIrregularHabbit: Bool
    
    private var isNameValid: Bool {
        if let text = nameTextField.text {
            return !text.isEmpty && text.count > 3
        }
        return false
    }
    
    private var isScheduleValid: Bool {
        var result = true
        
        if !isIrregularHabbit && !schedule.contains(where: { $0.isChosen == true }) {
            result = false
        }
        
        return result
    }
    
    private var isCategoryNameValid: Bool {
        if let text = categoriesLabel.text {
            return !text.isEmpty && text.count > 3
        }
        return false
    }
    
    private var isFormValid: Bool {
        isNameValid && isCategoryNameValid && isScheduleValid
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
    
    private lazy var nameWarningLabel: UIView = {
        let container = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ограничение 38 символов"
        label.textColor = UIColor(resource: .ypRed)
        return label
    }()
    
    private lazy var nameWarningContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(nameWarningLabel)
        return container
    }()

    private lazy var nameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textFieldBackgroundView])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
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

            scheduleVStack.translatesAutoresizingMaskIntoConstraints = false
            optionsCellsBackgroundView.addSubview(scheduleVStack)
            
            updateWeekDaysLabel()
            
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
        let button = ActionButton(title: "Отмена",
                                  action: #selector(cancelButtonTapped),
                                  target: self)
        button.backgroundColor = .white
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    private lazy var createButton: ActionButton = {
        let button = ActionButton(title: "Создать", action: #selector(createButtonTapped), target: self)
        button.setIsActive(to: isFormValid)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: SixColumnFlowLayout()
        )
        collectionView.register(EmojyCell.self, forCellWithReuseIdentifier: EmojyCell.reuseIdentifier)
        collectionView.register(TrackerOptionsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrackerOptionsHeaderView.reuseIdentifier)
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var buttonHStack: UIStackView = {
        let buttonHStack = UIStackView()
        buttonHStack.axis = .horizontal
        buttonHStack.spacing = 8
        buttonHStack.distribution = .fillEqually
        buttonHStack.addArrangedSubview(cancelButton)
        buttonHStack.addArrangedSubview(createButton)
        buttonHStack.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonHStack
    }()
    
    private lazy var mainVstack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = Constant.rowSpaceValue
        vStack.distribution = .fill
        vStack.addArrangedSubview(nameStack)
        vStack.addArrangedSubview(optionsCellsBackgroundView)
        vStack.addArrangedSubview(categoryButton)
        vStack.addArrangedSubview(collectionView)
        vStack.addArrangedSubview(buttonHStack)
        return vStack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.addSubviews([
            mainVstack
        ])
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLogo(to: "Новая привычка")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        nameTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        textFieldBackgroundView.addSubviews([
            nameTextField
        ])
        
        view.addSubviews([
            scrollView
        ])
                
        NSLayoutConstraint.activate([
            nameTextField.centerYAnchor.constraint(equalTo: textFieldBackgroundView.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: Constant.paddingValue),
            nameTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -Constant.paddingValue),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.logoHeight + Constant.rowSpaceValue),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.paddingValue),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.paddingValue),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.paddingValue),
            
            mainVstack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainVstack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.paddingValue),
            mainVstack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainVstack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            collectionView.topAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor),
        ])
        
        if !isIrregularHabbit {
            scrollView.addSubview(scheduleButton)
            NSLayoutConstraint.activate([
                scheduleButton.leadingAnchor.constraint(equalTo: optionsCellsBackgroundView.leadingAnchor),
                scheduleButton.trailingAnchor.constraint(equalTo: optionsCellsBackgroundView.trailingAnchor),
                scheduleButton.heightAnchor.constraint(equalToConstant: Constant.cellHeihgt),
                scheduleButton.bottomAnchor.constraint(equalTo: optionsCellsBackgroundView.bottomAnchor),
            ])
        }
        
        collectionView.layoutIfNeeded()
        let totalCollectionHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: totalCollectionHeight)
        ])
        
        scrollView.contentSize = mainVstack.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
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
        guard isFormValid else { return }
        
        guard 
            let name = nameTextField.text,
            let categoryName = categoriesLabel.text
        else { return }
        
        var weekDayNameSet: Set<WeekDay.WeekDayName> {
            var result: Set<WeekDay.WeekDayName> = []
            
            guard !isIrregularHabbit else { return result }
            
            for weekDay in schedule {
                if weekDay.isChosen {
                    result.insert(weekDay.name)
                }
            }
            return result
        }
        
        let trackerData = TrackerData(name: name, 
                                      categoryName: categoryName,
                                      color: selectedColor,
                                      icon: selectedEmojy,
                                      schedule: weekDayNameSet)
        delegate?.createNewTracker(trackerData: trackerData)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    private func updateTrackerSchedule(_ schedule: [WeekDay]) {
        self.schedule = schedule
        updateWeekDaysLabel()
        updateCreateButtonState()
    }
    
    private func updateWeekDaysLabel() {
        var weekDaysString = "Каждый день"
        
        if !isScheduleValid {
            weekDaysString = "Укажите расписание"
            weekDaysLabel.text = weekDaysString
            scheduleVStack.addArrangedSubview(weekDaysLabel)
            weekDaysLabel.textColor = .ypRed
            return
        }
        
        var isEveryDay = true
        
        for weekDay in schedule {
            if !weekDay.isChosen {
                isEveryDay = false
                break
            }
        }
        
        if !isEveryDay {
            weekDaysString = ""
            for weekday in schedule {
                if weekday.isChosen {
                    if !weekDaysString.isEmpty {
                        weekDaysString.append(", ")
                    }
                    weekDaysString.append(weekday.name.shortDescription)
                }
            }
        }
        
        if !weekDaysString.isEmpty {
            weekDaysLabel.text = weekDaysString
            scheduleVStack.addArrangedSubview(weekDaysLabel)
            weekDaysLabel.textColor = .ypGray
        } else if let lastLabel = scheduleVStack.arrangedSubviews.last {
            scheduleVStack.removeArrangedSubview(lastLabel)
            lastLabel.removeFromSuperview()
        }
        view.layoutIfNeeded()
    }
    
    private func updateCreateButtonState() {
        createButton.setIsActive(to: isFormValid)
    }
    
    private var nameWarningCenterXConstraint: NSLayoutConstraint?
    
    private func showNameWarning() {
        nameStack.addArrangedSubview(nameWarningContainer)
        NSLayoutConstraint.activate([
            nameWarningLabel.centerXAnchor.constraint(equalTo: nameTextField.centerXAnchor)
        ])
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
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TrackerOptionsHeaderView.reuseIdentifier, for: indexPath) as! TrackerOptionsHeaderView
        
        if indexPath.section == 0 {
            headerView.setTitle(to: "Emoji")
        } else {
            headerView.setTitle(to: "Цвет")
        }
        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let emoji = emojies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojyCell.reuseIdentifier, for: indexPath) as! EmojyCell
            cell.setEmoji(to: emoji)
            cell.setSelection(indexPath == selectedEmojiIndexPath)
            return cell
        } else {
            let color = categoryColors[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as! ColorCell
            cell.setColor(to: color)
            cell.isSelected = indexPath == selectedColorIndexPath
            cell.update()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard indexPath != selectedEmojiIndexPath else { return }
            
            let cellToDeselect = collectionView.cellForItem(at: selectedEmojiIndexPath) as? EmojyCell
            cellToDeselect?.setSelection(false)
            
            selectedEmojiIndexPath = indexPath
            
            let cell = collectionView.cellForItem(at: indexPath) as? EmojyCell
            cell?.setSelection(true)
        } else {
            guard indexPath != selectedColorIndexPath else { return }
            
            let cellToDeselect = collectionView.cellForItem(at: selectedColorIndexPath) as? ColorCell
            cellToDeselect?.isSelected = false
            cellToDeselect?.update()
            
            selectedColorIndexPath = indexPath
            
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cellToDeselect?.isSelected = true
            cell?.update()
        }
    }
    
}

extension NewHabbitScreenVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: Constant.collectionHeaderHeight)
    }
}

extension NewHabbitScreenVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        let textLength = newText.count
        
        if textLength > 38 {
            showNameWarning()
            createButton.setIsActive(to: false)
        } else {
            createButton.setIsActive(to: isFormValid)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
