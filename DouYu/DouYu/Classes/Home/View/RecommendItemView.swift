//
//  RecommendItemView.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/28.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

private let kItemCellID = "kItemCellID"
private let kItemWidth = kScreenWidth / 4

class RecommendItemView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    var cycleModels :[CycleModel]? {
        didSet {
            //为了让视图同时刷新
            collectionView.dataSource = self
            //1.刷新表格
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kItemCellID)
        collectionView.register(UINib(nibName: "CollectionItemCell", bundle: nil), forCellWithReuseIdentifier: kItemCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //1.拿到layout(强转为UICollectionViewFlowLayout才可以进行item设置)itemSize不能通过xib设置
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kItemWidth, height: kItemWidth)
        //以下这些属性可以在xib中用keypath通过KVC设置
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }

}

// MARK:-扩展类的便利构造器
extension RecommendItemView {
    class func creatRecommendItemView()->RecommendItemView {
        let itemView = Bundle.main.loadNibNamed("RecommendItemView", owner: nil, options: nil)?.first as! RecommendItemView
        return itemView
    }
}

// MARK:-datascoure
extension RecommendItemView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kItemCellID, for: indexPath) as! CollectionItemCell
        cell.index = indexPath.item
        
        return cell
    }
}
