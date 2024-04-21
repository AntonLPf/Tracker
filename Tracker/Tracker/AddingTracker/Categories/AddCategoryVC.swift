//
//  AddCategoryVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

class AddCategoryVC: UIViewController {
    
    private let addCategoryButton = ActionButton(
        title: "Готово")
    
    private var isValid: Bool {
        false
    }
    
    override func viewDidLoad() {
        setLogo(to: "Новая категория")
        
        addCategoryButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        
        let textField = UITextField(frame: CGRect(x: 50, y: 100, width: 200, height: 40))
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .ypBackgroundGray
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 60),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 84)
        ])
        
        addAndConstrainBottomBlock(addCategoryButton)
        updateView()
    }
    
    @objc func didTapDoneButton() {
        
    }
    
    private func updateView() {
        addCategoryButton.setIsActive(to: isValid)
    }
}

#Preview {
    AddCategoryVC()
}
