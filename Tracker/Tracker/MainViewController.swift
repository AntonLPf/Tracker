//
//  ViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 04.04.24.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        
        tabBar.tintColor = .ypBlue
        tabBar.unselectedItemTintColor = .ypGray
        tabBar.isTranslucent = false
        tabBar.barTintColor = .ypBlue
        tabBar.backgroundColor = .ypWhite
        
        let trackersVC = TrackersNavViewController()
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
    }
}
