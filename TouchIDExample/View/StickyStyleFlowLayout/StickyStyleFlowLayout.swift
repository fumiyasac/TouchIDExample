//
//  StickyStyleFlowLayout.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/17.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// 参考1: 参考にしたリポジトリ
// https://github.com/matbeich/stickycollectionview-swift

// 参考2: UICollectionViewのカスタムレイアウトをする上でのポイント
// https://dev.classmethod.jp/smartphone/iphone/ios6-uicollectionview-customlayout/

class StickyStyleFlowLayout: UICollectionViewFlowLayout {

    // 拡大縮小比を変更するための変数（値を変更する必要がある場合のみ利用する）
    var firstItemTransform: CGFloat?

    // 引数で渡された範囲内に表示されているUICollectionViewLayoutAttributesを返す
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // 該当のUICollectionViewLayoutAttributesを取得する
        let items = NSArray(array: super.layoutAttributesForElements(in: rect)!, copyItems: true)

        // 該当のUICollectionViewにへHeaderまたはFooterを
        var headerAttributes: UICollectionViewLayoutAttributes?
        var footerAttributes: UICollectionViewLayoutAttributes?

        // 該当のUICollectionViewLayoutAttributesに対してUICollectionViewLayoutAttributesの更新をする
        items.enumerateObjects(using: { (object, _, _) -> Void in

            let attributes = object as! UICollectionViewLayoutAttributes

            // Header・Footer・セルの場合で場合分けをする
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                headerAttributes = attributes
            } else if attributes.representedElementKind == UICollectionView.elementKindSectionFooter {
                footerAttributes = attributes
            } else {
                self.updateCellAttributes(attributes, headerAttributes: headerAttributes, footerAttributes: footerAttributes)
            }
        })
        return items as? [UICollectionViewLayoutAttributes]
    }

    // 更新された位置情報からレイアウト処理を再実行するか
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // MARK: - Private Function

    // 該当のセルにおけるUICollectionViewLayoutAttributesの値を更新する
    private func updateCellAttributes(_ attributes: UICollectionViewLayoutAttributes, headerAttributes: UICollectionViewLayoutAttributes?, footerAttributes: UICollectionViewLayoutAttributes?) {

        // 配置しているUICollectionViewにおける最大値・最小値を取得しておく
        let minY = collectionView!.bounds.minY + collectionView!.contentInset.top
        var maxY = attributes.frame.origin.y

        // Headerを利用している場合はその分の高さ減算する
        if let headerAttributes = headerAttributes {
            maxY -= headerAttributes.bounds.height
        }

        // Footerを利用している場合はその分の高さ減算する
        if let footerAttributes = footerAttributes {
            maxY -= footerAttributes.bounds.height
        }

        // 該当のUICollectionViewLayoutAttributesの拡大縮小比を調節して表示する
        var origin = attributes.frame.origin

        let finalY = max(minY, maxY)
        let deltaY = (finalY - origin.y) / attributes.frame.height

        if let itemTransform = firstItemTransform {
            let scale = 1 - deltaY * itemTransform
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }

        origin.y = finalY
        attributes.frame = CGRect(origin: origin, size: attributes.frame.size)
        attributes.zIndex = attributes.indexPath.row
    }
}
