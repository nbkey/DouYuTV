//
//  AnchorGroup.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/25.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    var room_list : [[String: NSObject]]? {
        //属性监听
        didSet {
            guard let roomList = room_list else {return}
            for dict in roomList {
                let anchor = AnchorModel(dict: dict)
                anchors.append(anchor)
            }
        }

    }
    var icon_url : String = ""
    var small_icon_url : String = ""
    var tag_name : String = ""
    var tag_id : Int = 0
    var anchors:[AnchorModel] = [AnchorModel]()
    
    // MARK:-处理颜值特有的属性
    var cateInfo : [String: NSObject]? {
        //监听
        didSet {
            guard let level = cateInfo?["level"] as? Int  else {return}
            guard let name = cateInfo?["cate\(level)_name"] as? String else {return}
            guard let url = cateInfo?["icon_url"] as? String else {return}
            self.tag_name = name
            self.icon_url = url
        }
    }
    
    var list : [[String: NSObject]]? {
        //属性监听
        didSet {
            guard let roomList = list else {return}
            self.room_list = roomList
        }
    }
    
    // MARK:-构造函数
    init(dict:[String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        super.init()
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    //将我们的roomList内的元素转化成AnchorModel对象
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//              guard let dataArray = value as? [[String: NSObject]] else {return}
//              for dict in dataArray {
//              let anchor = AnchorModel(dict: dict)
//              anchors.append(anchor)
//    }
//        }
//    }
}
/*
 room_list: [[String: NSObject]] 房间信息
 icon_url: String游戏图标
 small_icon_url: String 左上角小图标
 tag_name: String 游戏名称
 tag_id: Int 游戏ID
 */
