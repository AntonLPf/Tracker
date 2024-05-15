//
//  PlaceHolderView.swift
//  Tracker
//
//  Created by Антон Шишкин on 06.04.24.
//

import UIKit

class PlaceHolderView: UIView {
    
    private let image: UIImage
    private let text: String
    
    private lazy var placeHolderImageView: UIImageView = {
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var placeHolderView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [placeHolderImageView, placeHolderLabel])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
        super.init(frame: .zero)
        addSubview(placeHolderView)
        applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            placeHolderImageView.widthAnchor.constraint(equalToConstant: 80),
            placeHolderView.widthAnchor.constraint(equalToConstant: 250),
            placeHolderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeHolderView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
