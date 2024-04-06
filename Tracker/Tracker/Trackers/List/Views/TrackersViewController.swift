//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.04.24.
//

import UIKit

class TrackersViewController: UIViewController {
    
    private lazy var plusButtonView: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPlusButton))
        button.tintColor = .black
        return button
    }()
    
    private lazy var datePickerView: UIBarButtonItem = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let item = UIBarButtonItem(customView: datePicker)
        return item
    }()
        
    private lazy var placeHolderView: UIView = {
        let image = UIImage(resource: .trackersPlaceHolder)
        let text = "Что будем отслеживать?"
        return PlaceHolderView(image: image, text: text)
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setLargeTitle(to: "Трекеры")
                
        navigationItem.leftBarButtonItem = plusButtonView
        navigationItem.rightBarButtonItem = datePickerView
        
        view.addSubviews([placeHolderView])
        applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            placeHolderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func didTapPlusButton(_ sender: Any) {
        
    }
}
