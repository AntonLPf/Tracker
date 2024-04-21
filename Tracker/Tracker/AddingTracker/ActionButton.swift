//
//  ActionButton.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

class ActionButton: UIButton {
    init(title: String, action: Selector, isActive: Bool = true) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        setIsActive(to: isActive)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        addTarget(self, action: action, for: .touchUpInside)
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setIsActive(to state: Bool) {
        backgroundColor = state ? .ypBlack : .ypGray
    }
}
