//
//  SettingViewController.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/16.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak private var passcodeSwitch: UISwitch!
    @IBOutlet weak private var openSettingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUserInterface()
    }

    // MARK: - Private Function

    @objc private func openSettingButtonAction() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    private func setupUserInterface() {
        setupNavigationItems()
        setupOpenSettingButton()
    }

    private func setupNavigationItems() {
        setupNavigationBarTitle("サンプルでの設定")
    }

    private func setupOpenSettingButton() {
        openSettingButton.addTarget(self, action: #selector(self.openSettingButtonAction), for: .touchUpInside)
    }
}
