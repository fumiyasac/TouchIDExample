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
    
    private static let localAuthenticationContext = LAContext()

    // MARK: - Static Function

    static func getDeviceOwnerLocalAuthenticationType() -> DeviceOwnerLocalAuthenticationType {
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {

            // iOS11以上の場合: FaceID/TouchID/パスコードの3種類
            if #available(iOS 11.0, *) {
                switch localAuthenticationContext.biometryType {
                case .faceID:
                    return .authWithManual
                case .touchID:
                    return .authWithTouchID
                default:
                    return .authWithManual
                }
            // iOS10の場合: FaceID/TouchID/パスコードの3種類
            } else {
                return .authWithTouchID
            }

        } else {
            return .authWithManual
        }
    }

    static func evaluateDeviceOwnerLocalAuthentication(successHandler: (() -> ())? = nil, errorHandler: (() -> ())? = nil) {
        let type = self.getDeviceOwnerLocalAuthenticationType()

        // パスコードでの解除の場合は以降の処理は行わない
        if type == .authWithManual {
            return
        }

        // FaceID/TouchIDでの認証結果に応じて引数のクロージャーに設定した処理を実行する
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: type.getLocalizedReason(), reply: { success, evaluateError in
            if success {
                // 認証成功時の処理を書く
                print("認証成功:", type.getDescriptionTitle())
            } else {
                // 認証失敗時の処理を書く
                print("認証失敗:", evaluateError.debugDescription)
            }
        })
    }
}

