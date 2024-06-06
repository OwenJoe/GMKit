//
//  GMViewControllerExt.swift
//  Gimme
//
//  Created by hule on 2024/5/21.
//

extension UIViewController {
    //获取当前所在的控制器
    static var current: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return nil
    }

}
