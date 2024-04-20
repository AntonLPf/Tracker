//
//  TrackerTypeSelectionVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 13.04.24.
//

import UIKit

class CreateTrackerVC: UIViewController {
    
    private let habbitButton: UIButton = UIButton(type: .system)
    
    private let oneTimeEventButton: UIButton = UIButton(type: .system)
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground  
        setLogo(to: "Создание трекера")
        configure(button: habbitButton, title: "Привычка", action: #selector(didTapHabbitButton))
        configure(button: oneTimeEventButton, title: "Нерегулярное событие", action: #selector(didTapOneTimeEventButton))
        vStack.addArrangedSubview(habbitButton)
        vStack.addArrangedSubview(oneTimeEventButton)
        view.addSubview(vStack)
        applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configure(button: UIButton, title: String, action: Selector) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .ypBlack
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        
        button.addTarget(self, action: action, for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func didTapHabbitButton() {
        let newHabbitVC = NewHabbitScreenVC()
        newHabbitVC.modalPresentationStyle = .formSheet
        present(newHabbitVC, animated: true, completion: nil)
    }
    
    @objc func didTapOneTimeEventButton() {
        
    }
}

#Preview {
    CreateTrackerVC()
}
