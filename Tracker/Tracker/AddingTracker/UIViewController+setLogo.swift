//
//  UIViewController+setLogo.swift
//  Tracker
//
//  Created by Антон Шишкин on 20.04.24.
//

import UIKit

extension UIViewController {
    
    func setLogo(to text: String) {
        let logoLabel: UILabel = {
            let label = UILabel()
            label.text = text
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        view.addSubview(logoLabel)
        
        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.heightAnchor.constraint(equalToConstant: Constant.logoHeight),
            logoLabel.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
}
