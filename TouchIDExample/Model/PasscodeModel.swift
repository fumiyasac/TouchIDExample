//
//  PasscodeModel.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/19.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation

class PasscodeModel {

    private let userHashedPasscode = "PasscodeModel:userHashedPasscode"

    private var ud: UserDefaults {
        return UserDefaults.standard
    }

    // MARK: - Function

    func saveHashedPasscode(_ passcode: String) -> Bool {
        if isValid(passcode) {
            setHashedPasscode(passcode)
            return true
        } else {
            return false
        }
    }

    func compareSavedPasscodeWith(inputPasscode: String) -> Bool {
        let hashedInputPasscode = getHashedPasscodeByHMAC(inputPasscode)
        let savedPasscode = getHashedPasscode()
        return hashedInputPasscode == savedPasscode
    }

    func existsHashedPasscode() -> Bool {
        let savedPasscode = getHashedPasscode()
        return !savedPasscode.isEmpty
    }

    func getHashedPasscode() -> String {
        return ud.string(forKey: userHashedPasscode) ?? ""
    }

    func deleteHashedPasscode() {
        ud.set("", forKey: userHashedPasscode)
    }

    // MARK: - Private Function

    // 引数で受け取ったパスコードをhmacで暗号化した上で保存する
    private func setHashedPasscode(_ passcode: String) {
        let hashedPasscode = getHashedPasscodeByHMAC(passcode)
        ud.set(hashedPasscode, forKey: userHashedPasscode)
    }

    // 引数で受け取った値をhmacで暗号化する
    private func getHashedPasscodeByHMAC(_ passcode: String) -> String {
        return passcode.hmac(algorithm: .SHA256)
    }

    // 引数で受け取った値の形式が正しいかどうかを判定する
    private func isValid(_ passcode: String) -> Bool {
        return isValidLength(passcode) && isValidFormat(passcode)
    }

    // 引数で受け取った値が4文字かを判定する
    private func isValidLength(_ passcode: String) -> Bool {
        return passcode.count == AppConstant.PASSCODE_LENGTH
    }

    // 引数で受け取った値が半角数字かを判定する
    private func isValidFormat(_ passcode: String) -> Bool {
        let regexp = try! NSRegularExpression.init(pattern: "^(?=.*?[0-9])[0-9]{4}$", options: [])
        let targetString = passcode as NSString
        let result = regexp.firstMatch(in: passcode, options: [], range: NSRange.init(location: 0, length: targetString.length))
        return result != nil
    }
}
