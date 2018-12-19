//
//  InputPasscodeKeyboardView.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/17.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation
import UIKit

class InputPasscodeKeyboardView: CustomViewBase {

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupInputPasscodeKeyboardView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupInputPasscodeKeyboardView()
    }

    // MARK: - Private Function

    private func setupInputPasscodeKeyboardView() {

    }
}
