//
//  TabBarItemType.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/12/19.
//  Copyright © 2018 酒井文也. All rights reserved.
//

import Foundation
import FontAwesome_swift

enum TabBarItemType: CaseIterable {
    case home
    case setting

    // 該当のviewControllerを取得する
    func getViewController() -> UIViewController? {
        switch self {
        case .home:
            return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        case .setting:
            return UIStoryboard(name: "Setting", bundle: nil).instantiateInitialViewController()
        }
    }

    // tabBarのインデックス番号を取得する
    func getTabIndex() -> Int {
        switch self {
        case .home:
            return 0
        case .setting:
            return 1
        }
    }

    // tabBarのタイトルを取得する
    func getTabTitle() -> String {
        switch self {
        case .home:
            return "一覧画面"
        case .setting:
            return "設定画面"
        }
    }

    // tabBarのFontAwesomeアイコン名を取得する
    func getTabFontAwesomeIcon() -> FontAwesome {
        switch self {
        case .home:
            return .home
        case .setting:
            return .bars
        }
    }
}
