//
//  HomeViewController.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/21.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置界面
        setupUI()
        
    }
}

// MARK:-设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        //1.设置导航栏
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imaged: "logo")
        
        //2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyBtn = UIBarButtonItem(imaged: "image_my_history", highImageNamed: "Image_my_history_click", size: size)
        let searchBtn = UIBarButtonItem(imaged: "btn_search", highImageNamed: "btn_search_click", size: size)
        let qrcode = UIBarButtonItem(imaged: "Image_scan", highImageNamed: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyBtn, searchBtn, qrcode]
    }
    
}
