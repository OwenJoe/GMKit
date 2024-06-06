//
//  AppDelegate.swift
//  GMKit
//
//  Created by hule on 2024/6/6.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupTabBar()
        //调用任意接口,国行版弹起网络数据弹窗
        loadURL(urlString: "https://www.baidu.com")
        return true
    }
    
    //加载tabBar
    func setupTabBar()  {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainTabBarVc = GMTabBarController()
        window?.rootViewController = mainTabBarVc
        window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable =  true
    }

    //是否追踪隐私弹窗
    func applicationDidBecomeActive(_ application: UIApplication) {
        //处理IDFA
        GMUserController.shared.getIDFA()
    }
    
    

    //唤醒网络弹窗,判断是否首次弹窗
    func loadURL(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        // 网络请求成功，可以处理返回的数据
                       
                    } else {
                        print("HTTP Error: \(httpResponse.statusCode)")
                    }
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}

