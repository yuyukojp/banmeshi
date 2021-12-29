//
//  MenuDetailViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/29.
//

import UIKit
import RealmSwift

class MenuDetailViewController: UIViewController {
    var menuIndex: Int = 0
    private var titlelabel: UILabel = UILabel()
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        setupUI()
    }
    
    private func setupUI() {
        
        let result = realm.objects(Menu.self).filter("id == \(menuIndex)")
        print("+++++r:\(result)n:\(result[0].name)")
//        titlelabel.text = result[menuIndex].name
    }
    

}
