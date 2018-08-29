//
//  DeviceOwnerLocalAuthenticationType.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/08/29.
//  Copyright © 2018年 酒井文也. All rights reserved.
//

import Foundation

enum DeviceOwnerLocalAuthenticationType {
    case authWithFaceID  // FaceIDでのパスコード解除
    case authWithTouchID // TouchIDでのパスコード解除
    case authWithManual  // 手動入力でのパスコード解除

    // MARK: - Function

    func getDescriptionTitle() -> String {
        switch self {
        case .authWithFaceID:
            return "FaceID"
        case .authWithTouchID:
            return "TouchID"
        default:
            return ""
        }
    }

    func getLocalizedReason() -> String {
        switch self {
        case .authWithFaceID, .authWithTouchID:
            return "\(self.getDescriptionTitle())を利用して画面ロックを解除します。"
        default:
            return ""
        }
    }
}
