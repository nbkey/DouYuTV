//
//  CollectionNormalCell.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/24.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    // MARK:-定义属性
    @IBOutlet weak var nickNameLabel: UILabel!

    // MARK:-定义模型
    override var anchor :AnchorModel? {
        didSet {
            //1.传递值给父类
            super.anchor = anchor
            //2.显示昵称
            nickNameLabel.text = anchor?.room_name
        }
    }
}
