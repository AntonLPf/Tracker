//
//  CategoriesListVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

class CategoriesListVC: UIViewController {
    
    private lazy var addCategoryButton: UIButton = {
        ActionButton(title: "Добавить категорию", action: #selector(didTapaddCategoryButton), target: self)
    }()
        
    override func viewDidLoad() {
        setLogo(to: "Категории")
        
        addAndConstrainBottomBlock(addCategoryButton)
                
        setPlaceholder(
            image: UIImage(resource: .trackersPlaceHolder),
            text: "Привычки и события можно объединить по смыслу")
        
    }
    
    @objc func didTapaddCategoryButton() {
//        let newHabbitVC = NewHabbitScreenVC(isIrregularHabbit: true)
//        newHabbitVC.modalPresentationStyle = .formSheet
//        present(newHabbitVC, animated: true, completion: nil)
    }
}
