//
//  NSDate-Extension.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/25.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
