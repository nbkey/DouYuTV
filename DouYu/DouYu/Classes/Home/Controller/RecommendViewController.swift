//
//  RecommendViewController.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/23.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
private let kItemH : CGFloat = kItemW / 4 * 3
private let kItemPrettyH : CGFloat = kItemW / 3 * 4
private let kSectionHeaderH : CGFloat = 50
private let kCycleViewH : CGFloat = kScreenWidth / 8 * 3

private let kItemID = "normalID"
private let kItemPrettyID = "kItemPrettyID"
private let kSectionHeaderID = "sectionHeaderID"


class RecommendViewController: UIViewController {
    //懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.creatRecommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenWidth, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let frame = CGRect.zero
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //设置组的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        //设置组头
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kSectionHeaderH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        // MARK:-设置内边距, 可以让其显示cycleView (很重要, 不好找bug)
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH, 0, 0, 0)
        //随着父控件的拉伸进行伸缩
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kItemID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kItemID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kItemPrettyID)
        //注册组头xib(错误崩溃)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
    }
}

// MARK:-设置UI
extension RecommendViewController {
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
    }
}

// MARK:-UICollectionViewDataScoure
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        var cell = CollectionBaseCell()
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kItemPrettyID, for: indexPath) as! CollectionPrettyCell
            
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kItemID, for: indexPath) as! CollectionNormalCell

        }
        cell.anchor = anchor
        return cell
    }
    //返回列表头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1.取出表头
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderID, for: indexPath) as! CollectionHeaderView
        //2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kItemPrettyH)
        }
        
        return CGSize(width: kItemW, height: kItemH)
    }
    
}




//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderID)
