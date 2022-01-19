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
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    private var isMovetoNextView: Bool = false
    
    private var backButton: UIBarButtonItem!
    
    var menuIndex: Int = 0
    private var titlelabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        self.navigationController?.navigationBar.delegate = self
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        if !isMovetoNextView {
            let targetVC = navigationController?.viewControllers[0] ?? UIViewController()
            navigationController?.popToViewController(targetVC, animated: true)
        }
    }

    private func setupUI() {
        self.tabBarController?.tabBar.isHidden = false
        guard let resultsMenu = realm.objects(Menu.self).filter("id == \(menuIndex)").first else { return }
        self.navigationItem.title = resultsMenu.name
        if resultsMenu.imageData != Data() {
            menuImage.image = UIImage(data: resultsMenu.imageData)
        }
        introductionTableView.dataSource = self
        introductionTableView.register(UINib(nibName: "MenuDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuDetailTableViewCell")
        introductionLabel.text = resultsMenu.introduction
        setNavigationItems()
        var pointString: String = String(resultsMenu.point)
        if resultsMenu.point == -1 {
            pointString = "-"
        }
        pointLabel.text = "本菜得分：\(pointString)分"
    }
    
    @IBAction func tapEditBtn(_ sender: Any) {
        isMovetoNextView = true
        Router.shared.showAddMenuDetailEdit(from: self, indexPath: self.menuIndex)
    }
    
    private func setNavigationItems() {
        backButton = UIBarButtonItem(title: "＜ 返回", style: .done, target: self, action: #selector(backToMenu(_:)))
        navigationItem.setLeftBarButton(backButton, animated: true)

    }
    
    @objc func backToMenu (_ sender: UIBarButtonItem) {
        let targetVC = navigationController?.viewControllers[0] ?? UIViewController()
        navigationController?.popToViewController(targetVC, animated: true)
    }

}

extension MenuDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = realm.objects(MenuDetail.self)[menuIndex]
        return result.menuCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = introductionTableView.dequeueReusableCell(withIdentifier: "MenuDetailTableViewCell", for: indexPath) as! MenuDetailTableViewCell
        let result = realm.objects(MenuDetail.self)[menuIndex]
        switch indexPath.row {
        case 0:
            cell.textLabel!.text =  result.ingredientName0
            cell.detailTextLabel!.text = result.amount0
        case 1:
            cell.textLabel!.text =  result.ingredientName1
            cell.detailTextLabel!.text = result.amount1
        case 2:
            cell.textLabel!.text =  result.ingredientName2
            cell.detailTextLabel!.text = result.amount2
        case 3:
            cell.textLabel!.text =  result.ingredientName3
            cell.detailTextLabel!.text = result.amount3
        case 4:
            cell.textLabel!.text =  result.ingredientName4
            cell.detailTextLabel!.text = result.amount4
        case 5:
            cell.textLabel!.text =  result.ingredientName5
            cell.detailTextLabel!.text = result.amount5
        case 6:
            cell.textLabel!.text =  result.ingredientName6
            cell.detailTextLabel!.text = result.amount6
        case 7:
            cell.textLabel!.text =  result.ingredientName7
            cell.detailTextLabel!.text = result.amount7
        case 8:
            cell.textLabel!.text =  result.ingredientName8
            cell.detailTextLabel!.text = result.amount8
        case 9:
            cell.textLabel!.text =  result.ingredientName9
            cell.detailTextLabel!.text = result.amount9
        case 10:
            cell.textLabel!.text =  result.ingredientName10
            cell.detailTextLabel!.text = result.amount10
        case 11:
            cell.textLabel!.text =  result.ingredientName11
            cell.detailTextLabel!.text = result.amount11
        case 12:
            cell.textLabel!.text =  result.ingredientName12
            cell.detailTextLabel!.text = result.amount12
        case 13:
            cell.textLabel!.text =  result.ingredientName13
            cell.detailTextLabel!.text = result.amount13
        case 14:
            cell.textLabel!.text =  result.ingredientName14
            cell.detailTextLabel!.text = result.amount14
        case 15:
            cell.textLabel!.text =  result.ingredientName15
            cell.detailTextLabel!.text = result.amount15
        case 16:
            cell.textLabel!.text =  result.ingredientName16
            cell.detailTextLabel!.text = result.amount16
        case 17:
            cell.textLabel!.text =  result.ingredientName17
            cell.detailTextLabel!.text = result.amount17
        case 18:
            cell.textLabel!.text =  result.ingredientName18
            cell.detailTextLabel!.text = result.amount18
        case 19:
            cell.textLabel!.text =  result.ingredientName19
            cell.detailTextLabel!.text = result.amount19
        case 20:
            cell.textLabel!.text =  result.ingredientName20
            cell.detailTextLabel!.text = result.amount20
        case 21:
            cell.textLabel!.text =  result.ingredientName21
            cell.detailTextLabel!.text = result.amount21
        case 22:
            cell.textLabel!.text =  result.ingredientName22
            cell.detailTextLabel!.text = result.amount22
        case 23:
            cell.textLabel!.text =  result.ingredientName23
            cell.detailTextLabel!.text = result.amount23
        case 24:
            cell.textLabel!.text =  result.ingredientName24
            cell.detailTextLabel!.text = result.amount24
        case 25:
            cell.textLabel!.text =  result.ingredientName25
            cell.detailTextLabel!.text = result.amount25
        case 26:
            cell.textLabel!.text =  result.ingredientName26
            cell.detailTextLabel!.text = result.amount26
        case 27:
            cell.textLabel!.text =  result.ingredientName27
            cell.detailTextLabel!.text = result.amount27
        case 28:
            cell.textLabel!.text =  result.ingredientName28
            cell.detailTextLabel!.text = result.amount28
        case 29:
            cell.textLabel!.text =  result.ingredientName29
            cell.detailTextLabel!.text = result.amount29
        case 30:
            cell.textLabel!.text =  result.ingredientName30
            cell.detailTextLabel!.text = result.amount30
        default:
            break
        }
        cell.textLabel?.textColor = .textColor()
        cell.detailTextLabel?.textColor = .textColor()
        return cell
    }
    
}

extension MenuDetailViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
