//
//  GMChatListTableView.swift
//  GMKit
//
//  Created by hule on 2024/6/14.
//

import UIKit

class GMChatListTableView: UITableView{


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTableGradientLayer()
    }
    
    //只有顶部有遮罩效果，配合transform列表翻转后跟着翻转
//    func setTableGradientLayer() {
//        // 创建渐变层
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor(white: 0, alpha: 0.05).cgColor,
//            UIColor(white: 0, alpha: 1.0).cgColor
//        ]
//        gradientLayer.locations = [0.0, 0.4] // 设置颜色的范围
//
//        // 根据视图的 transform 属性调整渐变层的起点和终点
//        if self.transform.isIdentity {
//            gradientLayer.startPoint = CGPoint(x: 0, y: 0) // 默认起点
//            gradientLayer.endPoint = CGPoint(x: 0, y: 0.30) // 默认终点
//        } else {
//            // 假设只有 y 轴翻转变换
//            gradientLayer.startPoint = CGPoint(x: 0, y: 1) // 翻转后的起点
//            gradientLayer.endPoint = CGPoint(x: 0, y: 0.70) // 翻转后的终点
//        }
//
//        gradientLayer.frame = self.bounds
//
//        // 将渐变层设置为视图的遮罩
//        self.layer.mask = gradientLayer
//    }

    //上下都有遮罩效果
    func setTableGradientLayer() {
        // 创建顶部渐变层
        let topGradientLayer = CAGradientLayer()
        topGradientLayer.colors = [
            UIColor(white: 0, alpha: 0.05).cgColor,
            UIColor(white: 0, alpha: 1.0).cgColor
        ]
        topGradientLayer.locations = [0.0, 0.4] // 设置颜色的范围
        topGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        topGradientLayer.endPoint = CGPoint(x: 0, y: 0.3)
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height / 2)

        // 创建底部渐变层
        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.colors = [
            UIColor(white: 0, alpha: 1.0).cgColor,
            UIColor(white: 0, alpha: 0.05).cgColor
        ]
        bottomGradientLayer.locations = [0.6, 1.0] // 设置颜色的范围
        bottomGradientLayer.startPoint = CGPoint(x: 0, y: 0.7)
        bottomGradientLayer.endPoint = CGPoint(x: 0, y: 1)
        bottomGradientLayer.frame = CGRect(x: 0, y: self.bounds.height / 2, width: self.bounds.width, height: self.bounds.height / 2)

        // 创建一个容器图层容纳所有渐变层
        let containerLayer = CALayer()
        containerLayer.frame = self.bounds
        containerLayer.addSublayer(topGradientLayer)
        containerLayer.addSublayer(bottomGradientLayer)

        // 将容器图层设置为视图的遮罩
        self.layer.mask = containerLayer
    }

}
