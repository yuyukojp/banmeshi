//
//  ViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit
import RealmSwift

final class HomeViewController: BaseViewController, CycleViewDelegate {
    
    //delegateを実行
    func CycleViewItemClick(_ collectionView: UICollectionView, selectedItem item: Int) {
        print(item)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        setupCycleView()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.topItem?.title = "some title"
    }
    
    private func setupCycleView() {
        self.view.backgroundColor = .white
        //画像名
        let imageArr = ["image1","image2","image3"]
        //Frameを定義セーフエリアの高さを取得
        let barHeight = CGFloat(self.navigationController?.navigationBar.frame.height ?? 0)   //顶部NavigationBar高度
        let statusBarManager: UIStatusBarManager = UIApplication.shared.windows.first!.windowScene!.statusBarManager!
        let statusHeight = statusBarManager.statusBarFrame.size.height
        
        let rect = CGRect(x: 0, y: statusHeight + barHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 9 / 14)
        
        //1.デフォルトのPageControllは中央揃え、timeintervalは２S
        let cycleView =  CycleView(frame: rect, imageNames: imageArr, timeInterval: 3)

        cycleView.delegate = self
        self.view.addSubview(cycleView)
        
//        2.pageControlをカスタム
//        let pageControl = UIPageControl(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
//        pageControl.currentPageIndicatorTintColor = UIColor.blue
//        pageControl.isUserInteractionEnabled = false
//        pageControl.numberOfPages = imageArr.count
//        let cycleView = CycleView(frame: rect, imageNames: imageArr, pageControl: pageControl)
//        cycleView.delegate = self
//        self.view.addSubview(cycleView)
    }

}
    
