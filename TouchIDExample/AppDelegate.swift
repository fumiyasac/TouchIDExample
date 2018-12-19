//
//  AppDelegate.swift
//  TouchIDExample
//
//  Created by 酒井文也 on 2018/08/29.
//  Copyright © 2018年 酒井文也. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Debug.
        print("didFinishLaunchingWithOptions: アプリ起動時")

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

        // Debug.
        print("applicationWillResignActive: フォアグラウンドからバックグラウンドへ移行しようとした時")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

        // Debug.
        print("applicationDidEnterBackground: バックグラウンドへ移行完了した時")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

        // Debug.
        print("applicationWillEnterForeground: バックグラウンドからフォアグラウンドへ移行しようとした時")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        // Debug.
        print("applicationDidBecomeActive: アプリの状態がアクティブになった時")
    }

    func applicationWillTerminate(_ application: UIApplication) {

        // Debug.
        print("applicationWillTerminate: アプリ終了時")
    }
}

