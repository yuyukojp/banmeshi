//
//  AddMenuDetailViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/30.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import SwiftUI

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
    private var addIntroductionView: AddIntroductionView!
    private var addDetailView: AddDetailView!
    private var backBottons: UIBarButtonItem!
    private var saveButton: UIBarButtonItem!
    
    var disposeBag = DisposeBag()

    var menuIndex: Int = 0
    // Sectionのタイトル
    let sectionTitle: NSArray = ["照片", "简介", "详细"]
    var imageData: Data = Data()
    private var introductionData: String = ""
    private var detailData: [String] = []
    private var ingredientData: [String] = []
    var isEditMode: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        self.navigationController?.navigationBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isEditMode {
            setDataFromDB()
        }
        mainTableView.reloadData()
        setAddView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isEditMode = false

    }
    
    private func setupUI() {
        mainTableView.backgroundColor = .mainBackgroundColor()
        setNavigationBar()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "AddMenuDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        itemNameLabel.textColor = .textColor()
        itemQuantityLabel.textColor = .textColor()
        
    }
    
    private func setDataFromDB() {
        guard let resultsDetail = realm.objects(MenuDetail.self).filter("menuId == \(menuIndex)").first else { return }
        guard let resultsMenu = realm.objects(Menu.self).filter("id == \(menuIndex)").first else { return }
        imageData = resultsMenu.imageData
        introductionData = resultsMenu.introduction
        guard (resultsDetail.menuCount == 0) != true else { return }
        for i in 0...(resultsDetail.menuCount - 1) {
            switch i {
            case 0:
                detailData.append(resultsDetail.ingredientName0)
                ingredientData.append(resultsDetail.amount0)
            case 1:
                detailData.append(resultsDetail.ingredientName1)
                ingredientData.append(resultsDetail.amount1)
            case 2:
                detailData.append(resultsDetail.ingredientName2)
                ingredientData.append(resultsDetail.amount2)
            case 3:
                detailData.append(resultsDetail.ingredientName3)
                ingredientData.append(resultsDetail.amount3)
            case 4:
                detailData.append(resultsDetail.ingredientName4)
                ingredientData.append(resultsDetail.amount4)
            case 5:
                detailData.append(resultsDetail.ingredientName5)
                ingredientData.append(resultsDetail.amount5)
            case 6:
                detailData.append(resultsDetail.ingredientName6)
                ingredientData.append(resultsDetail.amount6)
            case 7:
                detailData.append(resultsDetail.ingredientName7)
                ingredientData.append(resultsDetail.amount7)
            case 8:
                detailData.append(resultsDetail.ingredientName8)
                ingredientData.append(resultsDetail.amount8)
            case 9:
                detailData.append(resultsDetail.ingredientName9)
                ingredientData.append(resultsDetail.amount9)
            case 10:
                detailData.append(resultsDetail.ingredientName10)
                ingredientData.append(resultsDetail.amount10)
            case 11:
                detailData.append(resultsDetail.ingredientName11)
                ingredientData.append(resultsDetail.amount11)
            case 12:
                detailData.append(resultsDetail.ingredientName12)
                ingredientData.append(resultsDetail.amount12)
            case 13:
                detailData.append(resultsDetail.ingredientName13)
                ingredientData.append(resultsDetail.amount13)
            case 14:
                detailData.append(resultsDetail.ingredientName14)
                ingredientData.append(resultsDetail.amount14)
            case 15:
                detailData.append(resultsDetail.ingredientName15)
                ingredientData.append(resultsDetail.amount15)
            case 16:
                detailData.append(resultsDetail.ingredientName16)
                ingredientData.append(resultsDetail.amount16)
            case 17:
                detailData.append(resultsDetail.ingredientName17)
                ingredientData.append(resultsDetail.amount17)
            case 18:
                detailData.append(resultsDetail.ingredientName18)
                ingredientData.append(resultsDetail.amount18)
            case 19:
                detailData.append(resultsDetail.ingredientName19)
                ingredientData.append(resultsDetail.amount19)
            case 20:
                detailData.append(resultsDetail.ingredientName20)
                ingredientData.append(resultsDetail.amount20)
            case 21:
                detailData.append(resultsDetail.ingredientName21)
                ingredientData.append(resultsDetail.amount21)
            case 22:
                detailData.append(resultsDetail.ingredientName22)
                ingredientData.append(resultsDetail.amount22)
            case 23:
                detailData.append(resultsDetail.ingredientName23)
                ingredientData.append(resultsDetail.amount23)
            case 24:
                detailData.append(resultsDetail.ingredientName24)
                ingredientData.append(resultsDetail.amount24)
            case 25:
                detailData.append(resultsDetail.ingredientName25)
                ingredientData.append(resultsDetail.amount25)
            case 26:
                detailData.append(resultsDetail.ingredientName26)
                ingredientData.append(resultsDetail.amount26)
            case 27:
                detailData.append(resultsDetail.ingredientName27)
                ingredientData.append(resultsDetail.amount27)
            case 28:
                detailData.append(resultsDetail.ingredientName28)
                ingredientData.append(resultsDetail.amount28)
            case 29:
                detailData.append(resultsDetail.ingredientName29)
                ingredientData.append(resultsDetail.amount29)
            case 30:
                detailData.append(resultsDetail.ingredientName30)
                ingredientData.append(resultsDetail.amount30)
            default:
                break
            }
        }
        
    }
    
    private func setAddView() {
        let frame = CGRect(x: 0, y: -Const.screenHeight, width: Const.screenWidth, height: Const.screenHeight)
        addIntroductionView = AddIntroductionView(frame: frame)
        addIntroductionView.setupView()
        addDetailView = AddDetailView(frame: frame)
        addDetailView.setupView()
        self.view.addSubview(addIntroductionView)
        self.view.addSubview(addDetailView)
        
    }
    
    private func setNavigationBar() {
        backBottons = UIBarButtonItem(title: "＜返回", style: .done, target: self, action: #selector(backButtonTapped(_:)))
        navigationItem.setLeftBarButton(backBottons, animated: false)
        saveButton = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(saveButtonTapped(_:)))
        navigationItem.setRightBarButton(saveButton, animated: false)
    }
    
    @objc func editSaveButtonTapped (_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
        
    //MARK: - MenuViewに戻る
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        var alertTitle = ""
        var alertMessage = ""
        if introductionData == "" {
            alertTitle = AlertConst.noIntroductionTitle
            alertMessage = AlertConst.noIntroductionMsg
        } else {
            alertTitle = AlertConst.alertTitle
            alertMessage = AlertConst.saveAlertMsg
        }
        //部品のアラートを作る
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
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
        if introductionData == "" {
            introductionData = "未输入"
        }
        
        let results = realm.objects(Menu.self).filter("id == \(menuIndex)").first

        try! realm.write {
            results?.setValue(true, forKey: "isSetData")
        }
       saveDataToDB()
        
    }
    
    private func saveDataToDB() {
        guard let resultsDetail = realm.objects(MenuDetail.self).filter("menuId == \(menuIndex)").first else { return }
        guard let resultsMenu = realm.objects(Menu.self).filter("id == \(menuIndex)").first else { return }
        //MARK: - 画像URL保存TBD.
        try! realm.write {
            resultsMenu.setValue(imageData, forKey: "imageData")
        }
        //紹介文を保存
        try! realm.write {
            resultsMenu.setValue(introductionData, forKey: "introduction")
        }
        

        guard (detailData.count == 0) != true else { return }
        //素材保存
        for i in 0...detailData.count - 1 {
            switch i {
            case 0:
                try! realm.write {
                    resultsDetail.setValue(detailData[0], forKey: "ingredientName0")
                    resultsDetail.setValue(ingredientData[0], forKey: "amount0")
                }
            case 1:
                try! realm.write {
                    resultsDetail.setValue(detailData[1], forKey: "ingredientName1")
                    resultsDetail.setValue(ingredientData[1], forKey: "amount1")
                }
            case 2:
                try! realm.write {
                    resultsDetail.setValue(detailData[2], forKey: "ingredientName2")
                    resultsDetail.setValue(ingredientData[2], forKey: "amount2")
                }
            case 3:
                try! realm.write {
                    resultsDetail.setValue(detailData[3], forKey: "ingredientName3")
                    resultsDetail.setValue(ingredientData[3], forKey: "amount3")
                }
            case 4:
                try! realm.write {
                    resultsDetail.setValue(detailData[4], forKey: "ingredientName4")
                    resultsDetail.setValue(ingredientData[4], forKey: "amount4")
                }
            case 5:
                try! realm.write {
                    resultsDetail.setValue(detailData[5], forKey: "ingredientName5")
                    resultsDetail.setValue(ingredientData[5], forKey: "amount5")
                }
            case 6:
                try! realm.write {
                    resultsDetail.setValue(detailData[6], forKey: "ingredientName6")
                    resultsDetail.setValue(ingredientData[6], forKey: "amount6")
                }
            case 7:
                try! realm.write {
                    resultsDetail.setValue(detailData[7], forKey: "ingredientName7")
                    resultsDetail.setValue(ingredientData[7], forKey: "amount7")
                }
            case 8:
                try! realm.write {
                    resultsDetail.setValue(detailData[8], forKey: "ingredientName8")
                    resultsDetail.setValue(ingredientData[8], forKey: "amount8")
                }
            case 9:
                try! realm.write {
                    resultsDetail.setValue(detailData[9], forKey: "ingredientName9")
                    resultsDetail.setValue(ingredientData[9], forKey: "amount9")
                }
            case 10:
                try! realm.write {
                    resultsDetail.setValue(detailData[10], forKey: "ingredientName10")
                    resultsDetail.setValue(ingredientData[10], forKey: "amount10")
                }
            case 11:
                try! realm.write {
                    resultsDetail.setValue(detailData[11], forKey: "ingredientName11")
                    resultsDetail.setValue(ingredientData[11], forKey: "amount11")
                }
            case 12:
                try! realm.write {
                    resultsDetail.setValue(detailData[12], forKey: "ingredientName12")
                    resultsDetail.setValue(ingredientData[12], forKey: "amount12")
                }
            case 13:
                try! realm.write {
                    resultsDetail.setValue(detailData[13], forKey: "ingredientName13")
                    resultsDetail.setValue(ingredientData[13], forKey: "amount13")
                }
            case 14:
                try! realm.write {
                    resultsDetail.setValue(detailData[14], forKey: "ingredientName14")
                    resultsDetail.setValue(ingredientData[14], forKey: "amount14")
                }
            case 15:
                try! realm.write {
                    resultsDetail.setValue(detailData[15], forKey: "ingredientName15")
                    resultsDetail.setValue(ingredientData[15], forKey: "amount15")
                }
            case 16:
                try! realm.write {
                    resultsDetail.setValue(detailData[16], forKey: "ingredientName16")
                    resultsDetail.setValue(ingredientData[16], forKey: "amount16")
                }
            case 17:
                try! realm.write {
                    resultsDetail.setValue(detailData[17], forKey: "ingredientName17")
                    resultsDetail.setValue(ingredientData[17], forKey: "amount17")
                }
            case 18:
                try! realm.write {
                    resultsDetail.setValue(detailData[18], forKey: "ingredientName18")
                    resultsDetail.setValue(ingredientData[18], forKey: "amount18")
                }
            case 19:
                try! realm.write {
                    resultsDetail.setValue(detailData[19], forKey: "ingredientName19")
                    resultsDetail.setValue(ingredientData[19], forKey: "amount19")
                }
            case 20:
                try! realm.write {
                    resultsDetail.setValue(detailData[20], forKey: "ingredientName20")
                    resultsDetail.setValue(ingredientData[20], forKey: "amount20")
                }
            case 21:
                try! realm.write {
                    resultsDetail.setValue(detailData[21], forKey: "ingredientName21")
                    resultsDetail.setValue(ingredientData[21], forKey: "amount21")
                }
            case 22:
                try! realm.write {
                    resultsDetail.setValue(detailData[22], forKey: "ingredientName22")
                    resultsDetail.setValue(ingredientData[22], forKey: "amount22")
                }
            case 23:
                try! realm.write {
                    resultsDetail.setValue(detailData[23], forKey: "ingredientName23")
                    resultsDetail.setValue(ingredientData[23], forKey: "amount23")
                }
            case 24:
                try! realm.write {
                    resultsDetail.setValue(detailData[24], forKey: "ingredientName24")
                    resultsDetail.setValue(ingredientData[24], forKey: "amount24")
                }
            case 25:
                try! realm.write {
                    resultsDetail.setValue(detailData[25], forKey: "ingredientName25")
                    resultsDetail.setValue(ingredientData[25], forKey: "amount25")
                }
            case 26:
                try! realm.write {
                    resultsDetail.setValue(detailData[26], forKey: "ingredientName26")
                    resultsDetail.setValue(ingredientData[26], forKey: "amount26")
                }
            case 27:
                try! realm.write {
                    resultsDetail.setValue(detailData[27], forKey: "ingredientName27")
                    resultsDetail.setValue(ingredientData[27], forKey: "amount27")
                }
            case 28:
                try! realm.write {
                    resultsDetail.setValue(detailData[28], forKey: "ingredientName28")
                    resultsDetail.setValue(ingredientData[28], forKey: "amount28")
                }
            case 29:
                try! realm.write {
                    resultsDetail.setValue(detailData[29], forKey: "ingredientName29")
                    resultsDetail.setValue(ingredientData[29], forKey: "amount29")
                }
            case 30:
                try! realm.write {
                    resultsDetail.setValue(detailData[30], forKey: "ingredientName30")
                    resultsDetail.setValue(ingredientData[30], forKey: "amount30")
                }
            default:
                break
            }
        }
        
        //素材数保存
        try! realm.write {
            resultsDetail.setValue(detailData.count, forKey: "menuCount")
        }
        
    }
        
    
    //MARK: - 登録Viewが閉じるとNavigation Barの保存を活性化させる
    @objc func tapIngredientOKBtn() {
        introductionData = addIntroductionView.getIngredientData()
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        mainTableView.reloadData()
    }
    
    @objc func tapDetailOKBtn() {
        self.detailData.append(addDetailView.getDetailData())
        self.ingredientData.append(addDetailView.getIngredientData())
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        addDetailView.detailTextField.text = ""
        addDetailView.ingredientTextfield.text = ""
        mainTableView.reloadData()
    }
    
    @objc func tapDetailEditBtn() {
        guard tempIndexPath.row < detailData.count else { return }
        let tempRow = tempIndexPath.row
        self.detailData[tempRow] = addDetailView.getDetailData()
        self.ingredientData[tempRow] = addDetailView.getIngredientData()
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        addDetailView.detailTextField.text = ""
        addDetailView.ingredientTextfield.text = ""
        mainTableView.reloadData()
    }
    
    @objc func tapAddCloseBtn() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
}

