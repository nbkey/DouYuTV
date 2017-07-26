//
//  CollectionHeaderView.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/24.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    // MARK:-定义属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:-Group
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            let icon : String = group?.small_icon_url ?? "home_header_hot"
            //设置图片
            if icon != "" && icon != "home_header_hot" {
                iconImageView.kf.setImage(with: URL(string: icon))
            } else {
                iconImageView.image = UIImage(named: "home_header_hot")
            }
        }
    }
    
}
