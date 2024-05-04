//
//  TrackerOptionsHeaderView.swift
//  Tracker
//
//  Created by Антон Шишкин on 03.05.24.
//

import UIKit

final class TrackerOptionsHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "TrackerOptionsHeaderView"
    
    private var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.paddingValue),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.paddingValue),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.paddingValue),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(to string: String) {
        titleLabel.text = string
    }
}
