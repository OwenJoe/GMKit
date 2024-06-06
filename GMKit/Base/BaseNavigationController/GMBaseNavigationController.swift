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
        
        // 1. 导航栏透明效果
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        self.delegate = self
        // 设置默认的导航栏样式
        navigationBar.barTintColor = HexString("#101123")  //导航栏背景颜色
        navigationBar.tintColor = .white // 设置为白色，以确保返回按钮图片为白色
        
        // 设置导航栏标题颜色
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // 注意`setNavigationBarHidden:YES`设置这行代码后会导致Nav的滑动返回手势失效，
        
        
    }
    
    
    
    // 重写push方法，自定义返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            //隐藏底部tabBar
            // 创建自定义的返回按钮，文字颜色为黑色
            //               let backButton = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
            //               backButton.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            //      viewController.navigationItem.backBarButtonItem = backButton
            
            // 添加侧滑返回手势识别器
            let backSwipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipeFromEdge(_:)))
            backSwipeGesture.edges = .left
            viewController.view.addGestureRecognizer(backSwipeGesture)
            
            // 自定义左侧按钮，图片为白色
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(backButtonTapped))
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func handleSwipeFromEdge(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .ended {
            // 执行返回操作
//            popViewController(animated: true)
              backButtonTapped()
        }
        
    }
    
    //返回事件
    @objc func backButtonTapped() {
        // 获取当前顶层视图控制器
        guard let topViewController = self.topViewController else {
            return
        }
        
        // 检查是否是 GMLoginController
        if topViewController is GMLoginController {
            // 如果未登录状态, 默认返回到首页
            if let loginStatus = GMStorageManager.shared.getData(forkey: LoginSucessKey) as? Int, loginStatus == 1 {
                popViewController(animated: true)
            } else {
                // 获取上一个视图控制器
                let previousViewController = getPreviousViewController() ?? GMBaseViewController()
                if !isRootViewController(previousViewController) {
                    // 如果当前视图控制器不是四个根视图控制器之一，执行 pop
                    popViewController(animated: true)
                }
                else{
                    returnToHome()
                }
               
            }
        } else {
            
        }
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
        return viewController is GMMineController ||
               viewController is GMLoginController
    

    }

    // 返回到首页
    private func returnToHome() {
        if let tabBar = self.tabBarController as? GMTabBarController {
            tabBar.selectedIndex = 0
        }
    }
    
    
    
    // 外部调用的方法，用于设置自定义的titleView
    func setCustomTitleView(_ titleView: UIView) {
        navigationItem.titleView = titleView
    }
    
    // 外部调用的属性，用于控制是否隐藏导航栏返回按钮
    var shouldHideBackButton: Bool = false {
        didSet {
            // 更新所有子视图控制器的返回按钮可见性
            for viewController in viewControllers {
                if #available(iOS 16.0, *) {
                    viewController.navigationItem.backBarButtonItem?.isHidden = shouldHideBackButton
                } else {
                    // 对于iOS 15及以下版本，设置一个透明的UIBarButtonItem
                    let transparentButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    viewController.navigationItem.backBarButtonItem = transparentButton
                }
            }
        }
    }
}


