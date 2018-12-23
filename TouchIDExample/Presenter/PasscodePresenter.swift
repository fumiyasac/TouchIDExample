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

    init(previousPasscode: String?) {
        self.previousPasscode = previousPasscode
    }

    // MARK: - Function

    func inputCompleted(_ passcode: String, inputPasscodeType: InputPasscodeType) {
        let passcodeModel = PasscodeModel()

        switch inputPasscodeType {
        
        // 設定したいパスコードの値を確認画面へ引き渡す
        case .inputForCreate, .inputForUpdate:
            self.delegate?.goNext()
            break

        // 前画面で入力したパスコードと突き合わせて、同じだったらUserDefaultへ登録する
        case .retryForCreate, .retryForUpdate:
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

        // パスコードロック画面を解除する
        case .displayPasscodeLock:
            if passcodeModel.compareSavedPasscodeWith(inputPasscode: passcode) {
                self.delegate?.dismissPasscodeLock()
            } else {
                self.delegate?.showError()
            }
            break
        }
    }
}
