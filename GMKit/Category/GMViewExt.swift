//
//  UIViewExt.swift
//  Gimme
//
//  Created by hule on 2024/5/28.
//

import UIKit

extension UIView {
    
    //空数据 图片+文字
    func noDataView(frame:CGRect, action:@escaping () -> Void) -> UIView {
        
        let bgView = UIView(frame: frame)
        bgView.frame = frame
        bgView.addTapGesture {
            action()
        }
//        
        let iconView = UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.width))
        iconView.image = UIImage(named: "noData")
        bgView.addSubview(iconView)
        
        
        let label = UILabel(frame: CGRectMake(0, frame.size.height - 20, frame.size.width, 20))
        label.text = "nothing in the world"
        label.textAlignment = .center
        label.textColor = .white
        bgView.addSubview(label)
        

        
        return bgView
    }
}
