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
    
    @objc func tapOutputBtn() {
        
    }
    
    @objc func tapInputBtn() {
        
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
