//
//  CollectionItemCell.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/29.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class CollectionItemCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!
    
    var index :Int? {
        didSet {
            guard let index = index  else {return}
            // Initialization code
            iconImageView.image = UIImage(named: iconImageNames[index])
            //homeNewItem_Activity homeNewItem_allLive homeNewItem_msg homeNewItem_rankingList
            titileLabel.text = titleNames[index]
        }
    }
    private lazy var iconImageNames :[String] = {
        let iconImageNames = ["homeNewItem_rankingList", "homeNewItem_msg", "homeNewItem_Activity", "homeNewItem_allLive"]
        return iconImageNames
    }()
    var titleNames :[String] = {
        return ["排行榜", "消息", "活动", "全部直播"]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
