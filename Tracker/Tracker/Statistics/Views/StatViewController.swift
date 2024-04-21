//
//  StatViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.04.24.
//

import UIKit

class StatViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLargeTitle(to: "Статистика")

        setPlaceholder(
            image: UIImage(resource: .statisticsPlaceHolder),
            text: "Анализировать пока нечего")
    }
}
