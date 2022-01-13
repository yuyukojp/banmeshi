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
