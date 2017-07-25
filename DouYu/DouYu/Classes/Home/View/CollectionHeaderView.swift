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
            iconImageView.image = UIImage(named: group?.small_icon_url ?? "home_header_normal")
        }
    }
    
}
