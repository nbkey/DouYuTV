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

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // MARK:-设置内边距, 可以让其显示cycleView (很重要, 不好找bug)设置该空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.backgroundColor = UIColor.green
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
//        collectionView.
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
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 1 ? UIColor.red : UIColor.black
        return cell
    }
}



