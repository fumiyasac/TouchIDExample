//
//  AppConstant.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/19.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation
import UIKit

struct AppConstant {
    static let FONT_NAME: String = "HiraMaruProN-W4"
    static let PASSCODE_LENGTH: Int = 4

    // MARK: - Computed Property

    static var PASSCODE_HASH: String {
        return get("PasscodeSalt") as! String
    }

    // MARK: - Static Function

    static func get(_ key: String) -> AnyObject? {
        return Bundle.main.object(forInfoDictionaryKey: key) as AnyObject
    }
}
