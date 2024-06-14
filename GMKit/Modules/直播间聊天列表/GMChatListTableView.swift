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

    func setTableGradientLayer() {
        // 创建渐变层
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(white: 0, alpha: 0.05).cgColor,
            UIColor(white: 0, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 0.4] // 设置颜色的范围
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // 设置颜色渐变的起点
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.30) // 设置颜色渐变的终点，与 startPoint 形成一个颜色渐变方向
        gradientLayer.frame = self.bounds
        
        // 将渐变层设置为视图的遮罩
        self.layer.mask = gradientLayer
    }

}
