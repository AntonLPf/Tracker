//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.04.24.
//

import UIKit

protocol TrackersViewControllerDelegate {
    func didAddTracker()
    func didDeleteAllTrackers()
}

final class TrackersViewController: UIViewController, UISearchBarDelegate {
    
    var delegate: TrackersViewControllerDelegate? = nil
    
    private let storage: TrackersStorage = InMemoryStorage()
            
    private var currentDate = Date()
    
    private lazy var plusButtonView: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPlusButton))
        button.tintColor = .black
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = currentDate
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var datePickerView: UIBarButtonItem = {
        UIBarButtonItem(customView: datePicker)
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.delegate = self
        return searchController
    }()
        
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: TwoColumnFlowLayout()
        )
        collectionView.register(TrackerCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    private lazy var placeHolderView: PlaceHolderView = {
        let placeHolder = PlaceHolderView(
            image: UIImage(resource: .trackersPlaceHolder),
            text: "Что будем отслеживать?")
        
        return placeHolder
    }()
                
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLargeTitle(to: "Трекеры")
                
        navigationItem.leftBarButtonItem = plusButtonView
        navigationItem.rightBarButtonItem = datePickerView
        
        navigationItem.searchController = searchController
        
        setupCollectionView()
        
        view.addSubviews([
            placeHolderView
        ])
        
        NSLayoutConstraint.activate([
            placeHolderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        updateView()
    }
    
    @objc private func didTapPlusButton(_ sender: Any) {
        let createTrackerVC = CreateTrackerVC()
        createTrackerVC.modalPresentationStyle = .formSheet
        createTrackerVC.delegate = self
        present(createTrackerVC, animated: true, completion: nil)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        currentDate = sender.date
        datePicker.date = currentDate
        collectionView.reloadData()
        updateView()
    }
    
    private func updateView() {
        let categories = storage.getTrackers(date: currentDate)
        for category in categories {
            if !category.trackers.isEmpty {
                placeHolderView.isHidden = true
                collectionView.isHidden = false
                return
            }
        }
        delegate?.didDeleteAllTrackers()
        placeHolderView.isHidden = false
        collectionView.isHidden = true
    }
    
    private func setupCollectionView() {
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        view.addSubviews([collectionView])
        
        let bottomInset: CGFloat = 70
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        
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
        storage.getTrackers(date: currentDate).count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        let categories = storage.getTrackers(date: currentDate)
        headerView.titleLabel.text = categories[indexPath.section].name
        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categories = storage.getTrackers(date: currentDate)
        return categories[section].trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let completedTrackers = storage.getRecords(date: nil)
        let categories = storage.getTrackers(date: currentDate)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TrackerCell
        let tracker = categories[indexPath.section].trackers[indexPath.row]
        
        var isCompleted: Bool {
            completedTrackers.first {
                $0.trackerId == tracker.id &&
                $0.date == currentDate
            } != nil
        }
        
        var numberOfDays: Int {
            var result = 0
            
            for completedTracker in completedTrackers {
                if completedTracker.trackerId == tracker.id {
                    result += 1
                }
            }
            return result
        }
        
        let isButtonEnabled = currentDate <= Date()
        
        cell.setup(tracker: tracker,
                   isCompleted: isCompleted,
                   numberOfDays: numberOfDays,
                   isButtonEnabled: isButtonEnabled)
        
        cell.delegate = self
        return cell
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 46)
    }
}

extension TrackersViewController: TrackerCellDelegate {
    func didTapCellPlusButton(trackerId: UUID) {
        let completedTrackers = storage.getRecords(date: currentDate)
        if let record = (completedTrackers.first { $0.trackerId == trackerId }) {
            storage.removeRecord(record)
        } else {
            let record = TrackerRecord(trackerId: trackerId, date: currentDate)
            storage.addRecord(record)
        }
        collectionView.reloadData()
    }
}

extension TrackersViewController: CreateTrackerDelegate {
    func createNewTracker(trackerData: TrackerData) {
        presentedViewController?.dismiss(animated: true)
        try? storage.addNewTracker(data: trackerData)
        updateView()
        collectionView.reloadData()
        delegate?.didAddTracker()
    }
}
