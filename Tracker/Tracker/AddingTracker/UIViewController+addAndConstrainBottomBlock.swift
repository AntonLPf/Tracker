//
//  UIViewController+addAndConstrainBottomBlock.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

extension UIViewController {
    func addAndConstrainBottomBlock(_ block: UIView) {
        
        view.addSubviews([
            block
        ])
        
        NSLayoutConstraint.activate([
            block.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            block.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            block.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.paddingValue)
        ])
    }
}
