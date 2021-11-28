//
//  CollectionView.swift
//  CollectionApp
//
//  Created by Alexandr Evtodiy on 18.11.2021.
//

import UIKit

extension UICollectionViewCell: AutoReusable {
}

extension UICollectionView {
    func register <T: UICollectionViewCell> (_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.autoReuseIdentifier)
    }
    
    func dequeueReusableCell <T: UICollectionViewCell>(ofType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.autoReuseIdentifier, for: indexPath) as? T ?? T()
    }
}
