//
//  ColorCell.swift
//  Tracker
//
//  Created by Антон Шишкин on 03.05.24.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ColorCell"
                
    private var categoryColor: CategoryColor = .color1
    
    private var colorViewWidthConstraint: NSLayoutConstraint?
    private var colorViewHeightConstraint: NSLayoutConstraint?
    
    private lazy var colorView: UIView = {
        let colorView = UIView()
        colorView.layer.cornerRadius = 8
        colorView.layer.masksToBounds = true
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        return colorView
    }()
    
    private lazy var borderView: UIView = {
        let borderView = UIView()
        borderView.layer.cornerRadius = 16
        borderView.layer.borderWidth = 3
        return borderView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        layer.masksToBounds = true

        contentView.addSubviews([
            colorView,
            borderView
        ])
        
        NSLayoutConstraint.activate([
            colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(to color: CategoryColor) {
        categoryColor = color
        colorView.backgroundColor = categoryColor.uiColor
        borderView.layer.borderColor = categoryColor.uiColor.withAlphaComponent(0.3).cgColor
    }
    
    func getColor() -> CategoryColor {
        categoryColor
    }
    
    func update() {
        colorViewWidthConstraint?.isActive = false
        colorViewHeightConstraint?.isActive = false
        
        colorViewWidthConstraint = colorView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: isSelected ? 0.7 : 0.8)
        colorViewHeightConstraint = colorView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: isSelected ? 0.7 : 0.8)
        
        colorViewWidthConstraint?.isActive = true
        colorViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            borderView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            borderView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            borderView.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            borderView.centerYAnchor.constraint(equalTo: colorView.centerYAnchor)
        ])
        
        borderView.isHidden = !isSelected
        
        layoutIfNeeded()
    }
}
