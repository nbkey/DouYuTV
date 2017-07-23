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
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = PageTitleView(frame: frame, titles: titles)
        pageTitleView.delegate = self
        
        return pageTitleView
    }()
    
    fileprivate lazy var pageContentView :PageContentView = {[weak self] in
        //1.确定frame
        let contentH = kScreenHight - kNavigationH - kTitleViewH
        let frame = CGRect(x: 0, y: kNavigationH + kTitleViewH, width: kScreenWidth, height: contentH)
        //2.确定子控制器
        var childVCs = [UIViewController]()
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
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"logo"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(aaa))
        
        //2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyBtn = UIBarButtonItem(imaged: "image_my_history", highImageNamed: "Image_my_history_click", size: size)
        let searchBtn = UIBarButtonItem(imaged: "btn_search", highImageNamed: "btn_search_click", size: size)
        let qrcode = UIBarButtonItem(imaged: "Image_scan", highImageNamed: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyBtn, searchBtn, qrcode]
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
