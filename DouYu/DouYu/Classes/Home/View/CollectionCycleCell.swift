//
//  CollectionCycleCell.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/27.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconUrl)
        }
    }

}
