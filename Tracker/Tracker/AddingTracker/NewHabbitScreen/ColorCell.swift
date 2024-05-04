//
//  ColorCell.swift
//  Tracker
//
//  Created by Антон Шишкин on 03.05.24.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ColorCell"
            
    private var categoryColor = CategoryColor.color1
    
    private lazy var colorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colorView.layer.cornerRadius = 8
        colorView.layer.masksToBounds = true
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        setSelection(isSelected)
        
        contentView.addSubviews([
            colorView
        ])

        NSLayoutConstraint.activate([
            colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(to color: CategoryColor) {
        categoryColor = color
        colorView.backgroundColor = color.uiColor
    }
    
    func getColor() -> CategoryColor {
        categoryColor
    }
    
    func setSelection(_ selected: Bool) {
        isSelected = selected
        backgroundColor = selected ? .ypBackgroundGrayPure : .clear
    }
}
