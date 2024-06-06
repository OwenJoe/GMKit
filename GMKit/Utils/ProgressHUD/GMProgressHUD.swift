//
//  GMProgressHUD.swift
//  Gimme
//
//  Created by hule on 2024/6/3.
//

import UIKit

class GMProgressHUD {
    
    static let shared = GMProgressHUD()

    // 设置默认消失时间为 5 秒,原有框架5秒消失时间太长了
    private static let defaultDismissTimeInterval: TimeInterval = 1.5

    private init() {
        // 可以在初始化时进行其他全局配置，如样式等
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.black)
    }

    // 显示加载动画
   static func show() {
        SVProgressHUD.show()
    }
    
    //普通文案显示
    static  func showStatus(_ status: String) {
        SVProgressHUD.show(withStatus: status)
        dismissWithDelay()
    }

    // 显示成功提示，并在默认时间后自动消失
    static func showSuccess(_ status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
        dismissWithDelay()
    }

    // 显示错误提示，并在默认时间后自动消失
    static func showError(_ status: String) {
        SVProgressHUD.showError(withStatus: status)
        dismissWithDelay()
    }

    // 显示信息提示，并在默认时间后自动消失
    static func showInfo(_ status: String) {
        SVProgressHUD.showInfo(withStatus: status)
        dismissWithDelay()
    }
    
    //菊花立马消失
    static  func dismiss()  {
        SVProgressHUD.dismiss()
    }

    // 隐藏动画，并在默认时间后自动消失
    static func dismissWithDelay() {
        SVProgressHUD.dismiss(withDelay: defaultDismissTimeInterval)
    }
}
