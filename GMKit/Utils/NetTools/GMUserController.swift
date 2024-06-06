//
//  GMUserController.swift
//  Gimme
//
//  Created by hule on 2024/5/14.
//

import UIKit
import AppTrackingTransparency
import AdSupport

class GMUserController: NSObject {
    
    @objc static let shared = GMUserController()
    
//    /// 用户登录数据
//    var userLoginModel: UserLoginModel? {
//        return SessionMgr.instance.getLoginUserModel()
//    }
//    
//    /// 用户ticket信息
//    var ticketModel: UserTicketListModel? {
//        return SessionMgr.instance.getUserTicketListModel()
//    }
//    
//    /// 用户信息
//    var userInfoModel: UserInfoModel? {
//        return SessionMgr.instance.getUserInfoModel()
//    }
    
//    /// 是否登录
//    @objc var isLogin: Bool {
//        guard let _ = userInfoModel?.uid else {
//            return false
//        }
//        return true
//    }
    
    /// 版本号
    @objc var version: String {
        let info = Bundle.main.infoDictionary
        let name = info?["CFBundleShortVersionString"] as? String
        return name ?? ""
    }
    
    /// 构建版本号
    @objc var build: String {
        let info = Bundle.main.infoDictionary
        let build = info?["CFBundleVersion"] as? String
        return build ?? ""
    }
    
    /// 项目名称
    @objc var appName: String {
        let info = Bundle.main.infoDictionary
        let name = info?["CFBundleDisplayName"] as? String
        return name ?? ""
    }
    
    /// 项目本地名称
    @objc var appLocalName: String {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        }
        return ""
    }
    
    ///  当前时间戳
    @objc var timeStamp: Int {
        let date = Int(Date().timeIntervalSince1970 * 1000.0)
        return date
    }
    
    /// 当前系统版本
    @objc var osVersion: String {
        let name = UIDevice.current.systemVersion
        return name
        
    }
    
    /// 公司名称
    @objc var companyName: String {
//        return "广州时间在线科技有限公司"
        return ""
    }
    
   @discardableResult  //外界调用没有返回值 不会有警告
   func getIDFA() -> String {
        // 首先尝试获取存储的 IDFA
        if let storedIDFA = GMStorageManager.shared.getStoredIDFA() {
            return storedIDFA
        }

        // 如果存储的 IDFA 不存在，请求权限并获取 IDFA
        if #available(iOS 14, *) {
            var idfa: String = "" // 设置一个默认值
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        // 用户授权跟踪，可以获取 IDFA
                        if let newIDFA: String? = ASIdentifierManager.shared().advertisingIdentifier.uuidString {
                            idfa = newIDFA ?? ""
                            GMStorageManager.shared.saveIDFA(idfa: idfa)
                        }
                    case .denied, .notDetermined, .restricted:
                        // 用户拒绝跟踪或跟踪受到限制，使用默认值
                        break
                    @unknown default:
                        // 处理未知情况
                        break
                    }
                }
            }
            return idfa
        } else {
            // 对于 iOS 14 之前的版本，可以直接获取 IDFA
            if let idfa: String? = ASIdentifierManager.shared().advertisingIdentifier.uuidString {
                GMStorageManager.shared.saveIDFA(idfa: idfa ?? "")
                return idfa ?? ""
            } else {
                return "" // 设置一个默认值
            }
        }
    }

    

}
