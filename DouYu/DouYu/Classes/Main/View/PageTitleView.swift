//
//  PageTitleView.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/22.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    // MARK:-定义属性
    fileprivate var titles = [String]()
    //懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        
        return scrollView;
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame:frame)
        setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageTitleView {
    
    fileprivate func setUI() {
        //1.添加scrollview
        scrollView.frame = bounds
        addSubview(scrollView)
        //2.设置标题
        setupTitleLabels()
        //3.设置底线和滚动的滑块儿
        setupBottomMenuAndScrollLine()
    }

    private func setupTitleLabels() {
        let labelW : CGFloat = kScreenWidth / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建label
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize:16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            
            //4.添加label到scrollview中
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomMenuAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineHieght : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: CGFloat(frame.height - kScrollLineH) , width: CGFloat(frame.width), height: lineHieght)
        addSubview(bottomLine)
        
        
        
        //2.添加scrollviewLine
        scrollView.addSubview(scrollLine)
        //2.1 获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        //2.2设置scrollview属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
}
