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

    private var addBackgroundView: UIView = UIView()
    private var addView: UIView = UIView()
    private var addViewCloseBtn: UIButton = UIButton()
    private var confirmButton: UIButton = UIButton()
    private var tempIndexPath: IndexPath!
    let itemNameLabel = UILabel()
    let itemNameTextfield = UITextField()
    let itemQuantityLabel = UILabel()
    let itemQuantityTextField = UITextField()
    
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
        print("++++menuid:\(menuIndex)")
    }
    
    private func setupUI() {
        setNavigationBar()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "AddMenuDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        setAddView()
    }
    
    private func setAddView() {
        let marginY: CGFloat = 30
        let itemMarginY: CGFloat = 8
        let marginX: CGFloat = 20
        //MARK: - バックグラウンドview
        addBackgroundView.frame = CGRect(x: 0, y:-Const.screenHeight, width: Const.screenWidth, height: Const.screenHeight)
        addBackgroundView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 0.5)
        self.view.addSubview(addBackgroundView)
        
        //追加View
        addView.frame = CGRect(x: 20,
                               y: Const.screenHeight * 1 / 5,
                               width: Const.screenWidth - 40,
                               height: 260)
        addView.backgroundColor = UIColor.white
        addBackgroundView.addSubview(addView)
        
        //閉じるボタン
        addViewCloseBtn.frame = CGRect(x: 20 + self.addView.frame.width - 40,
                                       y: Const.screenHeight * 1 / 5 + 10,
                                       width: 40,
                                       height: 20)
        addViewCloseBtn.setTitle("X", for: .normal)
        addViewCloseBtn.setTitleColor(.black, for: .normal)
        addViewCloseBtn.addTarget(self, action: #selector(tapXBtn), for: .touchUpInside)
        addBackgroundView.addSubview(addViewCloseBtn)
        //素材名
        
        itemNameLabel.frame = CGRect(x: marginX, y: marginY, width: 60, height: 25)
        itemNameLabel.text = "配料名"
        addView.addSubview(itemNameLabel)
        
        
        itemNameTextfield.frame = CGRect(x: marginX,
                                         y: marginY + itemNameLabel.frame.height + itemMarginY,
                                         width: addView.frame.width - (marginX * 2),
                                         height: 30)
        itemNameTextfield.layer.borderColor = UIColor.lightGray.cgColor
        itemNameTextfield.layer.borderWidth = 1.0
        addView.addSubview(itemNameTextfield)
        
        
        itemQuantityLabel.frame = CGRect(x: marginX,
                                         y: itemNameTextfield.frame.origin.y + itemNameTextfield.frame.height + (itemMarginY * 2),
                                         width: addView.frame.width - (marginX * 2),
                                         height: 25)
        itemQuantityLabel.text = "加入量"
        addView.addSubview(itemQuantityLabel)
        
        
        itemQuantityTextField.frame = CGRect(x: marginX,
                                             y: itemQuantityLabel.frame.origin.y + itemQuantityLabel.frame.height + itemMarginY,
                                             width: addView.frame.width - (marginX * 2),
                                             height: 30)
        itemQuantityTextField.layer.borderColor = UIColor.lightGray.cgColor
        itemQuantityTextField.layer.borderWidth = 1.0
        addView.addSubview(itemQuantityTextField)
        
        confirmButton.frame = CGRect(x: (addView.frame.width - 100) / 2,
                                     y: itemQuantityTextField.frame.origin.y + itemQuantityTextField.frame.height + (itemMarginY * 2),
                                     width: 100,
                                     height: 40)
        confirmButton.setTitle("确认", for: .normal)
        confirmButton.backgroundColor = UIColor(red: 251/255, green: 102/255, blue: 72/255, alpha: 0.5)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.layer.cornerRadius = 10
        confirmButton.addTarget(self, action: #selector(tapConfirmBtn), for: .touchUpInside)
        addView.addSubview(confirmButton)
    }
    
    @objc func tapConfirmBtn() {
        guard let results = realm.objects(MenuDetail.self).filter("menuId == \(menuIndex)").first else { return }
        
        switch tempIndexPath.row {
        case 0:
            do{
                try realm.write{
                    results.ingredientName0 = itemNameTextfield.text!
                    results.amount0 = itemQuantityTextField.text!
                }
            }catch {
                print("Error \(error)")
            }
        case 1:
            do{
                try realm.write{
                    results.ingredientName1 = itemNameTextfield.text!
                    results.amount1 = itemQuantityTextField.text!
                }
            }catch {
                print("Error \(error)")
            }
        case 2:
            do{
                try realm.write{
                    results.ingredientName2 = itemNameTextfield.text!
                    results.amount2 = itemQuantityTextField.text!
                }
            }catch {
                print("Error \(error)")
            }
        case 3:
            do{
                try realm.write{
                    results.ingredientName3 = itemNameTextfield.text!
                    results.amount3 = itemQuantityTextField.text!
                }
            }catch {
                print("Error \(error)")
            }
        case 4:
            do{
                try realm.write{
                    results.ingredientName4 = itemNameTextfield.text!
                    results.amount4 = itemQuantityTextField.text!
                }
            }catch {
                print("Error \(error)")
            }
        case 5:
            do{
                try realm.write{
                    results.ingredientName5 = itemNameTextfield.text!
                    results.amount5 = itemQuantityTextField.text!
                }
            }catch {
                print("Error \(error)")
            }
        default:
            break
        }
        mainTableView.reloadData()
        do{
            try realm.write{
                results.menuCount = results.menuCount + 1
            }
        }catch {
            print("Error \(error)")
        }
        print("+++++data:\(results.ingredientName0),\(results.amount0),ct:\(results.menuCount)")
        mainTableView.reloadData()
        closeSetView()
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
    @objc func tapXBtn() {
        closeSetView()
    }
    
    private func closeSetView() {
        UIView.animate(withDuration: 0.3) {
            self.addBackgroundView.frame.origin.y = -Const.screenHeight
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
}

extension AddMenuDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuResult = realm.objects(Menu.self)[menuIndex]
        self.tempIndexPath = indexPath
        if indexPath.section == 1 {
            UIView.animate(withDuration: 0.3) {
                self.addBackgroundView.frame.origin.y = 0
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
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
        print("+++++tb:\(results.menuCount)")
        if section < 2 {
            return 1
        } else {
            return results.menuCount == 0 ? 1 : results.menuCount + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddMenuDetailTableViewCell

        let menuResult = realm.objects(Menu.self)[menuIndex]
        guard let detailResult = realm.objects(MenuDetail.self).filter("menuId == \(menuIndex)").first else { return cell}
        
        if indexPath.section == 0 && menuResult.urlString != "" {
            cell.photoView.isHidden = false
            cell.addLabel.isHidden = true
        } else if indexPath.section == 1 && menuResult.introduction != "" {
            cell.introductionLabel.isHidden = false
            cell.addLabel.isHidden = true
        } else if  indexPath.section == 2 && indexPath.row >= detailResult.menuCount {
            cell.nameLabel.isHidden = false
            cell.amfeLabel.isHidden = false
            cell.addLabel.isHidden = true
            cell.nameLabel.text = detailResult.ingredientName0
            cell.amfeLabel.text = detailResult.amount0
            print("+++text\(detailResult.ingredientName0),\(detailResult.amount0)")
        }
        
        return cell
    }
    
    
}
