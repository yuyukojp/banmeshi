//
//  ViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit
import RealmSwift

final class HomeViewController: BaseViewController {
//    private var saveAreaHeight: CGFloat = 0
//
//    struct Photo {
//        var imageName: String
//    }
//
//    var photoList = [
//        Photo(imageName: "image1"),
//        Photo(imageName: "image2"),
//        Photo(imageName: "image3")
//    ]
//
//    private var scrollView: UIScrollView!
//    private var pageControl: UIPageControl!
//    private var offsetX: CGFloat = 0
//    private var timer: Timer!
        

//    @objc func didTapMenuButton(_ sender: UIButton) {
//        let personalViewController = setStoryboard(sbName: "Menu").instantiateViewController(withIdentifier: "MenuViewController")
//        self.navigationController?.pushViewController(personalViewController, animated: true)
//    }
    
//    func setStoryboard(sbName : String) -> UIStoryboard {
//        return UIStoryboard(name: sbName, bundle: Bundle.main)
//    }
    
    
//    @objc func didTapSetButton(_ sender: UIButton) {
//        DispatchQueue.main.async {
//            if self.realm.objects(Menu.self).count == 0 {
//                Alert.okAlert(title: AlertConst.alertTitle, message: AlertConst.noMenuErrorMsg, on: self)
//            } else if self.realm.objects(Menu.self).count == 1 {
//                Alert.okAlert(title: AlertConst.alertTitle, message: AlertConst.oneMenuErrorMsg, on: self)
//            } else {
//                Router.shared.showRoulette(from: self)
//            }
//        }
//    }
    
    
//    private var menuButton: UIButton = UIButton()
//    private var rouletteButton: UIButton = UIButton()
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupUI()
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        stopTimmer()
//    }
    
//    private func setupUI() {
//
//        //MARK: - Saveエリアの高さを取得
//        let barHeight = CGFloat(self.navigationController?.navigationBar.frame.height ?? 0)
//        let statusBarManager:UIStatusBarManager = UIApplication.shared.windows.first!.windowScene!.statusBarManager!
//        let statusHeight = statusBarManager.statusBarFrame.size.height
//
//        saveAreaHeight = (barHeight + statusHeight)
//
//
//        let ButtonWidth: CGFloat = Const.screenWidth * 2 / 5
//        let ButtonHeight: CGFloat = 40
//        menuButton.frame = CGRect(x: Const.screenWidth / 3,
//                                  y: (Const.screenHeight - 40) / 2,
//                                  width: ButtonWidth,
//                                  height: ButtonHeight)
//        menuButton.backgroundColor = UIColor.systemPink
//        menuButton.addTarget(self, action: #selector(didTapMenuButton(_:)), for: .touchUpInside)
//        menuButton.setTitle("查看菜单", for: .normal)
//        menuButton.layer.cornerRadius = 10
//        menuButton.setTitleColor(UIColor.black, for: .normal)
//        self.view.addSubview(menuButton)
//
//        rouletteButton.frame = CGRect(x: menuButton.frame.origin.x,
//                                      y: menuButton.frame.origin.y - 50,
//                                      width: ButtonWidth,
//                                      height: ButtonHeight)
//        rouletteButton.backgroundColor = UIColor.systemYellow
//        rouletteButton.addTarget(self, action: #selector(didTapSetButton(_:)), for: .touchUpInside)
//        rouletteButton.setTitle("幸运大转盘", for: .normal)
//        rouletteButton.layer.cornerRadius = 10
//        rouletteButton.setTitleColor(UIColor.black, for: .normal)
//        view.addSubview(rouletteButton)
////        setScrollView()
//    }
}
    
