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
 
class MenuViewController: UIViewController, UITableViewDataSource {

  
    @IBOutlet weak var menuTextField: UITextField!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    private var point: Int = 6
    var disposeBag = DisposeBag()
    let realm = try! Realm()
     
    // 初期表示時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        view.backgroundColor = .white
        registerBtn.isEnabled = false
    }
    
    private func setTextField() {
        pointTextField.delegate = self
        menuTextField.delegate = self
        menuTextField.placeholder = "メニューを入力してください。"
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
            $0.count > 0 && $1.count > 0
        }
        .bind(to: registerBtn.rx.isEnabled)
        .disposed(by: disposeBag)
        
    }

    @IBAction func tapRegisterBtn(_ sender: Any) {
        let menu = Menu()
        menu.name = menuTextField.text!
        menu.point = Int(pointTextField.text!)!
        try! realm.write {
            realm.add(menu)
        }
        menuTextField.text = ""
        pointTextField.text = ""
        menuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuData = realm.objects(Menu.self)
        return menuData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let menuData = realm.objects(Menu.self)
        cell.textLabel!.text = "\(menuData[indexPath.row].name)"
        cell.detailTextLabel!.text = String("\(menuData[indexPath.row].point) 分")
        return cell
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
