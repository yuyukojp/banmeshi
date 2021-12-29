//
//  ViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit
import RealmSwift

final class HomeViewController: UIViewController {
    let realm = try! Realm()
    

    @objc func didTapMenuButton(_ sender: UIButton) {
        let personalViewController = setStoryboard(sbName: "Menu").instantiateViewController(withIdentifier: "MenuViewController")
        self.navigationController?.pushViewController(personalViewController, animated: true)
    }
    
    func setStoryboard(sbName : String) -> UIStoryboard {
        return UIStoryboard(name: sbName, bundle: Bundle.main)
    }
    
    
    @objc func didTapSetButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            if self.realm.objects(Menu.self).count == 0 {
                Alert.okAlert(title: Const.alertTitle, message: Const.noMenuErrorMsg, on: self)
            } else if self.realm.objects(Menu.self).count == 0 {
                Alert.okAlert(title: Const.alertTitle, message: Const.oneMenuErrorMsg, on: self)
            } else {
                Router.shared.showRoulette(from: self, data: self.getData())
            }           
        }
    }
    
    private func getData() -> [String]{
        var namedata: [String] = []
        let menuData = self.realm.objects(Menu.self)
        let menuCount = menuData.count
        for i in 0...(menuCount - 1) {
            namedata.append(menuData[i].name)
        }
        return namedata
    }
    
    private var menuButton: UIButton = UIButton()
    private var rouletteButton: UIButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        setupViewsLayout()
        setupUI()
        
    }
    
    private func setupUI() {
        let ButtonWidth: CGFloat = Const.screenWidth * 2 / 5
        let ButtonHeight: CGFloat = 40
        menuButton.frame = CGRect(x: Const.screenWidth / 3,
                                  y: (Const.screenHeight - 40) / 2,
                                  width: ButtonWidth,
                                  height: ButtonHeight)
        menuButton.backgroundColor = UIColor.systemPink
        menuButton.addTarget(self, action: #selector(didTapMenuButton(_:)), for: .touchUpInside)
        menuButton.setTitle("メニュー", for: .normal)
        menuButton.layer.cornerRadius = 10
        menuButton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(menuButton)
        
        rouletteButton.frame = CGRect(x: menuButton.frame.origin.x,
                                      y: menuButton.frame.origin.y - 50,
                                      width: ButtonWidth,
                                      height: ButtonHeight)
        rouletteButton.backgroundColor = UIColor.systemYellow
        rouletteButton.addTarget(self, action: #selector(didTapSetButton(_:)), for: .touchUpInside)
        rouletteButton.setTitle("ラッキールーレット", for: .normal)
        rouletteButton.layer.cornerRadius = 10
        rouletteButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(rouletteButton)
        
        
    }
    
}

//private extension HomeViewController {
//    private func setupViewsLayout() {
//        let vStackView = UIStackView(arrangedSubviews: textFields)
//        vStackView.axis = .vertical
//        vStackView.alignment = .fill
//        vStackView.distribution = .fillEqually
//        vStackView.spacing = 8
//        view.addSubview(vStackView)
//        vStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate(
//            [
//                vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//                vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//                vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//                vStackView.heightAnchor.constraint(equalToConstant: 500)
//            ]
//        )
//        view.addSubview(setButton)
//        setButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate(
//            [
//                setButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 16),
//                setButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                setButton.heightAnchor.constraint(equalToConstant: 60),
//                setButton.widthAnchor.constraint(equalToConstant: 200)
//            ]
//        )
//    }
//}

