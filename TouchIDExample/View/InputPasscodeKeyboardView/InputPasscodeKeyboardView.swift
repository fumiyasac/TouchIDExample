//
//  InputPasscodeKeyboardView.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/17.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MEMO: このViewに配置しているボタンが押下された場合に値の変更を反映させるためのプロトコル
protocol InputPasscodeKeyboardDelegate: NSObjectProtocol {

    // 0~9の数字ボタンが押下された場合にその数字を文字列で送る
    func inputPasscodeNumber(_ numberOfString: String)

    // 削除ボタンが押下された場合に値を削除する
    func deletePasscodeNumber()

    // TouchID/FaceID搭載端末の場合に実行する
    func executeLocalAuthentication()
}

class InputPasscodeKeyboardView: CustomViewBase {

    weak var delegate: InputPasscodeKeyboardDelegate?

    // ボタン押下時の軽微な振動を追加する
    private let buttonFeedbackGenerator: UIImpactFeedbackGenerator = {
        let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        return generator
    }()

    // パスコードロック用の数値入力用ボタン
    // MEMO: 「Outlet Collection」を用いて接続しているのでweakはけつけていません
    @IBOutlet private var inputPasscodeNumberButtons: [UIButton]!

    // パスコードロック用のLocalAuthentication実行用ボタン
    @IBOutlet private weak var executeLocalAuthenticationButton: UIButton!

    // パスコードロック用の数値削除用ボタン
    @IBOutlet private weak var deletePasscodeNumberButton: UIButton!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupInputPasscodeKeyboardView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupInputPasscodeKeyboardView()
    }

    // MARK: - Function

    func shouldEnabledLocalAuthenticationButton(_ result: Bool = true) {
        executeLocalAuthenticationButton.isEnabled = result
        executeLocalAuthenticationButton.superview?.alpha = (result) ? 1.0 : 0.3
    }

    // MARK: - Private Function

    @objc private func inputPasscodeNumberButtonTapped(sender: UIButton) {
        guard let superView = sender.superview else {
            return
        }
        executeButtonAnimation(for: superView)
        buttonFeedbackGenerator.impactOccurred()
        self.delegate?.inputPasscodeNumber(String(sender.tag))
    }

    @objc private func deletePasscodeNumberButtonTapped(sender: UIButton) {
        guard let superView = sender.superview else {
            return
        }
        executeButtonAnimation(for: superView)
        buttonFeedbackGenerator.impactOccurred()
        self.delegate?.deletePasscodeNumber()
    }

    @objc private func executeLocalAuthenticationButtonTapped(sender: UIButton) {
        guard let superView = sender.superview else {
            return
        }
        executeButtonAnimation(for: superView)
        buttonFeedbackGenerator.impactOccurred()
        self.delegate?.executeLocalAuthentication()
    }

    private func setupInputPasscodeKeyboardView() {
        inputPasscodeNumberButtons.enumerated().forEach {
            let button = $0.element
            button.addTarget(self, action: #selector(self.inputPasscodeNumberButtonTapped(sender:)), for: .touchDown)
        }
        deletePasscodeNumberButton.addTarget(self, action: #selector(self.deletePasscodeNumberButtonTapped(sender:)), for: .touchDown)
        executeLocalAuthenticationButton.addTarget(self, action: #selector(self.executeLocalAuthenticationButtonTapped(sender:)), for: .touchDown)
    }

    private func executeButtonAnimation(for targetView: UIView, completionHandler: (() -> ())? = nil) {

        // MEMO: ユーザーの入力レスポンスがアニメーションによって遅延しないような考慮をする
        UIView.animateKeyframes(withDuration: 0.16, delay: 0.0, options: [.allowUserInteraction, .autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 1.0, animations: {
                targetView.alpha = 0.5
            })
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 1.0, animations: {
                targetView.alpha = 1.0
            })
        }, completion: { finished in
            completionHandler?()
        })
    }
}
