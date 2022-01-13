//
//  RouletteViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit
import Charts
import RealmSwift
import SwiftUI

final class RouletteViewController: BaseViewController, ChartViewDelegate {
    
    private let pieChartManager = PieChartManager()
    
    private var spinFlg: Bool = false //停止中
    
    private var randomAngle: Int = 0
    private var errorView: NoMenuDataView!
    private var timer: Timer?
    var timeInterval: Double = 2.0
    
    var menuDatas: [String] = []
    var menuPoints: [Int] = []
    var selectedId: Int = 0
    var tabelViewLabel: UILabel = UILabel()
    private let historyTabelView: UITableView = UITableView()
    private let histroyClearBtn: CusstomButton = CusstomButton(frame: CGRect())
    
    private lazy var pieChartView: PieChartView = {
        let view = PieChartView()
        view.delegate = self
        view.transparentCircleColor = .navigation()
        view.holeColor = .textColor()
        
        return view
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrow"))
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(didTapStartStopButton(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapStartStopButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            if !self.spinFlg {
                self.setupTimer()
                //停止→開始
                self.spinFlg.toggle()
                self.randomAngle = Int.random(in: 1...359) //update randomAngle
                self.pieChartView.spin(
                    duration: 60,
                    fromAngle: 270,
                    toAngle: CGFloat(self.randomAngle) + 36500,
                    easingOption: .linear
                )
                //button UI
                self.startStopButton.backgroundColor = .systemBlue
                self.startStopButton.setTitle("Stop", for: .normal)
            } else {
                self.stopRLT()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.delegate = self
        setupUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        removeAllSubviews(parentView: self.view)
        setData()
        pieChartManager.setData(pieChartView, data: menuDatas)
        setupUI()
    }
    
    private func setupUI() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "幸运大转盘"
        setData()
        //Layout
        setupViewsLayout()
        //Pie Chartの設定
        pieChartManager.setup(pieChartView)
        let result = realm.objects(Menu.self)
        let frame = CGRect(x: 0, y: 0, width: Const.screenWidth, height: Const.screenHeight)
        errorView = NoMenuDataView(frame: frame)
        self.view.addSubview(errorView)
        if result.count < 2 {
            errorView.isHidden = false
        } else {
            errorView.isHidden = true
        }
        setupHistoryTabelview()
    }
    
    func setupHistoryTabelview() {
        historyTabelView.delegate = self
        historyTabelView.dataSource = self
        historyTabelView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        tabelViewLabel.text = StringConst.historyTabelViewTitle
    }
    
    func removeAllSubviews(parentView: UIView){
        var subviews = parentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(stopRoulette), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    //タイマーをリセット
    func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func stopRoulette() {
        stopRLT()
    }
    
    private func stopRLT() {
        self.resetTimer()
        //開始→停止
        self.spinFlg.toggle()
        self.pieChartView.spin(
            duration: 2.0,
            fromAngle: 270,
            toAngle: 270 + 360 + CGFloat(self.randomAngle),
            easingOption: .linear
        )
        //button UI
        self.startStopButton.backgroundColor = .systemRed
        self.startStopButton.setTitle("Start", for: .normal)
        
        //SHOW RESULT
        //                let menus = self.realm.objects(Menu.self)
        //                let dataCount = menus.count
        let selectedIndex = self.pieChartManager.getSelectedIndex(dataCount: self.menuDatas.count, randomAngle: self.randomAngle)
        let results = realm.objects(Menu.self)[selectedIndex]
        let menuCount = results.rouletteCount + 1
        selectedId = results.id
        try! realm.write {
            results.setValue(menuCount, forKey: "rouletteCount")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.menuPoints[selectedIndex] > 6 {
                Alert.okAlert(title: "恭喜！", message: "选中得分高达:\(self.menuPoints[selectedIndex])的\(self.menuDatas[selectedIndex])，针不戳～", on: self)
            } else if self.menuPoints[selectedIndex] > 3 {
                Alert.okAlert(title: "抱歉！",
                              message: "被得分仅为:\(self.menuPoints[selectedIndex])的\(self.menuDatas[selectedIndex])砸中，推荐点外卖",
                              on: self)
            } else {
                Alert.okAlert(title: "警告！！",
                              message: "被仅获得\(self.menuPoints[selectedIndex])分的\(self.menuDatas[selectedIndex])盯上！一定要外食或外卖！！(小命要紧)",
                              on: self)
            }
            self.setHistoryData()
            self.historyTabelView.reloadData()
        }
    }
    
    private func setData() {
        let menus = self.realm.objects(Menu.self)
        let dataCount = menus.count
        menuDatas = []
        menuPoints = []
        guard dataCount > 1 else { return }
        for i in 0...(dataCount - 1) {
            menuDatas.append(menus[i].name)
            menuPoints.append(menus[i].point)
        }
    }
    
    private func setHistoryData() {
        //履歴データをDBに保存
        let history = History()
        history.id = self.newId(model: history)!
        history.menuId = selectedId
        try! realm.write {
            realm.add(history)
        }
    }
    
    @objc func tapClearHistory() {
        //部品のアラートを作る
        let alertController = UIAlertController(title: AlertConst.alertTitle, message: AlertConst.clearHistoryMsg, preferredStyle: UIAlertController.Style.alert)
        //OKボタン追加
        let okAction = UIAlertAction(title: AlertConst.ok, style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
            self.clearRouletteCount()
        })
        let cancelAction = UIAlertAction(title: AlertConst.cancel, style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
        })

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        //アラートを表示する
         present(alertController, animated: true, completion: nil)
       
    }
    
    private func clearRouletteCount() {
        let historyResults = realm.objects(History.self)
        try! realm.write {
            realm.delete(historyResults)
        }
        historyTabelView.reloadData()
        let results = realm.objects(Menu.self)
        for i in 0...(results.count - 1) {
            let result = realm.objects(Menu.self)[i]
            try! realm.write {
                result.setValue(0, forKey: "rouletteCount")
            }
        }
    }
}

private extension RouletteViewController {
    private func setupViewsLayout() {
        //Pie chart
        view.addSubview(pieChartView)
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                pieChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                pieChartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                pieChartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                pieChartView.heightAnchor.constraint(equalToConstant: 300)
            ]
        )
        
