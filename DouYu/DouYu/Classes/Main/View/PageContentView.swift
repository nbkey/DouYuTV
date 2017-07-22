//
//  PageContentView.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/22.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

private let ContentCellID : String = "ContentCellID"

class PageContentView: UIView {
    //定义属性
    fileprivate var childVCs:[UIViewController]
    fileprivate var parentViewController:UIViewController
    
    //懒加载
    fileprivate lazy var pageCollectionView: UICollectionView = {
        
        //1.创建layout
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        //行间距
        layout.minimumLineSpacing = 0
        //item间距
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        //不超出内容滚动区域
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    
    // MARK:-自定义构造函数
    init(frame: CGRect, childViewControllers:[UIViewController], parentViewController:UIViewController) {
        self.childVCs = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:-设置UI
extension PageContentView {
    func setUI() {
        
        //1.将所有控制器添加到父控制器中
        for childVC in childVCs {
            childVCs.append(childVC)
        }
        //2.添加UICollectView, 用于在item中存放控制器的View
        addSubview(pageCollectionView)
        pageCollectionView.frame = bounds
    }
}


// MARK:-UICollectionView 的DataScoure协议
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //2.给cell设置内容
        let childvc = childVCs[indexPath.item]
        childvc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childvc.view)
        
        return cell
    }
}


