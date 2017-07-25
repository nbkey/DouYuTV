//
//  CollectionNormalCell.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/24.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    // MARK:-定义属性
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    // MARK:-定义模型
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
            
            //2.显示昵称
            nickNameLabel.text = anchor.room_name
            
            //3.主播名称
            anchorNameLabel.text = anchor.nickname
            //4.显示图片
            //设置图片
            let iconURL = URL(string: anchor.vertical_src)
            iconImageView.kf.setImage(with: iconURL)
        }
    }

}
