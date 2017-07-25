//
//  PageTitleView.swift
//  DouYu
//
//  Created by 吉冠坤 on 2017/7/22.
//  Copyright © 2017年 吉冠坤. All rights reserved.
//

import UIKit

// MARK:-协议
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView:PageTitleView, index:Int)
}
// MARK:-常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageTitleView: UIView {
    // MARK:-定义属性
    fileprivate var titles = [String]()
    fileprivate var currentIndex = 0
    weak var delegate:PageTitleViewDelegate?
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

// MARK:-设置UI
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            
            //4.添加label到scrollview中
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelCilck(tapRes:)));
            label.addGestureRecognizer(tapGes)
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

// MARK:-监听label事件
extension PageTitleView {
    @objc fileprivate func titleLabelCilck(tapRes: UITapGestureRecognizer)  {
        
        //1.获取当前label
        guard let currentLabel = tapRes.view as? UILabel else {return}
        //0.如果是重复点击
        if currentIndex == currentLabel.tag {return}
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        //3.切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4.滚动条位置发生变化
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        currentIndex = currentLabel.tag
        //5.通知代理
        delegate?.pageTitleView(titleView: self, index: currentIndex)
    }
}

// MARK:-对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress:CGFloat, scoureIndex:Int, targetIndex:Int) {
        //1.取出对应的label
        let scoureLabel = titleLabels[scoureIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块儿的逻辑
        let moveX = (targetLabel.frame.origin.x - scoureLabel.frame.origin.x) * progress
        scrollLine.frame.origin.x = scoureLabel.frame.origin.x + moveX
        
        //3.颜色的渐变
        //3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        //3.2 变化scoureLabel
        scoureLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        //3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        //4.记录最新的index
        currentIndex = targetIndex
    }
}
