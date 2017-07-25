//
//  CollectionPrettyCell.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/25
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    
    @IBOutlet weak var cityButton: UIButton!
    override var anchor :AnchorModel? {
        didSet {
            //1.通知父类
            super.anchor = anchor
            //3.显示所在城市
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
