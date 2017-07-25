//
//  RecommendViewModel.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/25.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

private let kUrlLOL : String = "https://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1500951060&auth=0e6f4b29864472464216b6b4d2fec87d"
private let kUrlPretty: String = "https://apiv2.douyucdn.cn/live/home/custom?client_sys=ios"
private let kUrlHot: String = "https://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios"

//如果用不到NSObject的一些特性, 比如KVC之类的, 就不用继承, 类更加的干净
class RecommendViewModel {
    var anchorGroups :[AnchorGroup] = [AnchorGroup]()
    fileprivate var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate var prettyGroups :[AnchorGroup] = [AnchorGroup]()
}

// MARK:-发送网络请求数据
extension RecommendViewModel {
    func requestData(finishCallback: @escaping ()->()) {
        //首页接口分为三个 热门, 颜值(有三组), 英雄联盟三个接口
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        //1>请求热门
        //1.1 请求之前进入组
        NetworkTools.requestData(type: .GET, url: kUrlHot) { (result) in
            //1.将结果转成字典类型
            guard let resultDict = result as? [String: NSObject] else {return}
            //2.通过data这个key获取到对应的数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {return}
            //3.将数组转化为模型
            //3.1设置组的属性
            self.bigDataGroup = AnchorGroup()
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.small_icon_url = "home_header_hot"
            for dict in dataArray {
                let anchor = AnchorModel.init(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            print("1加载完毕")
            //4.请求之后离开组
            dispatchGroup.leave()
        }
        
        //2>请求颜值接口
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, url: kUrlPretty) { (result) in
            //1.将结果转成字典类型
            guard let resultDict = result as? [String: NSObject] else {return}
            //2.通过data这个key获取到对应的数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {return}
            //3.将数组转化为模型
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.prettyGroups.append(group)
                print(group.tag_name)
            }
             print("2加载完毕")
            //4>离开组
            dispatchGroup.leave()
        }
        
        //3>请求英雄联盟接口
         dispatchGroup.enter()
         NetworkTools.requestData(type: .GET, url: kUrlLOL) { (result) in
            //1.将结果转成字典类型
            guard let resultDict = result as? [String: NSObject] else {return}
            //2.通过data这个key获取到对应的数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {return}
            //3.将数组转化为模型
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
                print(group.tag_name)
            }
             print("3加载完毕")
            //4>离开组
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: DispatchQueue.main, execute: { 
            print("全部加载完毕")
            //[mArr insertObjects:arr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(指定index, arr1.count)]];
            //排序
            self.prettyGroups += self.anchorGroups
            self.anchorGroups = self.prettyGroups
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        })
    }
}

//https://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1500951060&auth=0e6f4b29864472464216b6b4d2fec87d 英雄联盟以及最下面的
/*
    room_list: [[String: NSObject]] 房间信息
    icon_url: String游戏图标
    small_icon_url: String 左上角小图标
    tag_name: String 游戏名称
    tag_id: Int 游戏ID
 
    接下来是room_list内部的详细房间信息
    room_id: Int 房间ID
    online: Int 在线人数
    room_name: String 房间名字
    vertical_src: 房间url资源
    isVertical: Int 0表示电脑直播, 1表示手机直播 bool类型
    nickname: String 主播名称
 */



//https://apiv2.douyucdn.cn/live/home/custom?client_sys=ios 颜值以及下面的三个
/*
 获取到data是一个数组, 包含三个字典, 每个字典的对象如下
 
 cateInfo: [string: NSObject] 信息
 list: [[string: NSObject]] 房间列表,count = 4
 
 cateInfo内部
 cate2_name : String 分组名字
 icon_url : String 图标资源
 
 接下来是list内部的分为四组一般详细房间信息
 room_id: Int 房间ID
 online: Int 在线人数
 room_name: String 房间名字
 vertical_src: 房间url资源
 isVertical: Int 0表示电脑直播, 1表示手机直播 bool类型
 nickname: String 主播名称
 anchor_city: String 来自城市
 online_num: Int 在线人数
 
 */

