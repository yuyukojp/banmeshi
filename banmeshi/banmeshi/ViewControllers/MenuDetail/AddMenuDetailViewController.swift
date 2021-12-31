//
//  AddMenuDetailViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/30.
//

import UIKit
import RealmSwift

class AddMenuDetailViewController: BaseViewController {
    @IBOutlet weak var mainTableView: UITableView!

    private var saveButton: UIBarButtonItem!
    var menuIndex: Int = 0
    // Sectionのタイトル
     let sectionTitle: NSArray = [
          "照片",
          "简介",
          "详细"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setNavigationBar()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "AddMenuDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCell")
    }
    
    private func setNavigationBar() {
        saveButton = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(saveButtonTapped(_:)))
        navigationItem.setRightBarButton(saveButton, animated: false)
        navigationItem.rightBarButtonItem?.title = "保存"
    }
    
    //MARK: - MenuViewに戻る
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        //部品のアラートを作る
        let alertController = UIAlertController(title: AlertConst.saveAlertTitle, message: AlertConst.saveAlertMsg, preferredStyle: UIAlertController.Style.alert)
        //OKボタン追加
        let okAction = UIAlertAction(title: AlertConst.save, style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
            self.saveAction()
            Router.shared.showMenuDetail(from: self, indexPath: self.menuIndex)
        })
        let cancelAction = UIAlertAction(title: AlertConst.noSave, style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)        

        //アラートを表示する
         present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func saveAction() {
        let results = realm.objects(Menu.self).filter("id == \(menuIndex)").first

        try! realm.write {
            results?.setValue(true, forKey: "isSetData")
        }
    }

}

extension AddMenuDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("++++0")
        case 1:
            print("++++1")
        case 2:
            print("++++2")
        default:
            break
        }
    }
}

extension AddMenuDetailViewController: UITableViewDataSource {
    //セッションを設置
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    // Sectioのタイトル
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let results = realm.objects(MenuDetail.self).filter("menuId == \(menuIndex)").first else {
            return 1
        }
        if section <= 2 {
            return 1
        } else {
            return results.menuCount == 0 ? 1 : results.menuCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddMenuDetailTableViewCell

        let menuResult = realm.objects(Menu.self)[menuIndex]
        guard let detailCount = realm.objects(MenuDetail.self).filter("menuId == \(menuIndex)").first?.menuCount else { return cell}
        
        if indexPath.section == 0 && menuResult.urlString != "" {
            cell.photoView.isHidden = false
            cell.addLabel.isHidden = true
        } else if indexPath.section == 1 && menuResult.introduction != "" {
            cell.introductionLabel.isHidden = false
            cell.addLabel.isHidden = true
        } else if  indexPath.section == 2 && indexPath.row <= detailCount {
            cell.nameLabel.isHidden = false
            cell.amfeLabel.isHidden = false
            cell.addLabel.isHidden = true
        }
        
        return cell
    }
    
    
}
