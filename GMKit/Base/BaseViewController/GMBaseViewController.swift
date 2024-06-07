//
//  GMBaseViewController.swift
//  Gimmi
//
//  Created by hule on 2024/4/25.
//

import UIKit

class GMBaseViewController: UIViewController , UINavigationControllerDelegate, UIGestureRecognizerDelegate{
    
    var navTitle : String? {
        didSet {
            navigation.item.title = navTitle
            navigation.bar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = HexString("#101123")
        self.navigationController?.delegate = self
        
        self.navigationController?.navigation.configuration.isEnabled = true
        self.navigationController?.navigation.configuration.barTintColor = UIColor.clear
        self.navigationController?.navigation.configuration.tintColor = UIColor.white
        self.navigationController?.navigation.bar.alpha = 0
        navigation.bar.setBackgroundImage(#imageLiteral(resourceName: "nav_bg"), for: .default)

        
        //需要隐藏的导航栏
        if self is GMHomeController {
            navigation.bar.isHidden = true
            
        }
        
//        //隐藏返回按钮
        if self is GMHomeController || self is GMMineController ||
            self is GMMessageController || self is GMDetailsController {
            //隐藏返回按钮
            self.navigationController?.navigation.item.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil
            )
        }
        else {
            self.navigation.item.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:#selector(popAction)
            )
        }
    }
    


    @objc private func popAction() {
        //这里自动跳转到GMBaseNavigationController 重写事件
        navigationController?.popViewController(animated: true)
    }


}
