//
//  UIColor-Extension.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/22.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b/255.0, alpha: 1.0)
    }
}
