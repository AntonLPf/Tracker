//
//  CategoriesListVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

class CategoriesListVC: UIViewController {
    
    private let addCategoryButton = ActionButton(title: "Добавить категорию", action: #selector(didTapaddCategoryButton))
        
    override func viewDidLoad() {
        setLogo(to: "Категории")
        
        view.addSubviews([
            addCategoryButton,
        ])
        
        setPlaceholder(
            image: UIImage(resource: .trackersPlaceHolder),
            text: "Привычки и события можно объединить по смыслу")
        
        NSLayoutConstraint.activate([
            addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func didTapaddCategoryButton() {
//        let newHabbitVC = NewHabbitScreenVC(isIrregularHabbit: true)
//        newHabbitVC.modalPresentationStyle = .formSheet
//        present(newHabbitVC, animated: true, completion: nil)
    }
}

#Preview {
    CategoriesListVC()
}
