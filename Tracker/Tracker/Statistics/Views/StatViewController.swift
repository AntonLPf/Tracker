//
//  StatViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.04.24.
//

import UIKit

class StatViewController: UIViewController {
    
    private lazy var placeHolderView: UIView = {
        let image = UIImage(resource: .statisticsPlaceHolder)
        let text = "Анализировать пока нечего"
        return PlaceHolderView(image: image, text: text)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLargeTitle(to: "Статистика")

        view.addSubviews([placeHolderView])
        applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            placeHolderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
