//
//  BaseViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/30.
//

import UIKit
import RealmSwift

class BaseViewController: UIViewController {
    let realm = try! Realm()
    let backBotton = UIBarButtonItem()
    let delimiterVeiw: UIView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackgroundColor()
        backBotton.title = "返回"
        self.navigationItem.titleView?.backgroundColor = .delimiterColor()
        navigationItem.backBarButtonItem = backBotton
    }
    
    func setStoryboard(sbName : String) -> UIStoryboard {
        return UIStoryboard(name: sbName, bundle: Bundle.main)
    }
    
    func setupDelimiter(x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = Const.screenWidth, height: CGFloat = Const.screenHeight ) {
        delimiterVeiw.frame = CGRect(x: x, y: y, width: width, height: height)
        delimiterVeiw.backgroundColor = .delimiterColor()
    }
    
    

}

extension BaseViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
