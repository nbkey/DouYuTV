//
//  UIBarButtonItem-Extension.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/21.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import Foundation
import UIKit

//对系统类做扩展
extension UIBarButtonItem {
    /*
    class func creatItem (imaged:String, highImageNamed: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named:imaged), for: .normal)
        btn.setImage(UIImage(named:highImageNamed), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
 */
    
    //扩充构造函数(便利构造函数)
    //1>convenience开头
    //2>在构造函数中必须明确的调用一个设计的构造函数(self), 赋初始化的值可以被选择
    convenience init(imaged:String, highImageNamed: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imaged), for: .normal)
        if highImageNamed != "" {
            btn.setImage(UIImage(named:highImageNamed), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
        
}
