//
//  RouletteViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit
import Charts
import RealmSwift

final class RouletteViewController: BaseViewController, ChartViewDelegate {
    
    private let pieChartManager = PieChartManager()
    
    private var spinFlg: Bool = false //停止中
    
    private var randomAngle: Int = 0
    private var errorView: NoMenuDataView!
    private var timer: Timer?
    var timeInterval: Double = 2.0
    
    var menuDatas: [String] = []
    var menuPoints: [Int] = []
    
    private lazy var pieChartView: PieChartView = {
        let view = PieChartView()
        view.delegate = self
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
        try! realm.write {
            results.setValue(menuCount, forKey: "rouletteCount")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.menuPoints[selectedIndex] > 6 {
                Alert.okAlert(title: "恭喜！", message: "选中得分高达:\(self.menuPoints[selectedIndex])的\(self.menuDatas[selectedIndex])，针不戳～", on: self)
            } else if self.menuPoints[selectedIndex] > 3 {
                Alert.okAlert(title: "抱歉！", message: "被得分仅为:\(self.menuPoints[selectedIndex])的\(self.menuDatas[selectedIndex])砸中，推荐点外卖", on: self)
            } else {
                Alert.okAlert(title: "警告！！", message: "被仅获得\(self.menuPoints[selectedIndex])分的\(self.menuDatas[selectedIndex])盯上！一定要外食或外卖！！(小命要紧)", on: self)
            }
            
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
    }
}

extension RouletteViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