        //arrow image
        view.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                arrowImageView.topAnchor.constraint(equalTo: pieChartView.topAnchor),
                arrowImageView.centerXAnchor.constraint(equalTo: pieChartView.centerXAnchor),
                arrowImageView.widthAnchor.constraint(equalToConstant: 50),
                arrowImageView.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
        //startStopButton
        view.addSubview(startStopButton)
        startStopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                startStopButton.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: 40),
                startStopButton.heightAnchor.constraint(equalToConstant: 60),
                startStopButton.widthAnchor.constraint(equalToConstant: 200)
            ]
        )
        
        //historyTabelView
        view.addSubview(historyTabelView)
        historyTabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                historyTabelView.topAnchor.constraint(equalTo: startStopButton.bottomAnchor, constant: 70),
                historyTabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                historyTabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                historyTabelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
//                historyTabelView.heightAnchor.constraint(equalToConstant: 300)
            ]
        )
        historyTabelView.backgroundColor = .mainBackgroundColor()
        
        //histroyTabelViewLabel
        view.addSubview(tabelViewLabel)
        tabelViewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                tabelViewLabel.topAnchor.constraint(equalTo: startStopButton.bottomAnchor, constant: 30),
                tabelViewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                tabelViewLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                tabelViewLabel.heightAnchor.constraint(equalToConstant: 30)
            ]
        )
        tabelViewLabel.textColor = .titleColor()
        tabelViewLabel.backgroundColor = .mainBackgroundColor()
        tabelViewLabel.textAlignment = NSTextAlignment.center
        tabelViewLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        //historyClearBtn
        view.addSubview(histroyClearBtn)
        histroyClearBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                histroyClearBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
                histroyClearBtn.heightAnchor.constraint(equalToConstant: 20),
                histroyClearBtn.widthAnchor.constraint(equalToConstant: 100),
                histroyClearBtn.bottomAnchor.constraint(equalTo: historyTabelView.topAnchor, constant: 0)
            ]
        )
        histroyClearBtn.setTitle(StringConst.historyClearBtnTitle, for: .normal)
        histroyClearBtn.addTarget(self, action: #selector(tapClearHistory), for: .touchUpInside)
    }
}

extension RouletteViewController: UITableViewDelegate {
    
    
}

extension RouletteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(History.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTabelView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
        let indexResult = realm.objects(History.self)
        let menuId = indexResult[indexResult.count - 1 - indexPath.row].menuId
        guard let result = realm.objects(Menu.self).filter("id == \(menuId)").first else {
            return cell
        }
        cell.historyNameLabel.text = result.name
        cell.pointLabel.text = String(result.point) + " 分"
        return cell
    }    
}

extension RouletteViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

