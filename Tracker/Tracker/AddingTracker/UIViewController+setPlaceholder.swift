//
//  UIViewController+setPlaceholder.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

extension UIViewController {
    func setPlaceholder(image: UIImage, text: String) {
        let placeHolderView = PlaceHolderView(image: image, text: text)
        
        view.addSubviews([placeHolderView])
        
        NSLayoutConstraint.activate([
            placeHolderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
