//
//  PasscodePresenter.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/22.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation

protocol PasscodePresenterProtocol: class {
    
}

class PasscodePresenter: PasscodePresenterProtocol {

    var presenter: PasscodePresenterProtocol!

    // MARK: - Initializer

    init(presenter: PasscodePresenterProtocol) {
        self.presenter = presenter
    }
}

