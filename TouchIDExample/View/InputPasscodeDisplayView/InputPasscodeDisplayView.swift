//
//  InputPasscodeDisplayView.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/17.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

class InputPasscodeDisplayView: CustomViewBase {
    
    private let defaultKeyImageAlpha: CGFloat = 0.3
    private let selectedKeyImageAlpha: CGFloat = 1.0

    @IBOutlet private var keyImageViews: [UIImageView]!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupInputPasscodeDisplayView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupInputPasscodeDisplayView()
    }

    // MARK: - Function

    // 鍵マーク表示部分が増えていくような動きを実現する
    func incrementDisplayImagesBy(passcodeStringCount: Int = 0) {

        keyImageViews.enumerated().forEach {
            let imageView = $0.element

            guard let superView = imageView.superview else {
                return
            }

            // MEMO: 引数で渡された値とタグ値が一致した場合にはアニメーションを実行する
            if imageView.tag == passcodeStringCount {
                imageView.alpha = selectedKeyImageAlpha
                executeKeyImageAnimation(for: superView)
            } else if imageView.tag < passcodeStringCount {
                imageView.alpha = selectedKeyImageAlpha
            } else {
                imageView.alpha = defaultKeyImageAlpha
            }
        }
    }

    // 鍵マーク表示部分が減っていくような動きを実現する
    func decrementDisplayImagesBy(passcodeStringCount: Int = 0) {

        keyImageViews.enumerated().forEach {
            let imageView = $0.element

            // MEMO: 入力した情報を消去する場合はアニメーションは実行しません
            if imageView.tag <= passcodeStringCount {
                imageView.alpha = selectedKeyImageAlpha
            } else {
                imageView.alpha = defaultKeyImageAlpha
            }
        }
    }

    // MARK: - Private Function

    private func setupInputPasscodeDisplayView() {
        keyImageViews.enumerated().forEach {
            let imageView = $0.element
            imageView.image = UIImage.fontAwesomeIcon(name: .key, style: .solid, textColor: .black, size: CGSize(width: 48.0, height: 48.0))
            imageView.alpha = defaultKeyImageAlpha
        }
    }

    // パスコード入力画面用の画像が弾む様なアニメーションをする
    private func executeKeyImageAnimation(for targetView: UIView, completionHandler: (() -> ())? = nil) {

        // アイコン画像用のViewが縮むようにバウンドするアニメーションを付与する
        UIView.animateKeyframes(withDuration: 0.06, delay: 0.0, options: [.autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0, animations: {
                targetView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 1.0, animations: {
                targetView.transform = CGAffineTransform.identity
            })
        }, completion: { finished in
            completionHandler?()
        })
    }
}
