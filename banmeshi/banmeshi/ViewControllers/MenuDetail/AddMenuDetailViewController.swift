//
//  AddMenuDetailViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/30.
//

import UIKit
import RealmSwift

class AddMenuDetailViewController: BaseViewController {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    private var saveButton: UIBarButtonItem!
    var menuIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
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
        
    }

}
