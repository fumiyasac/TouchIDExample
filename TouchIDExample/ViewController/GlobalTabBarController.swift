//
//  GlobalTabBarController.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/16.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import UIKit

class GlobalTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.viewControllers = [UIViewController(), UIViewController()]

        setupUserInterface()

        // アプリ起動完了時のパスコード画面表示の通知監視
        NotificationCenter.default.addObserver(self, selector: #selector(self.displayPasscodeLockScreenIfNeeded), name: UIApplication.didFinishLaunchingNotification, object: nil)
    }

    // MARK: - Private Function

    @objc private func displayPasscodeLockScreenIfNeeded() {
        let passcodeModel = PasscodeModel()

        // パスコードロックを設定していない場合は何もしない
        if !passcodeModel.existsHashedPasscode() {
            return
        }

        let nav = UINavigationController(rootViewController: getPasscodeViewController())
        nav.modalPresentationStyle = .overFullScreen
        nav.modalTransitionStyle   = .crossDissolve
        self.present(nav, animated: false, completion: nil)
    }

    private func setupUserInterface() {
        setupGlobalTabBar()
    }

    private func setupGlobalTabBar() {

        // タブの選択時、非選択時の色を決める
        let deselectedColor: UIColor = .lightGray
        let selectedColor: UIColor = .black
        let tabBarItemFont = UIFont(name: AppConstant.FONT_NAME, size: 10)!

        let deselectedAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: tabBarItemFont,
            NSAttributedString.Key.foregroundColor: deselectedColor
        ]
        let selectedAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: tabBarItemFont,
            NSAttributedString.Key.foregroundColor: selectedColor
        ]

        // TabBarに表示する画面を決める
        let _ = TabBarItemType.allCases.enumerated().map { (index, tabBarItem) in

            // 該当ViewControllerの設置
            guard let vc = tabBarItem.getViewController() else {
                fatalError("Invalid Target ViewController.")
            }
            self.viewControllers?[index] = vc

            // 該当ViewControllerのタイトルの設定
            self.viewControllers?[index].title = tabBarItem.getTabTitle()
            // 該当ViewControllerのUITabBar要素の設定
            self.viewControllers?[index].tabBarItem.tag = index
            self.viewControllers?[index].tabBarItem.setTitleTextAttributes(deselectedAttributes, for: [])
            self.viewControllers?[index].tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
            self.viewControllers?[index].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 0.0)
            self.viewControllers?[index].tabBarItem.image
                = UIImage(
                    systemName: tabBarItem.getTabBarSymbolName(),
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .black)
                    )!.withTintColor(deselectedColor, renderingMode: .alwaysOriginal)
            self.viewControllers?[index].tabBarItem.selectedImage
                = UIImage(
                    systemName: tabBarItem.getTabBarSymbolName(),
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .black)
                    )!.withTintColor(selectedColor, renderingMode: .alwaysOriginal)
        }
    }

    private func getPasscodeViewController() -> PasscodeViewController {
        // 遷移先のViewControllerに関する設定をする
        let sb = UIStoryboard(name: "Passcode", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! PasscodeViewController
        vc.setTargetInputPasscodeType(.displayPasscodeLock)
        vc.setTargetPresenter(PasscodePresenter(previousPasscode: nil))
        return vc
    }
}
