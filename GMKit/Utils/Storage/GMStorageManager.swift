//
//  GMStorageManager.swift
//  Gimmi
//
//  Created by hule on 2024/4/26.
//

import UIKit

//历史记录的key
let SearchKey = "Search"
//是否已经登录成功
let LoginSucessKey = "LoginSucess"
//国家地区模型数组
let CountryListArrKey = "CountryListArrKey"
//单个选中数组模型
let SingleCountryModelKey = "SingleCountryModel"
//发布帖子的模型数组
let PostArrayModelKey = "PostArrayModel"
//我的动态帖子模型数组
let MyUpdatesModelArrKey = "MyUpdatesModelArr"
//APP是否首次安装
let IsFirstTimeInstallKey = "isFirstTimeInstall"
//当前登录用户的假模型
let LoginModelKey = "LoginModel"
//聊天数组模型
let ChatModelArrKey = "ChatModelArr"
//新闻数据 下一页码
let NewNextPageKey = "NewNextPage"

class GMStorageManager: NSObject {

    static let shared = GMStorageManager()
    private let userDefaults = UserDefaults.standard
    
    //存储数据
    func saveData(value: Any?,  forkey key: String)  {
        userDefaults.setValue(value, forKey: key)
        userDefaults.synchronize()
    }
    
    //获取数据
    func getData(forkey key: String) -> Any? {
        return userDefaults.object(forKey: key)
    }
    
    
    // 存储布尔值
    func saveBool(value: Bool, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    // 获取布尔值
    func getBool(forKey key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }
    
    //移除数据
    func removeData(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    // 存储 IDFA
    func saveIDFA(idfa: String) {
        saveData(value: idfa, forkey: "IDFA")
    }
    
    // 获取存储的 IDFA
    func getStoredIDFA() -> String? {
        return getData(forkey: "IDFA") as? String
    }
    
    
    // 存储自定义模型
    func saveCustomModel<T: Codable>(value: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            userDefaults.set(encoded, forKey: key)
        } else {
            print("Failed to encode custom model")
        }
    }
    
    // 获取自定义模型
    func getCustomModel<T: Codable>(forKey key: String) -> T? {
        if let data = userDefaults.data(forKey: key),
           let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        } else {
            print("Failed to decode custom model")
            return nil
        }
    }
    
    
    // 存储自定义模型数组
    func saveCustomModelArray<T: Codable>(array: [T], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(array) {
            userDefaults.set(encoded, forKey: key)
        } else {
            print("Failed to encode custom model array")
        }
    }
    
    // 获取自定义模型数组
    func getCustomModelArray<T: Codable>(forKey key: String) -> [T]? {
        if let data = userDefaults.data(forKey: key),
           let decoded = try? JSONDecoder().decode([T].self, from: data) {
            return decoded
        } else {
            print("Failed to decode custom model array")
            return nil
        }
    }
}
