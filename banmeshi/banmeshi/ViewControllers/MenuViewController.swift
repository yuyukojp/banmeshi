//
//  MenuViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
 
class MenuViewController: BaseViewController, UITableViewDataSource {

  
    @IBOutlet weak var delimiterView1: UIView!
    @IBOutlet weak var delimiterView2: UIView!
    @IBOutlet weak var menuTextField: UITextField!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var editButton: UIButton!
    private var point: Int = 6
    var disposeBag = DisposeBag()
     
    // 初期表示時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "菜单一览"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.delegate = self

        setupUI()
        registerBtn.isEnabled = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        // NavigationBarを表示したい場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        delimiterView1.backgroundColor = .delimiterColor()
        delimiterView2.backgroundColor = .delimiterColor()
        pointTextField.delegate = self
        menuTextField.delegate = self
        pointTextField.backgroundColor = .itemBGColor()
        menuTextField.backgroundColor = .itemBGColor()
        menuTableView.backgroundColor = .mainBackgroundColor()
        menuTextField.placeholder = "请输入菜名"
        pointTextField.placeholder = "\(point)"
        

        pointTextField.keyboardType = UIKeyboardType.numberPad
        
        //MARK: - TextFieldの最大文字数設定
        menuTextField.rx.text
            .map { text in
                if let text = text, text.count > 20 {
                    return String(text.prefix(20))
                } else {
                    return text ?? ""
                }
            }
            .bind(to: menuTextField.rx.text)
            .disposed(by: disposeBag)
        
        pointTextField.rx.text
            .map { text in
                if let text = text, text.count > 2 {
                    return String(text.prefix(2))
                } else {
                    return text ?? ""
                }
            }
            .bind(to: pointTextField.rx.text)
            .disposed(by: disposeBag)
        
        //MARK: - TextField入力制限に越した場合ボタン非活性化
        Observable.combineLatest(menuTextField.rx.text.orEmpty.asObservable(), pointTextField.rx.text.orEmpty.asObservable()){
            $0.count > 0 && $1.count >= 0
        }
        .bind(to: registerBtn.rx.isEnabled)
        .disposed(by: disposeBag)
    }

    @IBAction func tapRegisterBtn(_ sender: Any) {
        let tempText: String = pointTextField.text ?? ""
        let enterPoint = Int(tempText) ?? 0
        if enterPoint > 10 {
            Alert.okAlert(title: AlertConst.errorTitle,
                          message: AlertConst.pointOverRangeMsg,
                          on: self)
        } else {
            addMenu()
            menuTextField.text = ""
            pointTextField.text = ""
            menuTextField.endEditing(true)
            pointTextField.endEditing(true)
            menuTableView.reloadData()
        }
    }
    
    private func addMenu() {
        let menu = Menu()
        menu.name = menuTextField.text!
        if pointTextField.text == "" {
            menu.point = Int(pointTextField.placeholder ?? "0")!
        } else {
            menu.point = Int(pointTextField.text!)!
        }
        menu.id = self.newId(model: menu)!
        try! realm.write {
            realm.add(menu)
        }
        let menuDetail = MenuDetail()
        menuDetail.menuId = menu.id
        try! realm.write {
            realm.add(menuDetail)
        }
    }
    
    
    @IBAction func tapEditButton(_ sender: Any) {
        if(menuTableView.isEditing){
            menuTableView.setEditing(false, animated: true)
            editButton.setTitle("编辑", for: .normal)
        } else {
            menuTableView.setEditing(true, animated: true)
            editButton.setTitle("完了", for: .normal)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuData = realm.objects(Menu.self)
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let menuData = realm.objects(Menu.self)
        cell.textLabel!.text = menuData[indexPath.row].name
        cell.backgroundColor = .mainBackgroundColor()
        cell.textLabel?.textColor = .textColor()
        cell.detailTextLabel!.text = String("\(menuData[indexPath.row].point) 分")
        cell.detailTextLabel?.textColor = .textColor()
        return cell
    }
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //MARK: - Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var isSwipe: Bool = true
        if editingStyle == .delete {
            var tempPath = 0
            try! realm.write {
                let menuData = realm.objects(Menu.self)
                tempPath = menuData[indexPath.row].id
                self.realm.delete(menuData[indexPath.row])
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade)
            }
            try! realm.write {
                guard let results = realm.objects(MenuDetail.self).filter("menuId == \(tempPath)").first else { return }
                self.realm.delete(results)                
            }
            isSwipe = false
        }

        if editingStyle == UITableViewCell.EditingStyle.delete && isSwipe {
            // データベースから削除する
            try! realm.write {
                let menuData = realm.objects(Menu.self)
                self.realm.delete(menuData[indexPath.row])
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade)
            }
        }
    } 
}

extension MenuViewController: UITableViewDelegate {
    //MARK: - メニューをタップしたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuData = realm.objects(Menu.self)[indexPath.row]
        let menuDataId = menuData.id
        menuTextField.endEditing(true)
        pointTextField.endEditing(true)
        if menuData.isSetData {
            Router.shared.showMenuDetail(from: self, indexPath: menuDataId)
        } else {
            Router.shared.showAddMenuDetail(from: self, indexPath: menuDataId)
        }
    }
}

extension MenuViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == pointTextField && string.count > 0 {
            var allowedCharacters = CharacterSet(charactersIn: "1234567890") // 入力可能な文字
            allowedCharacters.insert(charactersIn: " -") // "white space & hyphen"
            
            // 入力可能な文字を全て取り去った文字列に文字があれば、テキスト変更できないFalseを返す。
            let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
            if unwantedStr.count == 0 {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
}

extension MenuViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
