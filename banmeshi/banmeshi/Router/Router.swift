//
//  Router.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit

final class Router {
    static let shared = Router()
    private init() {}
    
    var window: UIWindow?
    
    func showRoot(window: UIWindow) {
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func showRoulette(from: UIViewController) {
        let rouletteVC = RouletteViewController()
//        rouletteVC.data = data
        from.show(to: rouletteVC)
    }
    
    func showMenu(from: UIViewController) {
        let menuVC = MenuViewController()
        from.show(to: menuVC)
    }
    
    func showMenuDetail(from: UIViewController, indexPath: Int) {
        let MenuDetailVC = MenuDetailViewController()
        MenuDetailVC.menuIndex = indexPath
        from.show(to: MenuDetailVC)
    }
    
}
