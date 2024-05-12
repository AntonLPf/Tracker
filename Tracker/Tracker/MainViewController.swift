//
//  ViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 04.04.24.
//

import UIKit

class MainViewController: UITabBarController {
    
    private lazy var filtersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Фильтры", for: .normal)
        button.backgroundColor = .ypBlue
        button.layer.cornerRadius = Constant.cornerRadius
        button.setTitleColor(UIColor.white, for: .normal)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 114),
            button.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        
        tabBar.tintColor = .ypBlue
        tabBar.unselectedItemTintColor = .ypGray
        tabBar.isTranslucent = false
        tabBar.barTintColor = .ypBlue
        tabBar.backgroundColor = .ypWhite
        
        let trackersVC = TrackersNavViewController()
        trackersVC.trackersVCdelegate = self
        trackersVC.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(systemName: "record.circle.fill"),
            selectedImage: nil
        )
        
        let statVC = StatisticsNavViewController()
        statVC.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(systemName: "hare.fill"),
            selectedImage: nil
        )
        viewControllers = [trackersVC, statVC]
        view.addSubviews([filtersButton])
        
        NSLayoutConstraint.activate([
            filtersButton.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -16),
            filtersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func showFilterButton() {
        filtersButton.isHidden = false
    }
    
    private func removeFilterButton() {
        filtersButton.isHidden = true
    }
}

extension MainViewController: TrackersNavViewControllerDelegate {
    func didAddTracker() {
        showFilterButton()
    }
    
    func didDeleteAllTrackers() {
        removeFilterButton()
    }
}
