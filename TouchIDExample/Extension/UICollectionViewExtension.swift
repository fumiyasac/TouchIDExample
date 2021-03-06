//
//  UICollectionViewExtension.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/16.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// UICollectionReusableViewの拡張
extension UICollectionReusableView {

    // 独自に定義したセルのクラス名を返す
    static var identifier: String {
        return className
    }
}

// UICollectionViewの拡張
extension UICollectionView {

    // 作成した独自のカスタムセルを初期化するメソッド
    func registerCustomCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }

    // 作成した独自のカスタムセルをインスタンス化するメソッド
    func dequeueReusableCustomCell<T: UICollectionViewCell>(with cellType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    // 作成した独自のカスタムヘッダービューをインスタンス化するメソッド
    func dequeueReusableCustomHeaderView<T: UICollectionReusableView>(with cellType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    // 作成した独自のカスタムヘッダービューをインスタンス化するメソッド
    func dequeueReusableCustomFooterView<T: UICollectionReusableView>(with cellType: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
