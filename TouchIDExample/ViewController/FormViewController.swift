//
//  FormViewController.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/19.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUserInterface()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 謝罪アラートを表示する
        let alert = UIAlertController(
            title: "こちらの画面は仮画面です。",
            message: "この画面は特にロジックの実装は行っておりませんが、UserSettingViewControllerに記載している形と似たような感じで実装することができます。\n内容の関係で今回は割愛しましたm(_ _)m\n後ほど必ず作成する見込みでいます。。。",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(
            UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        )
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Private Function

    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupUserInterface() {
        setupNavigationItems()
        setupCloseButton()
    }
    
    private func setupNavigationItems() {
        setupNavigationBarTitle("情報入力ページ(仮)")
    }

    private func setupCloseButton() {
        let closeButton = UIBarButtonItem(title: "× 閉じる", style: .plain, target: self, action: #selector(self.closeButtonTapped(_:)))
        closeButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = closeButton
    }
}
