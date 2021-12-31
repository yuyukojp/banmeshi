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
    
    private var backButton: UIBarButtonItem!
    
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
        introductionTableView.register(UINib(nibName: "MenuDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuDetailTableViewCell")
        setNavigationItems()
    }
    
    private func setNavigationItems() {
        backButton = UIBarButtonItem(title: "＜ 返回", style: .done, target: self, action: #selector(backToMenu(_:)))
        navigationItem.setLeftBarButton(backButton, animated: true)

    }
    
    @objc func backToMenu (_ sender: UIBarButtonItem) {
        let targetVC = navigationController?.viewControllers[1] ?? UIViewController()
        navigationController?.popToViewController(targetVC, animated: true)
    }

}

extension MenuDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = introductionTableView.dequeueReusableCell(withIdentifier: "MenuDetailTableViewCell", for: indexPath) as! MenuDetailTableViewCell
        let menuData = realm.objects(Menu.self)[menuIndex]
//        print("++++ct:\(menuData[indexPath.row].name.count)")
//        cell.textLabel!.text =  menuData.ingredients[indexPath.row].0
//        cell.detailTextLabel!.text = String("\(menuData[indexPath.row].point) 分")
        return cell
    }
}

extension MenuDetailViewController: UITableViewDelegate {
    
}
