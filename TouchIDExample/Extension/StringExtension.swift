//
//  StringExtension.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/23.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation

extension String {

    // MARK: - Function

    func hmac(algorithm: CryptoAlgorithm) -> String {
        let key: String = AppConstant.PASSCODE_HASH
        var result: [CUnsignedChar]
        if let ckey = key.cString(using: String.Encoding.utf8), let cdata = self.cString(using: String.Encoding.utf8) {
            result = Array(repeating: 0, count: Int(algorithm.digestLength))
            CCHmac(algorithm.HMACAlgorithm, ckey, ckey.count - 1, cdata, cdata.count - 1, &result)
        } else {
            return ""
        }

        let hash = NSMutableString()
        for val in result {
            hash.appendFormat("%02hhx", val)
        }
        return hash as String
    }
}