extension AddMenuDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tempIndexPath = indexPath
        switch indexPath.section {
        case 0:
            Router.shared.showAddPhoto(from: self, indexPath: self.menuIndex)
        case 1:
            UIView.animate(withDuration: 0.3) {
                self.addIntroductionView.showView()
                self.addIntroductionView.confirmBtn.addTarget(self, action: #selector(self.tapIngredientOKBtn), for: .touchUpInside)
                self.addIntroductionView.closeBtn.addTarget(self, action: #selector(self.tapAddCloseBtn), for: .touchUpInside)
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        case 2:
            UIView.animate(withDuration: 0.3) {
                if indexPath.row == self.detailData.count {
                    self.addDetailView.showView(detail: nil, ingredient: nil)
                    self.addDetailView.confirmBtn.addTarget(self, action: #selector(self.tapDetailOKBtn), for: .touchUpInside)
                } else if indexPath.row < self.detailData.count {
                    self.addDetailView.showView(detail: self.detailData[indexPath.row], ingredient: self.ingredientData[indexPath.row])
                    self.addDetailView.confirmBtn.addTarget(self, action: #selector(self.tapDetailEditBtn), for: .touchUpInside)
                } else { return }
                self.addDetailView.closeBtn.addTarget(self, action: #selector(self.tapAddCloseBtn), for: .touchUpInside)
                self.navigationItem.rightBarButtonItem?.isEnabled = false

            }

        default:
            break
        }
        
    }
    
    
    private func setTextField() {
        itemNameTextfield.placeholder = "请输入配料名"
        itemQuantityTextField.placeholder = "请输入配量"
        
        //MARK: - TextFieldの最大文字数設定
        itemNameTextfield.rx.text
            .map { text in
                if let text = text, text.count > 40 {
                    return String(text.prefix(40))
                } else {
                    return text ?? ""
                }
            }
            .bind(to: itemNameTextfield.rx.text)
            .disposed(by: disposeBag)
        
        itemQuantityTextField.rx.text
            .map { text in
                if let text = text, text.count > 20 {
                    return String(text.prefix(20))
                } else {
                    return text ?? ""
                }
            }
            .bind(to: itemQuantityTextField.rx.text)
            .disposed(by: disposeBag)
        
        //MARK: - TextField入力制限に越した場合ボタン非活性化
        Observable.combineLatest(itemNameTextfield.rx.text.orEmpty.asObservable(), itemQuantityTextField.rx.text.orEmpty.asObservable()){
            $0.count > 0 && $1.count > 0
        }
        .bind(to: confirmButton.rx.isEnabled)
        .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // 背景色を変更する
//        view.tintColor = .red

        let header = view as! UITableViewHeaderFooterView
        // テキスト色を変更する
        header.textLabel?.textColor = .textColor()
    }
}

extension AddMenuDetailViewController: UITableViewDataSource {
    //セッションを設置
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count > 31 ? 31 : sectionTitle.count
    }
    // Sectioのタイトル
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 2 {
            return 1
        } else {
            return detailData.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddMenuDetailTableViewCell

        if indexPath.section == 0 && self.imageData != Data() {
            cell.nameLabel.isHidden = true
            cell.amfeLabel.isHidden = true
            cell.introductionLabel.isHidden = true
            cell.addLabel.isHidden = true
            let cellImage = UIImage(data: imageData)
            cell.photoView.image = cellImage?.resize(size: CGSize(width: 200,height: 200))
            cell.photoView.isHidden = false
        } else if indexPath.section == 1 && introductionData != "" {
            cell.introductionLabel.isHidden = false
            cell.frame.size.height = 40
            cell.addLabel.isHidden = true
            cell.photoView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            cell.photoView.isHidden = true
            cell.introductionLabel.text = introductionData
        } else if indexPath.section == 2 && self.detailData.count > 0 && indexPath.row < self.detailData.count {
            cell.nameLabel.isHidden = false
            cell.amfeLabel.isHidden = false
            cell.introductionLabel.isHidden = true
            cell.addLabel.isHidden = true
            cell.photoView.isHidden = true
            cell.frame.size.height = 40
            cell.nameLabel.text = detailData[indexPath.row]
            cell.amfeLabel.text = ingredientData[indexPath.row ]
        } else {
            cell.nameLabel.isHidden = true
            cell.amfeLabel.isHidden = true
            cell.introductionLabel.isHidden = true
            cell.frame.size.height = 40
            cell.addLabel.isHidden = false
            cell.photoView.isHidden = true
            cell.addLabel.text = "添加"
        }
        cell.backgroundColor = .mainBackgroundColor()
       
        return cell
    }
}

extension AddMenuDetailViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
