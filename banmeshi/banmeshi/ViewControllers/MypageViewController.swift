//
//  MypageViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/13.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import SwiftCSVExport
import Alamofire

class MypageViewController: BaseViewController {
    private var outputButton: CusstomButton!
    private var inputButton:CusstomButton!
    private var testTextField: CustomTextField!
    private var versionLabel: UILabel!
    private var buildLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "个人信息"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .textColor()
        // NavigationBarを表示したい場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.delegate = self
    }
    
    private func setupUI() {
        self.view.backgroundColor = .mainBackgroundColor()
        outputButton = CusstomButton(frame: CGRect(x: (Const.screenWidth - 140) / 2,
                                                   y: (Const.screenHeight - 80) / 2,
                                                   width: 140,
                                                   height: 50))
        outputButton.setTitle("导出CSV数据", for: .normal)
        outputButton.addTarget(self, action: #selector(tapOutputBtn), for: .touchUpInside)
        
        inputButton = CusstomButton(frame: CGRect(x: (Const.screenWidth - 140) / 2,
                                                  y: (Const.screenHeight + 80) / 2,
                                                  width: 140,
                                                  height: 50))
        inputButton.setTitle("导人CSV数据", for: .normal)
        inputButton.addTarget(self, action: #selector(tapInputBtn), for: .touchUpInside)
        self.view.addSubview(outputButton)
        self.view.addSubview(inputButton)
        testTextField = CustomTextField(frame: CGRect(x: 20, y: 120, width: 200, height: 40))
        self.view.addSubview(testTextField)
//        setupViewsLayout()
        versionLabel = UILabel()
        buildLabel = UILabel()
        versionLabel.frame = CGRect(x: 80, y: Const.screenHeight - 130, width: 120, height: 30)
        buildLabel.frame = CGRect(x: (Const.screenWidth / 2) + 20, y: Const.screenHeight - 130, width: 120, height: 30)
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        versionLabel.text = "Version: \(version)"
        buildLabel.text = "Build: \(build)"
        versionLabel.textColor = .lightGray
        buildLabel.textColor = .lightGray
        self.view.addSubview(versionLabel)
        self.view.addSubview(buildLabel)
    }
    
    let popup = ExampleJKBlurPopup()
    @objc func tapOutputBtn() {
        popup.showInView(target: self.view)
    }
    
    @objc func tapInputBtn() {
        getMenuData()
    }
    
    private func getMenuData() {
        let url = "http://mock.apistub.cn/user/jindoushi/Banmeshi/getlist"
        NetworkTools.requestData(.get, URLString: url) { result in
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["menus"] as? [[String: Any]] else { return }
            for i in 0...(dataArray.count - 1) {
                guard let apiMenu = dataArray[i]["menu"] as? [String: Any] else { return }

                guard let id = apiMenu["id"] else { return }
                guard let name = apiMenu["name"] else { return }
                guard let point = apiMenu["point"] else { return }
                guard let imageData = apiMenu["imageData"] else { return }
                guard let introduction = apiMenu["introduction"] else { return }
                guard let isSetData = apiMenu["isSetData"] else { return }
                guard let rouletteCount = apiMenu["rouletteCount"] else { return }
                let result = Menu()
                result.id = id as! Int
                result.name = name as! String
                result.point = point as! Int
                let imageDataString = imageData as! String                
                result.imageData = imageDataString.data(using: .utf8)!
                result.introduction = introduction as! String
                result.isSetData = isSetData as! Bool
                result.rouletteCount = rouletteCount as! Int
//                try! self.realm.write {
//                    self.realm.add(result)
//                }
                
                guard let apiMenuDetail = dataArray[i]["menudetail"] as? [String: Any] else { return }
                guard let menuId = apiMenuDetail["menuId"] else { return }
                guard let menuCount = apiMenuDetail["menuCount"] else { return }
                // 食材名
                guard let ingredientName0 = apiMenuDetail["ingredientName0"] else { return }
                guard let ingredientName1 = apiMenuDetail["ingredientName1"] else { return }
                guard let ingredientName2 = apiMenuDetail["ingredientName2"] else { return }
                guard let ingredientName3 = apiMenuDetail["ingredientName3"] else { return }
                guard let ingredientName4 = apiMenuDetail["ingredientName4"] else { return }
                guard let ingredientName5 = apiMenuDetail["ingredientName5"] else { return }
                guard let ingredientName6 = apiMenuDetail["ingredientName6"] else { return }
                guard let ingredientName7 = apiMenuDetail["ingredientName7"] else { return }
                guard let ingredientName8 = apiMenuDetail["ingredientName8"] else { return }
                guard let ingredientName9 = apiMenuDetail["ingredientName9"] else { return }
                guard let ingredientName10 = apiMenuDetail["ingredientName10"] else { return }
                guard let ingredientName11 = apiMenuDetail["ingredientName11"] else { return }
                guard let ingredientName12 = apiMenuDetail["ingredientName12"] else { return }
                guard let ingredientName13 = apiMenuDetail["ingredientName13"] else { return }
                guard let ingredientName14 = apiMenuDetail["ingredientName14"] else { return }
                guard let ingredientName15 = apiMenuDetail["ingredientName15"] else { return }
                guard let ingredientName16 = apiMenuDetail["ingredientName16"] else { return }
                guard let ingredientName17 = apiMenuDetail["ingredientName17"] else { return }
                guard let ingredientName18 = apiMenuDetail["ingredientName18"] else { return }
                guard let ingredientName19 = apiMenuDetail["ingredientName19"] else { return }
                guard let ingredientName20 = apiMenuDetail["ingredientName20"] else { return }
                guard let ingredientName21 = apiMenuDetail["ingredientName21"] else { return }
                guard let ingredientName22 = apiMenuDetail["ingredientName22"] else { return }
                guard let ingredientName23 = apiMenuDetail["ingredientName23"] else { return }
                guard let ingredientName24 = apiMenuDetail["ingredientName24"] else { return }
                guard let ingredientName25 = apiMenuDetail["ingredientName25"] else { return }
                guard let ingredientName26 = apiMenuDetail["ingredientName26"] else { return }
                guard let ingredientName27 = apiMenuDetail["ingredientName27"] else { return }
                guard let ingredientName28 = apiMenuDetail["ingredientName28"] else { return }
                guard let ingredientName29 = apiMenuDetail["ingredientName29"] else { return }
                guard let ingredientName30 = apiMenuDetail["ingredientName30"] else { return }
                
                // 分量
                guard let amount0 = apiMenuDetail["amount0"] else { return }
                guard let amount1 = apiMenuDetail["amount1"] else { return }
                guard let amount2 = apiMenuDetail["amount2"] else { return }
                guard let amount3 = apiMenuDetail["amount3"] else { return }
                guard let amount4 = apiMenuDetail["amount4"] else { return }
                guard let amount5 = apiMenuDetail["amount5"] else { return }
                guard let amount6 = apiMenuDetail["amount6"] else { return }
                guard let amount7 = apiMenuDetail["amount7"] else { return }
                guard let amount8 = apiMenuDetail["amount8"] else { return }
                guard let amount9 = apiMenuDetail["amount9"] else { return }
                guard let amount10 = apiMenuDetail["amount10"] else { return }
                guard let amount11 = apiMenuDetail["amount11"] else { return }
                guard let amount12 = apiMenuDetail["amount12"] else { return }
                guard let amount13 = apiMenuDetail["amount13"] else { return }
                guard let amount14 = apiMenuDetail["amount14"] else { return }
                guard let amount15 = apiMenuDetail["amount15"] else { return }
                guard let amount16 = apiMenuDetail["amount16"] else { return }
                guard let amount17 = apiMenuDetail["amount17"] else { return }
                guard let amount18 = apiMenuDetail["amount18"] else { return }
                guard let amount19 = apiMenuDetail["amount19"] else { return }
                guard let amount20 = apiMenuDetail["amount20"] else { return }
                guard let amount21 = apiMenuDetail["amount21"] else { return }
                guard let amount22 = apiMenuDetail["amount22"] else { return }
                guard let amount23 = apiMenuDetail["amount23"] else { return }
                guard let amount24 = apiMenuDetail["amount24"] else { return }
                guard let amount25 = apiMenuDetail["amount25"] else { return }
                guard let amount26 = apiMenuDetail["amount26"] else { return }
                guard let amount27 = apiMenuDetail["amount27"] else { return }
                guard let amount28 = apiMenuDetail["amount28"] else { return }
                guard let amount29 = apiMenuDetail["amount29"] else { return }
                guard let amount30 = apiMenuDetail["amount30"] else { return }
                let resultDetail = MenuDetail()
                resultDetail.menuId = menuId as! Int
                resultDetail.menuCount = menuCount as! Int
                resultDetail.ingredientName0 = ingredientName0 as! String
                resultDetail.ingredientName1 = ingredientName1 as! String
                resultDetail.ingredientName2 = ingredientName2 as! String
                resultDetail.ingredientName3 = ingredientName3 as! String
                resultDetail.ingredientName4 = ingredientName4 as! String
                resultDetail.ingredientName5 = ingredientName5 as! String
                resultDetail.ingredientName6 = ingredientName6 as! String
                resultDetail.ingredientName7 = ingredientName7 as! String
                resultDetail.ingredientName8 = ingredientName8 as! String
                resultDetail.ingredientName9 = ingredientName9 as! String
                resultDetail.ingredientName10 = ingredientName10 as! String
                resultDetail.ingredientName11 = ingredientName11 as! String
                resultDetail.ingredientName12 = ingredientName12 as! String
                resultDetail.ingredientName13 = ingredientName13 as! String
                resultDetail.ingredientName14 = ingredientName14 as! String
                resultDetail.ingredientName15 = ingredientName15 as! String
                resultDetail.ingredientName16 = ingredientName16 as! String
                resultDetail.ingredientName17 = ingredientName17 as! String
                resultDetail.ingredientName18 = ingredientName18 as! String
                resultDetail.ingredientName19 = ingredientName19 as! String
                resultDetail.ingredientName20 = ingredientName20 as! String
                resultDetail.ingredientName21 = ingredientName21 as! String
                resultDetail.ingredientName22 = ingredientName22 as! String
                resultDetail.ingredientName23 = ingredientName23 as! String
                resultDetail.ingredientName24 = ingredientName24 as! String
                resultDetail.ingredientName25 = ingredientName25 as! String
                resultDetail.ingredientName26 = ingredientName26 as! String
                resultDetail.ingredientName27 = ingredientName27 as! String
                resultDetail.ingredientName28 = ingredientName28 as! String
                resultDetail.ingredientName29 = ingredientName29 as! String
                resultDetail.ingredientName30 = ingredientName30 as! String
                resultDetail.amount0 = amount0 as! String
                resultDetail.amount1 = amount1 as! String
                resultDetail.amount2 = amount2 as! String
                resultDetail.amount3 = amount3 as! String
                resultDetail.amount4 = amount4 as! String
                resultDetail.amount5 = amount5 as! String
                resultDetail.amount6 = amount6 as! String
                resultDetail.amount7 = amount7 as! String
                resultDetail.amount8 = amount8 as! String
                resultDetail.amount9 = amount9 as! String
                resultDetail.amount10 = amount10 as! String
                resultDetail.amount11 = amount11 as! String
                resultDetail.amount12 = amount12 as! String
                resultDetail.amount13 = amount13 as! String
                resultDetail.amount14 = amount14 as! String
                resultDetail.amount15 = amount15 as! String
                resultDetail.amount16 = amount16 as! String
                resultDetail.amount17 = amount17 as! String
                resultDetail.amount18 = amount18 as! String
                resultDetail.amount19 = amount19 as! String
                resultDetail.amount20 = amount20 as! String
                resultDetail.amount21 = amount21 as! String
                resultDetail.amount22 = amount22 as! String
                resultDetail.amount23 = amount23 as! String
                resultDetail.amount24 = amount24 as! String
                resultDetail.amount25 = amount25 as! String
                resultDetail.amount26 = amount26 as! String
                resultDetail.amount27 = amount27 as! String
                resultDetail.amount28 = amount28 as! String
                resultDetail.amount29 = amount29 as! String
                resultDetail.amount30 = amount30 as! String
//                try! self.realm.write {
//                    self.realm.add(resultDetail)
//                }
            }

        }
    }
}

extension MypageViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

private extension MypageViewController {
    private func setupViewsLayout() {
        //selectPointBtn
        versionLabel = UILabel()
        view.addSubview(versionLabel)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                versionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 130),
                versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30),
                versionLabel.heightAnchor.constraint(equalToConstant: 30),
                versionLabel.widthAnchor.constraint(equalToConstant: 80),
            ]
        )
        versionLabel.text = "321321"
        versionLabel.textColor = .lightText

    }
}
