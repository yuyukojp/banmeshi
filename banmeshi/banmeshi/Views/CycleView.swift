//
//  CycleView.swift
//  bannmeshitest
//
//  Created by 金斗石 on 2022/1/7.
//

import UIKit

//無限スクロールのデリゲート
protocol CycleViewDelegate: class {
    func CycleViewItemClick(_ collectionView:UICollectionView,selectedItem item:Int)
}
//パッケージングする
class CycleView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var width: CGFloat!
    var height: CGFloat!
    var imageNames: [String]!
    var timer: Timer?
    var startContentOffsetX: CGFloat = 0
    var item:Int = 0
    var pageControl: UIPageControl?
    weak var delegate: CycleViewDelegate?
    var timeInterval: Double?
    /// frame：collectionView のframe
    /// iamgeNames：画像名
    /// timeInterval：自動スクロールの時間間隔
    /// pageControl：デフォルトは中央揃え
    
    init(frame: CGRect, imageNames: [String], timeInterval: Double = 2, pageControl: UIPageControl? = nil) {
        super.init(frame: frame)
        self.imageNames = imageNames
        self.pageControl = pageControl
        self.timeInterval = timeInterval
        self.width = frame.width
        self.height = frame.height
        setupCollectionView()
        setupTimer()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //タイマーを設置
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval!, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    //自動的に次のページ表示
    @objc func nextPage(){
        //現在のindexpathを取得
        let currentIndexPath = collectionView.indexPathsForVisibleItems.last
        //中間のsectionに移動
        let middleIndexPath = IndexPath(item: (currentIndexPath?.item)!, section: 1)
        collectionView.scrollToItem(at: middleIndexPath, at: .left, animated: false)

        var nextItem = middleIndexPath.item + 1
        var nextSection = middleIndexPath.section
        if nextItem == imageNames.count {
            nextItem = 0
            nextSection += 1
        }
        collectionView.scrollToItem(at: IndexPath(item: nextItem, section: nextSection), at: .left, animated: true)
    }
    //collectionViewセッティング
    func  setupCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = self.bounds.size
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate  = self
        collectionView.contentSize = CGSize(width: width * CGFloat(imageNames.count), height: height)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "identify")
        self.addSubview(collectionView)
        
        if pageControl == nil{
            setupPageControl()
        }else{
            addSubview(pageControl!)
        }
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .left, animated: false)
    }
    //pageControlセッティング
    func setupPageControl(){
        let rect = CGRect(x: Int((width - 150) / 2), y: Int(height - 30), width: 150, height: 20)
        pageControl = UIPageControl(frame: rect)
        pageControl?.numberOfPages = imageNames.count
        pageControl?.currentPageIndicatorTintColor = UIColor.red
        pageControl?.isUserInteractionEnabled = false
        addSubview(pageControl!)
    }
    //タイマーをリセット
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identify", for: indexPath)
        for view:UIView in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let imageView = UIImageView(frame: cell.contentView.bounds)
        //MARK: - ここで画像入れる
        imageView.image = UIImage(named: imageNames[indexPath.row])
        cell.contentView.addSubview(imageView)
        return cell
    }
    //cellをタップするときの動作
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.CycleViewItemClick(collectionView, selectedItem: indexPath.item)
    }
    //ページ変更後PageControlを設置
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int((scrollView.contentOffset.x + width * 0.5) / width)
        let currentPage = page % imageNames.count
        pageControl?.currentPage = currentPage
    }
    //タップするとタイマーをリセット
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        resetTimer()
    }
    //タップ完了後タイマーを再セット
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.setupTimer()
    }
    //手動でスクロール時の処理
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionView.scrollToItem(at: IndexPath(item: (pageControl?.currentPage)!, section: 1), at: .left, animated: false)
    }
}