//    private func setScrollView() {
//        // scrollViewの画面表示サイズを指定
//        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: saveAreaHeight, width: self.view.frame.size.width, height: 200))
//        // scrollViewのサイズを指定（幅は1メニューに表示するViewの幅×ページ数）
//        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.scrollView.frame.size.height)
//        // scrollViewの初期表示位置を指定
//        self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width, y: 0)
//        // scrollViewのデリゲートになる
//        self.scrollView.delegate = self
//        // メニュー単位のスクロールを可能にする
//        self.scrollView.isPagingEnabled = true
//        // 水平方向のスクロールインジケータを非表示にする
//        self.scrollView.showsHorizontalScrollIndicator = false
//        self.view.addSubview(scrollView)
//
//        // scrollView上にUIImageViewを配置する
//        self.setUpImageView()
//
//        let pageControlHeight = scrollView.frame.origin.y + scrollView.frame.height - CGFloat(30)
//        // pageControlの表示位置とサイズの設定
//        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: pageControlHeight, width: self.view.frame.size.width, height: 30))
//        // pageControlのページ数を設定
//        self.pageControl.numberOfPages = 3
//        // pageControlのドットの色
//        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
//        // pageControlの現在のページのドットの色
//        self.pageControl.currentPageIndicatorTintColor = UIColor.black
//        self.view.addSubview(self.pageControl)
//
//        // タイマーを作成
//        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollPage), userInfo: nil, repeats: true)
//    }
//
//    private func stopTimmer() {
//        if let workingTimer = self.timer {
//            workingTimer.invalidate()
//        }
//    }
    

    
//    // UIImageViewを生成
//    func createImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, image: Photo) -> UIImageView {
//        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
//        let image = UIImage(named:  image.imageName)
//        imageView.image = image
//        return imageView
//    }
//
//    // photoListの要素分UIImageViewをscrollViewに並べる
//    func setUpImageView() {
//        for i in 0 ..< self.photoList.count {
//            let photoItem = self.photoList[i]
//            let imageView = createImageView(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height, image: photoItem)
//            imageView.frame = CGRect(origin: CGPoint(x: self.view.frame.size.width * CGFloat(i), y: 0), size: CGSize(width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
//            self.scrollView.addSubview(imageView)
//        }
//    }
//
//    // offsetXの値を更新することページを移動
//    @objc func scrollPage() {
//        // 画面の幅分offsetXを移動
//        self.offsetX -= self.view.frame.size.width
//        // 3ページ目まで移動したら1ページ目まで戻る
//        if self.offsetX < self.view.frame.size.width * 3 {
//            UIView.animate(withDuration: 0.3) {
//                self.scrollView.contentOffset.x = self.offsetX
//            }
//        } else {
//            UIView.animate(withDuration: 0.3) {
//                self.offsetX = 0
//                self.scrollView.contentOffset.x = self.offsetX
//            }
//        }
//    }
//
//}
//
//// scrollViewのページ移動に合わせて画像がループするような順番で表示させる
//extension HomeViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetX = self.scrollView.contentOffset.x
//
//        if (offsetX > self.scrollView.frame.size.width * 1.5) {
//            // photoListの先頭の要素を末尾の要素にする
//            let sortedPhoto = self.photoList[0]
//            self.photoList.append(sortedPhoto)
//            // photoListの先頭の要素削除
//            self.photoList.removeFirst()
//            // 順序が入れ替えられたphotoListで描画
//            self.setUpImageView()
//
//            // contentOffsetの調整
//            self.scrollView.contentOffset.x -= self.scrollView.frame.size.width
//        }
//
//        if (offsetX < self.scrollView.frame.size.width * 0.5) {
//            // photoListの末尾の要素を先頭の要素にする
//            let sortedPhoto = self.photoList[2]
//            self.photoList.insert(sortedPhoto, at: 0)
//            // photoListの末尾の要素削除
//            self.photoList.removeLast()
//            // 順序が入れ替えられたphotoListで描画
//            self.setUpImageView()
//
//            // contentOffsetの調整
//            self.scrollView.contentOffset.x += self.scrollView.frame.size.width
//        }
//
//        // scrollViewのページ移動に合わせてpageControlの表示も移動
//        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
//        // offsetXの値を更新
//        self.offsetX = self.scrollView.contentOffset.x
//    }
//}
