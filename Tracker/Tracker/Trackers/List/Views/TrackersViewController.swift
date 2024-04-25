//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.04.24.
//

import UIKit

final class TrackersViewController: UIViewController, UISearchBarDelegate {
    
    var categories: [TrackerCategory] = [
        TrackerCategory(name: "Домашний уют", trackers: [
            Tracker(id: UUID(), name: "Поливать растения", color: .color5, icon: "❤️"),
        ]),
        TrackerCategory(name: "Радостные мелочи", trackers: [
            Tracker(id: UUID(), name: "Кошка заслонила камеру на созвоне", color: .color2, icon: "😻"),
            Tracker(id: UUID(), name: "Бабушка прислала открытку в вотсапе", color: .color1, icon: "🌺")
        ]),
    ]
    
    var completedTrackers: [TrackerRecord] = []
    
    private lazy var plusButtonView: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPlusButton))
        button.tintColor = .black
        return button
    }()
    
    private lazy var datePickerView: UIBarButtonItem = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        let item = UIBarButtonItem(customView: datePicker)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return item
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.delegate = self
        return searchController
    }()
        
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: TwoColumnFlowLayout()
        )
        collectionView.register(TrackerCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
                
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLargeTitle(to: "Трекеры")
                
        navigationItem.leftBarButtonItem = plusButtonView
        navigationItem.rightBarButtonItem = datePickerView
        
        navigationItem.searchController = searchController
        updateView()
    }
    
    @objc private func didTapPlusButton(_ sender: Any) {
        let createTrackerVC = CreateTrackerVC()
        createTrackerVC.modalPresentationStyle = .formSheet
        present(createTrackerVC, animated: true, completion: nil)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        print(formattedDate.description)
    }
    
    private func updateView() {
        guard !categories.isEmpty else {
            setPlaceholder(
                image: UIImage(resource: .trackersPlaceHolder),
                text: "Что будем отслеживать?")
            return
        }
        
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        view.addSubviews([collectionView])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constant.paddingValue),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.paddingValue),
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        headerView.titleLabel.text = categories[indexPath.section].name
        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories[section].trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TrackerCell
        let tracker = categories[indexPath.section].trackers[indexPath.row]
        cell.update(tracker: tracker)
        return cell
    }
}

extension TrackersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

final class TrackerCell: UICollectionViewCell {
    
    static let buttonRadius: CGFloat = 34
        
    private let backgroundColoredView: UIView = {
        let coloredView = UIView()
        coloredView.backgroundColor = .red
        coloredView.layer.cornerRadius = Constant.cornerRadius
        return coloredView
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .red
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = TrackerCell.buttonRadius / 2
        button.clipsToBounds = true
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "1 день"
        return label
    }()
    
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.text = "Поливать растения"
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.textContainer.maximumNumberOfLines = 2
        textView.backgroundColor = .clear
        textView.textColor = .white
        
        return textView
    }()
    
    private let emogiView = EmojiView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubviews([
            backgroundColoredView,
            plusButton,
            countLabel,
            nameTextView,
            emogiView
        ])
        
        NSLayoutConstraint.activate([
            backgroundColoredView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundColoredView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundColoredView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundColoredView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -58),
            
            plusButton.widthAnchor.constraint(equalToConstant: Self.buttonRadius),
            plusButton.heightAnchor.constraint(equalToConstant: Self.buttonRadius),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            plusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            countLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            
            nameTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44),
            nameTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            nameTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(tracker: Tracker) {
        nameTextView.text = tracker.name
        backgroundColoredView.backgroundColor = tracker.color.uiColor
        plusButton.backgroundColor = tracker.color.uiColor
        emogiView.setEmoji(tracker.icon)
    }
}

final class HeaderView: UICollectionReusableView {
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TwoColumnFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing
        let itemWidth = availableWidth / 2
        
        itemSize = CGSize(width: itemWidth, height: 148)
        minimumLineSpacing = 0
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 46)
    }
}

class EmojiView: UIView {
    let roundedView: UIView = {
        let roundedView = UIView()
        roundedView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        return roundedView
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubviews([
            roundedView,
            emojiLabel
        ])
        
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            
            roundedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            roundedView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            roundedView.heightAnchor.constraint(equalToConstant: 24),
            roundedView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        roundedView.layer.cornerRadius = 12
        roundedView.layer.masksToBounds = true

    }
    
    func setEmoji(_ emoji: Character) {
        emojiLabel.text = String(emoji)
    }
}

#Preview {
    TrackersNavViewController()
}
