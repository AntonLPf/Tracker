//
//  ActionButton.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

class ActionButton: UIButton {
    init(title: String, isActive: Bool = true) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        setIsActive(to: isActive)
        layer.cornerRadius = 16
        clipsToBounds = true
                
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constant.actionButtonHeight)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setIsActive(to state: Bool) {
        backgroundColor = state ? .ypBlack : .ypGray
    }
}
