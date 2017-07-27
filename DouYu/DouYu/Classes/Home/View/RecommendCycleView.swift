//
//  RecommendCycleView.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/26.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

private let kCycleCellID = "cycleCellID"

class RecommendCycleView: UIView {
    fileprivate var cycleTimer : Timer?
    
    var cycleModels :[CycleModel]? {
        didSet {
            //1.刷新表格
            collectionView.reloadData()
            //2.设置pageController的数量
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //3.默认滚到中间位置, 左右滑动都可以
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //4.添加定时器
            removeTimer()
            addTimer()
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // MARK:-设置内边距, 可以让其显示cycleView (很重要, 不好找bug)设置该空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
//        collectionView.backgroundColor = UIColor.green
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    //在layout里面做size的设置最为准确
    override func layoutSubviews() {
        super.layoutSubviews()
        //1.拿到layout(强转为UICollectionViewFlowLayout才可以进行item设置)itemSize不能通过xib设置
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        //以下这些属性可以在xib中用keypath通过KVC设置
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }
}
// MARK:-扩展类的便利构造器
extension RecommendCycleView {
    class func creatRecommendCycleView()->RecommendCycleView {
        let cycleView = Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
        cycleView.backgroundColor = UIColor.red
        return cycleView
    }
}

// MARK:-遵守数据源协议
extension RecommendCycleView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.backgroundColor = indexPath.item % 2 == 1 ? UIColor.red : UIColor.black
        
        let cycleModel = cycleModels?[indexPath.item % cycleModels!.count]
        cell.cycleModel = cycleModel
        
        return cell
    }
}
// MARK:-遵守代理
extension RecommendCycleView:UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width / 2
        
        //2.计算pageController的下标
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % cycleModels!.count
    }
    
    //开始拖拽的时候, 移除定时器
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        removeTimer()
    }
    
    //结束拖拽, 添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}
// MARK:-添加定时器
extension RecommendCycleView {
    //添加定时器
    fileprivate func addTimer() {
        cycleTimer = Timer(timeInterval: 2.5, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    //移除定时器
    fileprivate func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    //定时器执行方法
    @objc fileprivate func scrollToNext (){
        //1.获取偏移量
        let currentOffSetX = collectionView.contentOffset.x
        let offsetX = currentOffSetX + collectionView.bounds.width
        
        //2.滚动到该位置
        collectionView.setContentOffset( CGPoint(x: offsetX, y: 0), animated: true)
    }
}

