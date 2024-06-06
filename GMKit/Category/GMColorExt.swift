//
//  GMUIColorExt.swift
//  Gimme
//
//  Created by hule on 2024/5/29.
//

import UIKit

extension UIColor {
    
    enum GradientDirection {
        case topToBottom // 从上往下
        case leftToRight // 从左往右
        case topLeftToBottomRight // 从左上到右下
        case bottomLeftToTopRight // 从左下到右上
        
        var startPoint: CGPoint {
            switch self {
            case .topToBottom:
                return CGPoint(x: 0.5, y: 0.0)
            case .leftToRight:
                return CGPoint(x: 0.0, y: 0.5)
            case .topLeftToBottomRight:
                return CGPoint(x: 0.0, y: 0.0)
            case .bottomLeftToTopRight:
                return CGPoint(x: 0.0, y: 1.0)
            }
        }
        
        var endPoint: CGPoint {
            switch self {
            case .topToBottom:
                return CGPoint(x: 0.5, y: 1.0)
            case .leftToRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .topLeftToBottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            case .bottomLeftToTopRight:
                return CGPoint(x: 1.0, y: 0.0)
            }
        }
    }

    static func applyGradient(to view: UIView, startColor: UIColor, middleColor: UIColor? = nil, endColor: UIColor, direction: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        if let middleColor = middleColor {
            gradientLayer.colors = [startColor.cgColor, middleColor.cgColor, endColor.cgColor]
            gradientLayer.locations = [0.0, 0.5, 1.0] // 分布颜色的位置
        } else {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
