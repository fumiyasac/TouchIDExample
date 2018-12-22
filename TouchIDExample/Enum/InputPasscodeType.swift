//
//  InputPasscodeType.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/22.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation

enum InputPasscodeType {

    case inputForCreate // パスコードの新規作成
    case retryForCreate // パスコードの新規作成時の確認
    case inputForUpdate // パスコードの変更
    case retryForUpdate // パスコードの変更時の確認
    case displayPasscodeLock // パスコードロック画面の表示時

    // MARK: - Function

}
