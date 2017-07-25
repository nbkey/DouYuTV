//
//  NetworkTools.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/25.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit
import Alamofire

enum HttpType {
    case GET
    case Post
}

class NetworkTools {

    class func requestData(type:HttpType, url:String, parameter:[String: NSString]? = nil, finishCallback:@escaping (_ result:Any)->()) {
        //1.获取请求类型
        let typee = type == .GET ? HTTPMethod.get : HTTPMethod.post
        //2.请求数据
        Alamofire.request(url, method: typee, parameters: parameter).responseJSON() { (response) in
            //3.回调数据
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            finishCallback(result)
        }
    }
}

//首页三个接口均为GET(推荐界面)
//https://capi.douyucdn.cn/api/v1/slide/6?version=2.521&client_sys=ios 轮播图的接口
//https://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios 最热接口
//https://apiv2.douyucdn.cn/live/home/custom?client_sys=ios  颜值,王者荣耀, 移动游戏
//https://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1500951060&auth=0e6f4b29864472464216b6b4d2fec87d 英雄联盟以及最下面的

//手游界面接口
//https://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=3e760da75be261a588c74c4830632360&client_sys=ios
//娱乐界面接口
//https://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=9acf9c6f117a4c2d02de30294ec29da9&client_sys=ios

//游戏界面接口
//https://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=ba08216f13dd1742157412386eee1225&client_sys=ios

//趣玩界面
//https://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=393b245e8046605f6f881d415949494c&client_sys=ios

//首页粉丝狂欢节活动界面
//https://mconf.douyucdn.cn/resource/common/activity/fans_m.json


//各种礼物GIF图之类的接口
//https://capi.douyucdn.cn/api/v1/station_effect?client_sys=ios
//https://capi.douyucdn.cn/wb_share/config?client_sys=ios 赛艇起航了之类的



//王者荣耀, 汽车, 守望先锋...18个元素
//https://apiv2.douyucdn.cn/video/ShortVideo/getCateTags?client_sys=ios
