//
//  UIView+settingTitle.swift
//  Tracker
//
//  Created by Антон Шишкин on 06.04.24.
//

import UIKit

extension UIViewController {
    func setLargeTitle(to titleText: String) {
        self.title = titleText
        self.navigationController?.navigationBar.prefersLargeTitles = true
                navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.largeTitleDisplayMode = .always
    }
}
