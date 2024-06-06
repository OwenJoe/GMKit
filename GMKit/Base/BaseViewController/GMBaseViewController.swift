//
//  GMBaseViewController.swift
//  Gimmi
//
//  Created by hule on 2024/4/25.
//

import UIKit

class GMBaseViewController: UIViewController , UINavigationControllerDelegate, UIGestureRecognizerDelegate{
 

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = HexString("#101123")
        self.navigationController?.delegate = self
        
    }
    

    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 判断如果是需要隐藏导航控制器的类，则隐藏
        let isHideNav = viewController is GMLoginController
        self.navigationController?.setNavigationBarHidden(isHideNav, animated: true)
    }

}
