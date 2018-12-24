//
//  PasscodePresenter.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/22.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation

protocol PasscodePresenterDelegate: NSObjectProtocol {
    func goNext()
    func dismissPasscodeLock()
    func savePasscode()
    func showError()
}

class PasscodePresenter {

    private let previousPasscode: String?

    weak var delegate: PasscodePresenterDelegate?

    // MARK: - Initializer

    // MEMO: 前の画面で入力したパスコードを利用したい場合は引数に設定する
    init(previousPasscode: String?) {
        self.previousPasscode = previousPasscode
    }

    // MARK: - Function

    // ViewController側でパスコードの入力が完了した場合に実行する処理
    func inputCompleted(_ passcode: String, inputPasscodeType: InputPasscodeType) {
        let passcodeModel = PasscodeModel()

        switch inputPasscodeType {
        
        case .inputForCreate, .inputForUpdate:

            // 再度パスコードを入力するための確認画面へ遷移する
            self.delegate?.goNext()
            break


        case .retryForCreate, .retryForUpdate:

            // 前画面で入力したパスコードと突き合わせて、同じだったらUserDefaultへ登録する
            if previousPasscode != passcode {
                self.delegate?.showError()
                return
            }
            if passcodeModel.saveHashedPasscode(passcode) {
                self.delegate?.savePasscode()
            } else {
                self.delegate?.showError()
            }
            break


        case .displayPasscodeLock:

            // 保存されているユーザーが設定したパスコードと突き合わせて、同じだったらパスコードロック画面を解除する
            if passcodeModel.compareSavedPasscodeWith(inputPasscode: passcode) {
                self.delegate?.dismissPasscodeLock()
            } else {
                self.delegate?.showError()
            }
            break
        }
    }
}
