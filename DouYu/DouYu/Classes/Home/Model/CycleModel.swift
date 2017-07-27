//
//  CycleModel.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/27.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var title:String = ""
    var pic_url:String = ""
    var room:[String: NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            self.anchor = AnchorModel(dict: room)
        }
    }
    var anchor:AnchorModel?
    
    init(dict:[String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
}

/*
    id:Int 未知参数意义
    title:String 轮播图名字
    pic_url:String 轮播图名字(长方形->在手机端使用展示比较好)
    tv_pic_url:String 轮播图名字(接近于正方形)
    room:[String: NSObject] 主播房间信息, 用转化为anchorModel对象即可
 */
