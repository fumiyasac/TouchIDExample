//
//  SampleCollectionViewCell.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/19.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {

    static let cellMargin: CGFloat = 12.0

    // MARK: - Static Function
    
    static func getCellSize() -> CGSize {
        
        // 縦方向の隙間の個数・文字表示部分の高さ・画像の縦横比
        let numberOfMargin: CGFloat = 2

        // セルのサイズを上記の値を利用して算出する
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - cellMargin * numberOfMargin)
        let cellHeight: CGFloat = 140.0
        return CGSize(width: cellWidth, height: cellHeight)
    }

    // MARK: - Function

    func setCellDecoration() {

        // UICollectionViewのcontentViewプロパティには罫線と角丸に関する設定を行う
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor(code: "#dddddd").cgColor

        // UICollectionViewのおおもとの部分にはドロップシャドウに関する設定を行う
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(code: "#aaaaaa").cgColor
        self.layer.shadowOffset = CGSize(width: 0.33, height: 0.33)
        self.layer.shadowRadius = 1.5
        self.layer.shadowOpacity = 0.24

        // ドロップシャドウの形状をcontentViewに付与した角丸を考慮するようにする
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
