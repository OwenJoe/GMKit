//
//  GMTabBarController.swift
//  Gimmi
//
//  Created by hule on 2024/4/24.
//

import UIKit


class GMTabBarController: UITabBarController , UITabBarControllerDelegate{


    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.viewControllers = setupViewControllers()
        
        // 使用自定义的 TabBar
        let customTabBar = GMTabBar()
        customTabBar.tintColor = UIColor.white
        customTabBar.barTintColor = UIColor.clear // 设置背景色为透明色,否则图片圆角效果将会出现白色
        self.setValue(customTabBar, forKey: "tabBar")

    }
    
    //切换到首页
     func backTabBarHome()  {
        
       self.tabBarController?.selectedIndex = 0
    }
    
    
    //加载控制器
    func setupViewControllers() -> [UINavigationController] {
        let home = GMBaseNavigationController(rootViewController: GMHomeController())
        home.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "home_normal"), selectedImage: UIImage(named: "home_highlight")?.withRenderingMode(.alwaysOriginal))
        let details = GMBaseNavigationController(rootViewController: GMDetailsController())
        details.tabBarItem = UITabBarItem(title: "方案", image: UIImage(named: "hot_normal"), selectedImage: UIImage(named: "hot_highlight")?.withRenderingMode(.alwaysOriginal))
        let message = GMBaseNavigationController(rootViewController: GMMessageController())
        message.tabBarItem = UITabBarItem(title: "聊天", image: UIImage(named: "mycity_normal"), selectedImage: UIImage(named: "mycity_highlight")?.withRenderingMode(.alwaysOriginal))
        let mine = GMBaseNavigationController(rootViewController: GMMineController())
        mine.tabBarItem = UITabBarItem(title: "设置", image: UIImage(named: "message_normal"), selectedImage: UIImage(named: "message_highlight")?.withRenderingMode(.alwaysOriginal))
        let viewControllers = [home, details, message, mine]
        return viewControllers
    }
  

    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let status = GMStorageManager.shared.getData(forkey: LoginSucessKey) as? Int
        if status != 1 {
            // 获取当前选中的视图控制器的导航控制器
            if tabBarController.selectedViewController is UINavigationController &&  tabBarController.selectedIndex != 0 {
                // 创建并推送登录视图控制器
                let loginVC = GMLoginController()
                let nav = tabBarController.selectedViewController as? GMBaseNavigationController
                nav?.pushViewController(loginVC, animated: false)
            } else {
                // 如果没有导航控制器，你可能需要采取其他措施，比如直接设置根视图控制器
                print("当前选中的视图控制器没有导航控制器")
            }
        }
    }
}

