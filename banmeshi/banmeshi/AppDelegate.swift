//
//  AppDelegate.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        Router.shared.showRoot(window: window)
        IQKeyboardManager.shared.enable = true
        // 全部のビューが同時にクリックすることを防止
        // 連打防止
        UIView.appearance().isExclusiveTouch = true
        return true
    }
}


