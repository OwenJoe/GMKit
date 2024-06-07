//
//  GMGlobal.swift
//  Gimmi
//
//  Created by hule on 2024/4/24.
//

import Foundation

/***********************************第三方库***********************************/ 
@_exported import JXSegmentedView
@_exported import Alamofire
@_exported import Kingfisher
@_exported import CodableWrapper
@_exported import EachNavigationBar
@_exported import MJRefresh
@_exported import EmptyDataSet_Swift
@_exported import HandyJSON
@_exported import KeychainAccess
@_exported import SnapKit
@_exported import IQKeyboardManagerSwift
@_exported import EmptyDataSet_Swift

/*****************************相应的key**********************************************/



/**********************************常见常量************************************/
//获取屏幕高宽
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

//返回状态栏高度
#if __IPHONE_13_0
let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height
#else
let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
#endif

//返回状态栏和导航栏的高度
let NavAndstatusBarHeight = statusBarHeight + 44

//判断是否是刘海屏
let iphoneX = ((statusBarHeight != 20) ? true : false)

// 获取版本号
let LOCAL_RELEASE_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

// 获取手机型号
let Phone_Model = UIDevice.current.model

// 系统版本号
let System_Version = UIDevice.current.systemVersion

//获取当前语言
let Language_first_local = NSLocale.preferredLanguages.first!




// MARK: - 颜色
var RGBA:(NSInteger, NSInteger, NSInteger, CGFloat) -> UIColor = { (r,g,b,a) in
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
}

var RGB:(NSInteger, NSInteger, NSInteger) -> UIColor = { (r,g,b) in
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
}
//随机颜色
let RANDOM_COLOR = RGB(Int(arc4random())%255, Int(arc4random())%255, Int(arc4random())%255)

//16进制颜色转换
var HexRGB:(NSInteger) -> UIColor = { hex in
    return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)((hex & 0xFF))) / 255.0, alpha: 1.0)
}

//16进制颜色 字符串
var HexString: (String) -> UIColor = { hex in
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
    }

    if cString.count != 6 {
        return UIColor.gray
    }

    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}



//16进制颜色转换（带透明度）
var HexRGBAlpha:(NSInteger, CGFloat) -> UIColor = { (hex, alpha) in
    return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)((hex & 0xFF))) / 255.0, alpha: alpha)
}

//storyboard
var Storyboard_INSTANT_VC_WITH_ID:(String, String) -> UIViewController = { name,identifier in
    return UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
}

//nib
var Nib_INSTANT_WITH_NAME:(String) -> Any? = { name in
    return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first
}


//设置本地图片
var imageName:(String) -> UIImage = { imgName in
    return UIImage(named: imgName)!
}


/// 判断设备是 iPhone
let isIPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone

/// 判断设备是 iPad
let isIPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad

/// 判断是否是横屏
public func isIsLandscape() -> Bool {
    return UIDevice.current.orientation.isLandscape || UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeLeft  || UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeRight
}

///获取keywindow
#if __IPHONE_13_0
let KeyWindows = UIApplication.shared.windows.first
#else
let KeyWindows = UIApplication.shared.keyWindow
#endif

///获取Document路径
let DocumentPath_Local = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/"

///获取caches路径
let CachesPath_Local = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/"

///获取caches路径
let LibraryPath_Local = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! + "/"

///获取temp路径
let TempPath_Local = NSTemporaryDirectory()


///打印log
func NSLog<T>(message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line,
              date:Date = Date()) {
    #if DEBUG
    print("\(date) \((file as NSString).lastPathComponent)[\(line)], \(method):\n\(message)")
    #endif
}


// 导航栏高度
let navigationBarHeight: CGFloat = {
    let defaultNavBarHeight: CGFloat = 44
    let tabBarHeight: CGFloat = 49
    let bangsNavBarHeight: CGFloat = statusBarHeight + defaultNavBarHeight
    let bangsTabBarHeight: CGFloat = 83
    
    if iphoneX {
        return bangsNavBarHeight
    } else {
        return defaultNavBarHeight
    }
}()

// TabBar 高度
let tabBarHeight: CGFloat = {
    let defaultTabBarHeight: CGFloat = 49
    let bangsTabBarHeight: CGFloat = 83
    
    return iphoneX ? bangsTabBarHeight : defaultTabBarHeight
}()


//多国语言处理
func GMLocalizedString(_ key: String, comment: String = "") -> String {
    return NSLocalizedString(key, comment: comment)
}







