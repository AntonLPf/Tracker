//
//  EmojiView.swift
//  Tracker
//
//  Created by Антон Шишкин on 03.05.24.
//

import UIKit

class EmojiView: UIView {
    let roundedView: UIView = {
        let roundedView = UIView()
        roundedView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        return roundedView
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubviews([
            roundedView,
            emojiLabel
        ])
        
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            
            roundedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            roundedView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            roundedView.heightAnchor.constraint(equalToConstant: 24),
            roundedView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        roundedView.layer.cornerRadius = 12
        roundedView.layer.masksToBounds = true

    }
    
    func setEmoji(_ emoji: Character) {
        emojiLabel.text = String(emoji)
    }
}
