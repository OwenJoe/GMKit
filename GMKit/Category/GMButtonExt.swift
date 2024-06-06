//
//  GMButtonExt.swift
//  Gimmi
//
//  Created by hule on 2024/4/28.
//

import UIKit

extension UIButton {
    
    enum GradientDirection {
        case topToBottom //从上往下
        case leftToRight //从左往右
        case topLeftToBottomRight //从左上到右下
        case bottomLeftToTopRight //从左下到右上
        
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

    
    func applyGradient(startColor: UIColor, endColor: UIColor, startPoint: CGPoint, endPoint: CGPoint) {
        
        // 移除之前的渐变层,否则重复调用无效,效果依旧是保留之前的
        if let sublayers = layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        // 创建CAGradientLayer对象
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // 设置渐变色的起始颜色和结束颜色
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        // 设置渐变色的起始点和结束点
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // 将渐变色添加到按钮的layer中
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    

    func applyGradient(startColor: UIColor, endColor: UIColor, direction: GradientDirection) {
        
        // 移除之前的渐变层,否则重复调用无效,效果依旧是保留之前的
        if let sublayers = layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        // 创建CAGradientLayer对象
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // 设置渐变色的起始颜色和结束颜色
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        // 设置渐变色的起始点和结束点
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        
        // 将渐变色添加到按钮的layer中
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func applyGradient(startColor: UIColor, middleColor: UIColor, endColor: UIColor, direction: GradientDirection) {
        
        // 移除之前的渐变层,否则重复调用无效,效果依旧是保留之前的
        if let sublayers = layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        // 创建CAGradientLayer对象
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // 设置渐变色的起始颜色、中间颜色和结束颜色
        gradientLayer.colors = [startColor.cgColor, middleColor.cgColor, endColor.cgColor]
        
        // 设置渐变色的起始点和结束点
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        
        // 将渐变色添加到按钮的layer中
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    enum ButtonImagePosition {
        case left
        case right
        case top
        case bottom
    }

    func setImagePosition(position: ButtonImagePosition, spacing: CGFloat) {
        guard let image = self.imageView?.image, let title = self.titleLabel?.text else {
            return
        }
        
        self.titleEdgeInsets = UIEdgeInsets.zero
        self.imageEdgeInsets = UIEdgeInsets.zero
        
        let imageSize = image.size
        let titleSize = (title as NSString).size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font!])
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var titleEdgeInsets = UIEdgeInsets.zero
        
        switch position {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + spacing/2, bottom: 0, right: -(titleSize.width + spacing/2))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize.width + spacing/2), bottom: 0, right: imageSize.width + spacing/2)
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing/2), left: 0, bottom: 0, right: -titleSize.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing/2), right: 0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: titleSize.height + spacing/2, left: 0, bottom: 0, right: -titleSize.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: imageSize.height + spacing/2, right: 0)
        }
        
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
    }
       
       
}
