//
//  DeviceOwnerLocalAuthenticatior.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/08/29.
//  Copyright © 2018年 酒井文也. All rights reserved.
//

import Foundation
import LocalAuthentication

class LocalAuthenticationManager {

    // MARK: - Static Function

    static func getDeviceOwnerLocalAuthenticationType() -> DeviceOwnerLocalAuthenticationType {
        let localAuthenticationContext = LAContext()

        // iOS11以上の場合: FaceID/TouchID/パスコードの3種類
        if #available(iOS 11.0, *) {

            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                switch localAuthenticationContext.biometryType {
                case .faceID:
                    return .authWithFaceID
                case .touchID:
                    return .authWithTouchID
                default:
                    return .authWithManual
                }
            }

        // iOS10以下の場合: TouchID/パスコードの2種類
        } else {

            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                return .authWithTouchID
            } else {
                return .authWithManual
            }

        }
        return .authWithManual
    }

    static func evaluateDeviceOwnerLocalAuthentication(successHandler: (() -> ())? = nil, errorHandler: (() -> ())? = nil) {
        let type = self.getDeviceOwnerLocalAuthenticationType()

        // パスコードでの解除の場合は以降の処理は行わない
        if type == .authWithManual {
            return
        }

        // FaceID/TouchIDでの認証結果に応じて引数のクロージャーに設定した処理を実行する
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: type.getLocalizedReason(), reply: { success, evaluateError in
            if success {
                // 認証成功時の処理を書く
                successHandler?()
                print("認証成功:", type.getDescriptionTitle())
            } else {
                // 認証失敗時の処理を書く
                errorHandler?()
                print("認証失敗:", evaluateError.debugDescription)
            }
        })
    }
}

