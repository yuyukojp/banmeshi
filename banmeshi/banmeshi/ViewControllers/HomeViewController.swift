//
//  ViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit
import RealmSwift
import SwiftUI

final class HomeViewController: BaseViewController, CycleViewDelegate {
    private var rankTabelView: UITableView = UITableView()
    private var statusHeight: CGFloat = 0
    private var totalCount: Int = 0
    private var tempData: [Int] = []
    private var tempIndex: [Int] = []

    
    //delegateを実行
    func CycleViewItemClick(_ collectionView: UICollectionView, selectedItem item: Int) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.delegate = self
        setupRankTabelView()
//        setupUI()
        setupCycleView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        rankTabelView.reloadData()
        setupUI()
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.topItem?.title = "幸运晚餐"
        tempData = []
        tempIndex = []
        totalCount = 0
        let result = realm.objects(Menu.self)
        guard result.count != 0 else { return }
        
        for i in 0...(result.count - 1) {
            tempIndex.append(result[i].id)
            tempData.append(result[i].rouletteCount)
            totalCount += result[i].rouletteCount
        }
        
    }
    
    private func setupDelimiter() {
        
    }
    
    private func setupCycleView() {
        //画像名
        let imageArr = ["image1","image2","image3"]
        //Frameを定義セーフエリアの高さを取得
        let barHeight = CGFloat(self.navigationController?.navigationBar.frame.height ?? 0)   //顶部NavigationBar高度
        let statusBarManager: UIStatusBarManager = UIApplication.shared.windows.first!.windowScene!.statusBarManager!
        statusHeight = statusBarManager.statusBarFrame.size.height
        
        let rect = CGRect(x: 0, y: statusHeight + barHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 9 / 14)
        
        //1.デフォルトのPageControllは中央揃え、timeintervalは２S
        let cycleView =  CycleView(frame: rect, imageNames: imageArr, timeInterval: 3)

        cycleView.delegate = self
        self.view.addSubview(cycleView)
        
    }
    
    private func setupRankTabelView() {
        rankTabelView.delegate = self
        rankTabelView.dataSource = self
        
        rankTabelView.frame = CGRect(x: 0, y: statusHeight + (UIScreen.main.bounds.width * 9 / 14) + 110, width: Const.screenWidth, height: 400)
        rankTabelView.register(UINib(nibName: "RankTableViewCell", bundle: nil), forCellReuseIdentifier: "RankCell")
        rankTabelView.backgroundColor = .mainBackgroundColor()
        self.view.addSubview(rankTabelView)
    }

}
    
extension HomeViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempDataIndex = tempData.count - indexPath.row - 1
        guard let results = realm.objects(Menu.self).filter("id == \(tempIndex[tempDataIndex])").first else { return }
        if results.isSetData {
            Router.shared.showMenuDetail(from: self, indexPath: results.id)
        } else {
            Router.shared.showAddMenuDetail(from: self, indexPath: results.id)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = realm.objects(Menu.self)
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rankTabelView.dequeueReusableCell(withIdentifier: "RankCell", for: indexPath) as! RankTableViewCell
        
        if tempData.count > 1 {
            for i in 1...(tempData.count - 1) {
                for j in 1...(tempData.count - i) {
                    if tempData[j - 1] > tempData[j] {
                        tempData.swapAt(j - 1, j)
                        tempIndex.swapAt(j - 1, j)
                    }
                }
            }
        }
        
        let tempDataIndex = tempData.count - indexPath.row - 1
        if tempDataIndex >= 0 {
            guard let resultsDetail = realm.objects(Menu.self).filter("id == \(tempIndex[tempDataIndex])").first else {
                return cell
            }
            cell.nameLabel.text = resultsDetail.name
            cell.countLabel.text = StringConst.count + String(resultsDetail.rouletteCount) + StringConst.beforeCount

            let resultCount: Float = Float(resultsDetail.rouletteCount)
            let toutalCounts: Float = Float(totalCount)

            cell.menuProgress.progress = resultCount / toutalCounts
        }
        
        return cell
    }
}
