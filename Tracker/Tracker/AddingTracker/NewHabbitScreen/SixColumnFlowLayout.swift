//
//  SixColumnFlowLayout.swift
//  Tracker
//
//  Created by Антон Шишкин on 01.05.24.
//

import UIKit

final class SixColumnFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width
        let itemWidth = availableWidth / 6
        let itemHeight = itemWidth
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
}
