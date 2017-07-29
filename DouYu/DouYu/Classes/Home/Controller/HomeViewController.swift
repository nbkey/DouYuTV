//
//  HomeViewController.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/21.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:-懒加载
    fileprivate lazy var pageTitleView :PageTitleView = {[weak self] in
        let frame = CGRect(x: 0, y: kNavigationH, width: kScreenWidth, height:  kTitleViewH)
        let titles = ["推荐", "手游","娱乐", "游戏", "趣玩"]
        let pageTitleView = PageTitleView(frame: frame, titles: titles)
        pageTitleView.delegate = self
        
        return pageTitleView
    }()
    
    fileprivate lazy var pageContentView :PageContentView = {[weak self] in
        //1.确定frame
        let contentH = kScreenHight - kNavigationH - kTitleViewH - kTabBarH
        let frame = CGRect(x: 0, y: kNavigationH + kTitleViewH, width: kScreenWidth, height: contentH)
        //2.确定子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        let pageContentView = PageContentView(frame: frame, childViewControllers: childVCs, parentViewController: self)
        pageContentView.delegate = self
        
        return pageContentView
    }()
    
    override func viewDidLoad() {
        // MARK:-系统回调函数
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        //设置界面
        setupUI()
    }
}

// MARK:-设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        //0.scrollview内边距不需要自动设置
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setNavigationBar()
        //2.添加titleview
        view.addSubview(pageTitleView)
        //3.添加contentVIew
        view.addSubview(pageContentView)
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imaged: "logo")
        setActionWithNavigationItem(barButtonItem: navigationItem.leftBarButtonItem, action: #selector(leftBarButtonClick))

        //2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyBtn = UIBarButtonItem(imaged: "image_my_history", highImageNamed: "Image_my_history_click", size: size)
        setActionWithNavigationItem(barButtonItem: historyBtn, action: #selector(historyBtnClick))
        let searchBtn = UIBarButtonItem(imaged: "btn_search", highImageNamed: "btn_search_click", size: size)
        setActionWithNavigationItem(barButtonItem: searchBtn, action: #selector(searchBtnClick))
        let qrcodeBtn = UIBarButtonItem(imaged: "Image_scan", highImageNamed: "Image_scan_click", size: size)
        setActionWithNavigationItem(barButtonItem: qrcodeBtn, action: #selector(qrcodeBtnClick))
        navigationItem.rightBarButtonItems = [historyBtn, searchBtn, qrcodeBtn]
    }
}


// MARK:-导航栏按钮点击事件
extension HomeViewController {
    @objc fileprivate func leftBarButtonClick() {
        print("测试首页导航栏左侧点击事件")
    }
    
    @objc fileprivate func historyBtnClick() {
        print("测试首页导航栏观看历史点击事件")
    }
    
    @objc fileprivate func searchBtnClick() {
        print("测试首页导航栏搜索点击事件")
    }
    
    @objc fileprivate func qrcodeBtnClick() {
        print("测试首页导航栏查二维码扫描点击事件")
    }
    
    
    fileprivate func setActionWithNavigationItem(barButtonItem: UIBarButtonItem?, action: Selector) {
        //因为customView是uiview, 所以需要可选类型保护
        guard let button = barButtonItem?.customView as? UIButton else {
            return
        }
        button.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
    }
}

// MARK:-PageTitleViewDelegate
extension HomeViewController:PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, index: Int) {
        print(index)
        pageContentView.setCurrentIndex(index)
    }
}

// MARK:-PageContentViewDelegate
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(progress: CGFloat, scoureIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, scoureIndex: scoureIndex, targetIndex: targetIndex)
    }
}
