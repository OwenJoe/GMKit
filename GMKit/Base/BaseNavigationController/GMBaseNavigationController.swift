//
//  GMBaseNavigationController.swift
//  Gimmi
//
//  Created by hule on 2024/4/25.
//

import UIKit



class GMBaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.configuration.isEnabled = true

    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        
        // 获取当前顶层视图控制器
        guard let topViewController = self.topViewController else {
            return nil
        }
        
        // 检查是否是 GMLoginController
        if topViewController is GMLoginController {
            // 如果未登录状态, 默认返回到首页
            if let loginStatus = GMStorageManager.shared.getData(forkey: LoginSucessKey) as? Int, loginStatus == 1 {
                return super.popViewController(animated: animated)
            } else {
                // 获取上一个视图控制器
                let previousViewController = getPreviousViewController() ?? GMBaseViewController()
                if !isRootViewController(previousViewController) {
                    // 如果当前视图控制器不是四个根视图控制器之一，执行 pop
                    return super.popViewController(animated: animated)
                } else {
                    returnToHome()
                    return nil
                }
            }
        } else {
            return super.popViewController(animated: animated)
        }
    }

    // 重写push方法，自定义返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }


    // 获取上一个视图控制器
    private func getPreviousViewController() -> UIViewController? {
        let count = viewControllers.count
        if count > 1 {
            return viewControllers[count - 2]
        }
        return nil
    }
    
    // 判断是否是四个根视图控制器之一
    private func isRootViewController(_ viewController: UIViewController) -> Bool {
        return
               viewController is GMMessageController ||
               viewController is GMMineController ||
               viewController is GMLoginController ||
               viewController is GMDetailsController

    }

    // 返回到首页
    private func returnToHome() {
        if let tabBar = self.tabBarController as? GMTabBarController {
            tabBar.selectedIndex = 0
        }
    }

}


