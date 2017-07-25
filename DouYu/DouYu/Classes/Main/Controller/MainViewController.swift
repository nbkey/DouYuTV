//
//  MainViewController.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/21.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //为了适配iOS8只能用以下方式
        addChildVC(ChildViewControllerName: "Home")
        addChildVC(ChildViewControllerName: "Live")
        addChildVC(ChildViewControllerName: "Column")
        addChildVC(ChildViewControllerName: "User")
        
        //测试接口正常
//        NetworkTools.requestData(type: .GET, url: "https://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios") { (result) in
//            print(result)
//        }
    }
    
    func addChildVC(ChildViewControllerName:String) {
        //通过UIStoryboard获取控制器
        let chlidVc = UIStoryboard(name: ChildViewControllerName, bundle: nil).instantiateInitialViewController()!
        //忘tabbar里面添加控制器
        addChildViewController(chlidVc)
        
    }
}
