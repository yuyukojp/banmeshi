//
//  MenuDetailViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/30.
//

import UIKit
import RealmSwift


class MenuDetailViewController: BaseViewController {

    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var introductionTableView: UITableView!
    private var results: Results<Menu>!
    
    var menuIndex: Int = 0
    private var titlelabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        results = realm.objects(Menu.self).filter("id == \(menuIndex)")
        self.navigationItem.title = results[0].name
        introductionTableView.dataSource = self
        introductionTableView.delegate = self
    }

}

extension MenuDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "IntroductionCell", for: indexPath)
        let menuData = realm.objects(Menu.self)
        print("++++ct:\(menuData[indexPath.row].name.count)")
        cell.textLabel!.text = "\(menuData[indexPath.row].name)"
        cell.detailTextLabel!.text = String("\(menuData[indexPath.row].point) 分")
        return cell
    }
}

extension MenuDetailViewController: UITableViewDelegate {
    
}
