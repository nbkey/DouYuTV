//
//  AnchorModel.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/25.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit


class AnchorModel: NSObject {
    
    var room_name: String = ""
    var vertical_src: String = ""
    var nickname: String = ""
    var anchor_city: String = ""

    var room_id: Int = 0
    var isVertical: Int = 0
    var online_num: Int = 0
    var online: Int = 0
//    var online: Int? {
//        //监听
//        didSet {
//            if online == 0 {
//                self.online = self.online_num
//            }
//        }
//    }
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}


/*
 接下来是room_list内部的详细房间信息
 room_id: Int 房间ID
 online: Int 在线人数
 room_name: String 房间名字
 vertical_src: 房间url资源
 isVertical: Int 0表示电脑直播, 1表示手机直播 bool类型
 nickname: String 主播名称
 
 anchor_city: String 来自城市
 online_num: Int 颜值在线人数
 */
