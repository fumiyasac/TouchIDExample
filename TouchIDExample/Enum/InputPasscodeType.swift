//
//  InputPasscodeType.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/22.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation

enum InputPasscodeType {
    case inputForCreate      // パスコードの新規作成
    case retryForCreate      // パスコードの新規作成時の確認
    case inputForUpdate      // パスコードの変更
    case retryForUpdate      // パスコードの変更時の確認
    case displayPasscodeLock // パスコードロック画面の表示時

    // MARK: - Function

    func getTitle() -> String {
        switch self {
        case .inputForCreate, .retryForCreate:
            return "パスコード登録"
        case .inputForUpdate, .retryForUpdate:
            return "パスコード変更"
        case .displayPasscodeLock:
            return "パスコードロック"
        }
    }

    func getMessage() -> String {
        switch self {
        case .inputForCreate:
            return "登録したいパスコードを入力して下さい"
        case .inputForUpdate:
            return "変更したいパスコードを入力して下さい"
        case .retryForCreate, .retryForUpdate:
            return "確認用に再度パスコードを入力して下さい"
        case .displayPasscodeLock:
            return "設定したパスコードを入力して下さい"
        }
    }

    func getNextInputPasscodeType() -> InputPasscodeType? {
        switch self {
        case .inputForCreate:
            return .retryForCreate
        case .inputForUpdate:
            return .retryForUpdate
        default:
            return nil
        }
    }
}
