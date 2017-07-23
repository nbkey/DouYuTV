//
//  PageContentView.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/22.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

private let ContentCellID : String = "ContentCellID"
protocol PageContentViewDelegate : class {
    func pageContentView(progress:CGFloat, scoureIndex:Int, targetIndex:Int)
}

class PageContentView: UIView {
    //定义属性
    fileprivate var childVCs:[UIViewController]
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidSrollDelegate : Bool = false
    //因为构造函数传入的self, 这样会造成循环引用
    fileprivate weak var parentViewController:UIViewController?
    weak var delegate:PageContentViewDelegate?
   
    
    //懒加载
    fileprivate lazy var pageCollectionView: UICollectionView = {[weak self] in
        
        //1.创建layout
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
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
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    
    // MARK:-自定义构造函数
    init(frame: CGRect, childViewControllers:[UIViewController], parentViewController:UIViewController?) {
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
    fileprivate func setUI() {
        
        //1.将所有控制器添加到父控制器中
        for childVC in childVCs {
            parentViewController?.addChildViewController(childVC)
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

// MARK:-UICollectionView 的Delegate协议
extension PageContentView: UICollectionViewDelegate {
    
    //开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        isForbidSrollDelegate = false
    }
    
    //检测滚动, 获取数据
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件,防止循环相互调用崩溃
        if isForbidSrollDelegate {return}
        
        //1.定义需要的数据源
        var progress: CGFloat = 0
        //之前的
        var scoureIndex: Int = 0
        //目标的index
        var targerIndex: Int = 0
        
        //2.判断是左滑还是右滑
        let contentOffSet = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if contentOffSet > startOffsetX {
            //x大于之前的证明, 手指左滑
            //计算progress
            progress = contentOffSet / scrollViewW - floor(contentOffSet / scrollViewW)
            //计算currentIndex
            scoureIndex = Int(contentOffSet / scrollViewW)
            //计算taggetIndex
            targerIndex = scoureIndex + 1
            if targerIndex >= childVCs.count {
                targerIndex = childVCs.count - 1
            }
            //如果完全划过去
            if contentOffSet - startOffsetX == scrollViewW {
                progress = 1
                targerIndex = scoureIndex
            }
            
        } else { //手指右滑
            //计算progress
            progress = 1 - (contentOffSet / scrollViewW - floor(contentOffSet / scrollViewW))
            //计算taggetIndex
            targerIndex = Int(contentOffSet / scrollViewW)
            //计算currentIndex
            scoureIndex = targerIndex + 1
            if scoureIndex >= childVCs.count {
                scoureIndex = childVCs.count - 1
            }
            if startOffsetX - contentOffSet == scrollViewW {
                progress = 1
                scoureIndex = targerIndex
            }
        }
        
        //3.将我们的参数传递出去
//        print("progress\(progress), scoureIndex\(scoureIndex), targetIndex\(targerIndex)")
        delegate?.pageContentView(progress: progress, scoureIndex: scoureIndex, targetIndex: targerIndex)
    }
}

// MARK:-对外暴露的函数
extension PageContentView {
    func setCurrentIndex(_ index: Int)  {
        isForbidSrollDelegate = true
        let offsetX = CGFloat(index) * pageCollectionView.frame.width
        pageCollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}


