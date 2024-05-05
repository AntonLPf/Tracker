//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.04.24.
//

import UIKit

final class TrackersViewController: UIViewController, UISearchBarDelegate {
    
    let storage: TrackersStorage = InMemoryStorage()
        
    var completedTrackers: [TrackerRecord] = []
    
    var currentDate = Date()
    
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
        createTrackerVC.delegate = self
        present(createTrackerVC, animated: true, completion: nil)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        currentDate = selectedDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        print(formattedDate.description)
    }
    
    private func updateView() {
        let categories = storage.getTrackers()
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
        storage.getTrackers().count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        let categories = storage.getTrackers()
        headerView.titleLabel.text = categories[indexPath.section].name
        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categories = storage.getTrackers()
        return categories[section].trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categories = storage.getTrackers()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TrackerCell
        let tracker = categories[indexPath.section].trackers[indexPath.row]
        cell.setup(tracker: tracker)
        cell.delegate = self
        return cell
    }
}

extension TrackersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 46)
    }
}

extension TrackersViewController: TrackerCellDelegate {
    func didTapCellPlusButton(trackerId: UUID) {
        
    }
}

extension TrackersViewController: CreateTrackerDelegate {
    func createNewTracker(trackerData: TrackerData) {
        presentedViewController?.dismiss(animated: true)
        try! storage.addNewTracker(data: trackerData)
        
        collectionView.performBatchUpdates({
                    // Perform any insertions, deletions, or other updates here
                    // For example, you can insert a new item into the collection view
                    let newIndexPath = IndexPath(item: storage.getTrackers().count - 1, section: 0)
                    collectionView.insertItems(at: [newIndexPath])
                }, completion: nil)
    }
}

#Preview {
    TrackersNavViewController()
}
