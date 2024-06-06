//
//  GMNavigationExt.swift
//  Gimme
//
//  Created by hule on 2024/6/4.
//

import UIKit

extension UINavigationController {
    
    /// Push一个新的视图控制器，并移除中间所有的视图控制器
    /// - Parameters:
    ///   - viewController: 需要Push的视图控制器
    ///   - animated: 是否需要动画效果
    func pushAndRemoveAllPrevious(viewController: UIViewController, animated: Bool) {
        // 获取当前导航堆栈中的所有视图控制器
        var viewControllers = self.viewControllers
        
        // 将新的视图控制器添加到堆栈的末尾
        viewControllers.append(viewController)
        
        // 只保留第一个和最后一个视图控制器
        viewControllers = [viewControllers.first!, viewControllers.last!]
        
        // 设置新的视图控制器堆栈
        self.setViewControllers(viewControllers, animated: animated)
    }
    

}
