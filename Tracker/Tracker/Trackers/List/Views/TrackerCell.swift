//
//  TrackerCell.swift
//  Tracker
//
//  Created by Антон Шишкин on 03.05.24.
//

import UIKit

final class TrackerCell: UICollectionViewCell {
    
    static let buttonRadius: CGFloat = 34
        
    private let backgroundColoredView: UIView = {
        let coloredView = UIView()
        coloredView.backgroundColor = .red
        coloredView.layer.cornerRadius = Constant.cornerRadius
        return coloredView
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .red
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = TrackerCell.buttonRadius / 2
        button.clipsToBounds = true
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "1 день"
        return label
    }()
    
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.text = "Поливать растения"
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.textContainer.maximumNumberOfLines = 2
        textView.backgroundColor = .clear
        textView.textColor = .white
        
        return textView
    }()
    
    private let emogiView = EmojiView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubviews([
            backgroundColoredView,
            plusButton,
            countLabel,
            nameTextView,
            emogiView
        ])
        
        NSLayoutConstraint.activate([
            backgroundColoredView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundColoredView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundColoredView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundColoredView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -58),
            
            plusButton.widthAnchor.constraint(equalToConstant: Self.buttonRadius),
            plusButton.heightAnchor.constraint(equalToConstant: Self.buttonRadius),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            plusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            countLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            
            nameTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44),
            nameTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nameTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            nameTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(tracker: Tracker) {
        nameTextView.text = tracker.name
        backgroundColoredView.backgroundColor = tracker.color.uiColor
        plusButton.backgroundColor = tracker.color.uiColor
        emogiView.setEmoji(tracker.icon)
    }
}
