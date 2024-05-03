//
//  EmojyCell.swift
//  Tracker
//
//  Created by Антон Шишкин on 01.05.24.
//

import UIKit

final class EmojyCell: UICollectionViewCell {
    
    static let reuseIdentifier = "EmojyCell"
        
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([
            emojiLabel
        ])
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEmojy(_ char: Character) {
        emojiLabel.text = String(char)
    }
}
