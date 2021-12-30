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


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setStoryboard(sbName : String) -> UIStoryboard {
        return UIStoryboard(name: sbName, bundle: Bundle.main)
    }
    

}
