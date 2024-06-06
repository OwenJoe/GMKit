//
//  GMTextViewExt.swift
//  Gimme
//
//  Created by hule on 2024/6/4.
//

import UIKit

// 定义一个全局变量，用于关联对象的键
private var paddingKey: UInt8 = 0

// 扩展 UITextView 类
extension UITextView {
    
    // 定义一个 padding 属性，类型为 UIEdgeInsets
    var padding: UIEdgeInsets {
        // getter 方法
        get {
            // 使用 objc_getAssociatedObject 获取关联对象
            if let value = objc_getAssociatedObject(self, &paddingKey) as? NSValue {
                return value.uiEdgeInsetsValue // 如果存在关联对象，返回其值
            }
            return .zero // 如果没有设置关联对象，返回默认的 .zero
        }
        // setter 方法
        set {
            // 使用 objc_setAssociatedObject 设置关联对象
            objc_setAssociatedObject(self, &paddingKey, NSValue(uiEdgeInsets: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            textContainerInset = newValue // 设置 textContainerInset 为新的内边距
            textContainer.lineFragmentPadding = 0 // 将 lineFragmentPadding 设置为 0
        }
    }
    
    // 添加一个 applyPadding 方法，用于方便设置 padding
    func applyPadding(_ padding: UIEdgeInsets) {
        self.padding = padding // 调用 padding 的 setter 方法
    }
}
