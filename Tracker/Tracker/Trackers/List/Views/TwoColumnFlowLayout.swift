//
//  TwoColumnFlowLayout.swift
//  Tracker
//
//  Created by Антон Шишкин on 03.05.24.
//

import UIKit

final class TwoColumnFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing
        let itemWidth = availableWidth / 2
        
        itemSize = CGSize(width: itemWidth, height: 148)
        minimumLineSpacing = 0
    }
}
