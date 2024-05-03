//
//  TrackerTypeSelectionVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 13.04.24.
//

import UIKit

class CreateTrackerVC: UIViewController {
        
    private lazy var habbitButton: UIButton =  {
        ActionButton(title: "Привычка", action: #selector(didTapHabbitButton), target: self)
    }()
    
    private lazy var oneTimeEventButton: UIButton =  {
        ActionButton(title: "Нерегулярное событие", action: #selector(didTapOneTimeEventButton), target: self)
    }()
    
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
        
    @objc func didTapHabbitButton() {
        let newHabbitVC = NewHabbitScreenVC(isIrregularHabbit: false)
        newHabbitVC.modalPresentationStyle = .formSheet
        present(newHabbitVC, animated: true, completion: nil)
    }
    
    @objc func didTapOneTimeEventButton() {
        let newHabbitVC = NewHabbitScreenVC(isIrregularHabbit: true)
        newHabbitVC.modalPresentationStyle = .formSheet
        present(newHabbitVC, animated: true, completion: nil)
    }
}

#Preview {
    CreateTrackerVC()
}
