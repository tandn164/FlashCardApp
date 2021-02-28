//
//  UICollectionViewController+Extension.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/5/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    class func dequeueCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> Self? {
        return collectionView.dequeueCell(self, forIndexPath: indexPath)
    }
    
}

extension UICollectionReusableView {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    func registerCellByNib<T: UICollectionViewCell>(_ type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: type.identifier)
    }
    
    func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }
    
    func registerHeaderByNib<T: UICollectionReusableView>(_ type: T.Type) {
        register(type.nib,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_ type: T.Type,
                                                    forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader
                                                , withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func dequeueFooter<T: UICollectionReusableView>(_ type: T.Type,
                                                    forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func registerFooterByNib<T: UICollectionReusableView>(_ type: T.Type) {
        register(type.nib,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: type.identifier)
    }
}
