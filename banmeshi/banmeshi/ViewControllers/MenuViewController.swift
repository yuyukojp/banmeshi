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
import SwiftUI
 
class MenuViewController: BaseViewController {
    enum SortStatus: Int {
        case unsorted = 0
        case ascending = 1
        case descending = 2
        case select = 3
    }
  
    @IBOutlet weak var delimiterView1: UIView!
    @IBOutlet weak var delimiterView2: UIView!
    @IBOutlet weak var menuTextField: UITextField!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var editButton: UIButton!
    private var point: Int = -1
    @IBOutlet weak var selectPointTF: UITextField!
    @IBOutlet weak var sortButton: UIButton!
    private var selectPointBtn: CusstomButton!
    private var clearSelectBtn: CusstomButton!
    var disposeBag = DisposeBag()
    private var sortFlg: SortStatus!    
    private var tempPoints: [Int] = []
    private var tempIndex: [Int] = []
    private var tempSelectPoints: [Int] = []
    private var tempSelectIndex: [Int] = []
     
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
        menuTableView.reloadData()
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
        pointTextField.placeholder = "ー"
        setupViewsLayout()
        selectPointTF.backgroundColor = .itemBGColor()
        bindButtonToValue()
        sortFlg = .unsorted
        getData()

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
    
    private func getData() {
        tempPoints = []
        tempIndex = []
        let result = realm.objects(Menu.self)
        guard result.count != 0 else { return }
        
        for i in 0...(result.count - 1) {
            tempIndex.append(result[i].id)
            tempPoints.append(result[i].point)
        }
        
        if tempPoints.count > 1 {
            for i in 1...(tempPoints.count - 1) {
                for j in 1...(tempPoints.count - i) {
                    if tempPoints[j - 1] > tempPoints[j] {
                        tempPoints.swapAt(j - 1, j)
                        tempIndex.swapAt(j - 1, j)
                    }
                }
            }
        }
    }
    
    private func bindButtonToValue() {
        selectPointBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let findPoint = Int(self?.selectPointTF.text ?? "") else { return }
                self?.tempSelectIndex = []
                self?.tempSelectPoints = []
                if findPoint > 0 && findPoint < 11 {
                    for i in 0...((self?.tempPoints.count ?? 0) - 1) {
                        if self?.tempPoints[i] == findPoint {
                            self?.tempSelectIndex.append(self?.tempIndex[i] ?? 0)
                            self?.tempSelectPoints.append(self?.tempPoints[i] ?? 0)
                        }
                    }
                    self?.selectPointTF.resignFirstResponder()
                    self?.sortFlg = .select
                } else {
                    Alert.okAlert(title: AlertConst.errorTitle,
                                  message: AlertConst.pointOverRangeMsg,
                                  on: self!)
                }
                self?.menuTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        clearSelectBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.sortFlg = .unsorted
                self?.tempSelectIndex = []
                self?.tempSelectPoints = []
                self?.selectPointTF.text = ""
                self?.getData()
                self?.menuTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        
        sortButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                if self?.sortFlg == .unsorted {
                    self?.sortFlg = .ascending
                    self?.sortButton.setTitle(StringConst.unsortSymbol, for: .normal)
                } else if self?.sortFlg == .descending {
                    self?.sortFlg = .ascending
                    self?.sortButton.setTitle(StringConst.upSymbol, for: .normal)
                } else if self?.sortFlg == .ascending {
                    self?.sortFlg = .descending
                    self?.sortButton.setTitle(StringConst.downSymbol, for: .normal)
                } else { return }
                self?.menuTableView.reloadData()
            })
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
        getData()
        menuTableView.reloadData()
    }
    
    private func addMenu() {
        let menu = Menu()
        menu.name = menuTextField.text!
        if pointTextField.text == "" {
            menu.point = -1
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
   
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortFlg == .select {
            return tempSelectIndex.count
        } else {
            return tempIndex.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let menuData = realm.objects(Menu.self)
        var name = ""
        var point = 0
        if self.sortFlg == .unsorted {
            name = menuData[indexPath.row].name
            point = menuData[indexPath.row].point
        } else if self.sortFlg == .ascending {
            let tempDataIndex = tempPoints.count - indexPath.row - 1
            if tempDataIndex >= 0 {
                guard let resultsDetail = realm.objects(Menu.self).filter("id == \(tempIndex[tempDataIndex])").first else {
                    return cell
                }
                name = resultsDetail.name
                point = resultsDetail.point
            }
        } else if self.sortFlg == .descending {
            let tempDataIndex = indexPath.row
            if tempDataIndex >= 0 {
                guard let resultsDetail = realm.objects(Menu.self).filter("id == \(tempIndex[tempDataIndex])").first else {
                    return cell
                }
                name = resultsDetail.name
                point = resultsDetail.point
            }
        } else if self.sortFlg == .select {
            name = menuData[tempSelectIndex[indexPath.row]].name
            point = menuData[tempSelectIndex[indexPath.row]].point
        }
        
        cell.textLabel!.text = name
        cell.backgroundColor = .mainBackgroundColor()
        cell.textLabel?.textColor = .textColor()
        if point == -1 {
            cell.detailTextLabel!.text = "ー 分"
        } else {
            cell.detailTextLabel!.text = String("\(point) 分")
        }
        cell.detailTextLabel?.textColor = .textColor()

        return cell
    }
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
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

private extension MenuViewController {
    private func setupViewsLayout() {
        //selectPointBtn
        selectPointBtn = CusstomButton(frame: CGRect())
        view.addSubview(selectPointBtn)
        selectPointBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                selectPointBtn.leftAnchor.constraint(equalTo: selectPointTF.rightAnchor, constant: 30),
                selectPointBtn.heightAnchor.constraint(equalToConstant: 30),
                selectPointBtn.widthAnchor.constraint(equalToConstant: 80),
                selectPointBtn.centerYAnchor.constraint(equalTo: selectPointTF.centerYAnchor) //bottomAnchor.constraint(equalTo: menuTableView.topAnchor, constant: 40)
            ]
        )
        selectPointBtn.setTitle(StringConst.fundBtnTitle, for: .normal)
        
        //clearSelectBtn
        clearSelectBtn = CusstomButton(frame: CGRect())
        view.addSubview(clearSelectBtn)
        clearSelectBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                clearSelectBtn.leftAnchor.constraint(equalTo: selectPointBtn.rightAnchor, constant: 30),
                clearSelectBtn.heightAnchor.constraint(equalToConstant: 30),
                clearSelectBtn.widthAnchor.constraint(equalToConstant: 70),
                clearSelectBtn.centerYAnchor.constraint(equalTo: selectPointTF.centerYAnchor) //bottomAnchor.constraint(equalTo: menuTableView.topAnchor, constant: 40)
            ]
        )
        clearSelectBtn.setTitle(StringConst.clearBtnTitler, for: .normal)
    }
}
