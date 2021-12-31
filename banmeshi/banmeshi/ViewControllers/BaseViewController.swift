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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        backBotton.title = "返回"
        navigationItem.backBarButtonItem = backBotton
    }
    
    func setStoryboard(sbName : String) -> UIStoryboard {
        return UIStoryboard(name: sbName, bundle: Bundle.main)
    }
    

}
