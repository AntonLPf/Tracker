//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.04.24.
//

import UIKit

class TrackersViewController: UIViewController {
    
    var categories: [TrackerCategory] = []
    
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
                
    override func viewDidLoad() {
        super.viewDidLoad()
        setLargeTitle(to: "Трекеры")
                
        navigationItem.leftBarButtonItem = plusButtonView
        navigationItem.rightBarButtonItem = datePickerView
        
        setPlaceholder(
            image: UIImage(resource: .trackersPlaceHolder),
            text: "Что будем отслеживать?")
        
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
        print("Выбранная дата: \(formattedDate)")
    }
}
