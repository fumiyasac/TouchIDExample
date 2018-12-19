//
//  GlobalTabBarController.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/16.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import UIKit
import FontAwesome_swift

class GlobalTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.viewControllers = [UIViewController(), UIViewController()]

        setupUserInterface()
    }

    // MARK: - Private Function

    private func setupUserInterface() {
        setupGlobalTabBar()
    }

    private func setupGlobalTabBar() {

        // タブの選択時、非選択時の色を決める
        let itemSize = CGSize(width: 28.0, height: 28.0)
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

            // 該当ViewControllerのタイトル設置
            self.viewControllers?[index].title = tabBarItem.getTabTitle()

            // 該当ViewControllerのタブバー要素設置
            self.viewControllers?[index].tabBarItem.setTitleTextAttributes(deselectedAttributes, for: [])
            self.viewControllers?[index].tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
            self.viewControllers?[index].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -2.0)
            self.viewControllers?[index].tabBarItem.image = UIImage.fontAwesomeIcon(name: tabBarItem.getTabFontAwesomeIcon(), style: .solid, textColor: deselectedColor, size: itemSize).withRenderingMode(.alwaysOriginal)
            self.viewControllers?[index].tabBarItem.selectedImage = UIImage.fontAwesomeIcon(name: tabBarItem.getTabFontAwesomeIcon(), style: .solid, textColor: selectedColor, size: itemSize).withRenderingMode(.alwaysOriginal)
        }
    }
}
