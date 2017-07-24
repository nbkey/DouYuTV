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
private let kSectionHeaderH : CGFloat = 50

private let kItemID = "normalID"
private let kSectionHeaderID = "sectionHeaderID"


class RecommendViewController: UIViewController {
    
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
        //随着父控件的拉伸进行伸缩
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kItemID)
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kItemID)
        //注册组头xib(错误崩溃)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
}

// MARK:-设置UI
extension RecommendViewController {
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
    }
}

// MARK:-UICollectionViewDataScoure
extension RecommendViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kItemID, for: indexPath)
        
//        cell.backgroundColor = UIColor.red
        return cell
    }
    //返回列表头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderID, for: indexPath)
        
        return headerView
    }
}




//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderID)
