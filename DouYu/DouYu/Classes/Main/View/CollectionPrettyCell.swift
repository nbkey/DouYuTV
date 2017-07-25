//
//  CollectionPrettyCell.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/25
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    var anchor :AnchorModel? {
        didSet {
            //0.校验模型是否有值
            guard let anchor = anchor else {return}
            //1.取出在线人数显示的文字
            let numberOnline = anchor.online_num > anchor.online ? anchor.online_num : anchor.online
            var onlineStr : String = ""
            if numberOnline >= 10000 {
                onlineStr = "\(Int(numberOnline / 10000))万在线"
            } else {
                onlineStr = "\(numberOnline)在线"
            }
            onlineButton.setTitle(onlineStr, for: .normal)
            
            //2.房间名字
            nickNameLabel.text = anchor.nickname
            
            //3.显示所在城市
            cityButton.setTitle(anchor.anchor_city, for: .normal)
            
            //4.显示图片
            //设置图片
            let iconURL = URL(string: anchor.vertical_src)
            iconImageView.kf.setImage(with: iconURL)
        }
    }

}
