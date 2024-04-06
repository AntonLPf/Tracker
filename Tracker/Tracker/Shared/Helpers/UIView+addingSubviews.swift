//
//  UIView+addingSubviews.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.04.24.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
