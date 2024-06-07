//
//  GMHomeModel.swift
//  GMKit
//
//  Created by hule on 2024/6/6.
//

enum HomeType: String, Codable {
    /// 切换中东地区, UI变化
    case middleEastSwitch = "切换中东地区, UI变化"
    /// tableView删除
    case tableViewDelete = "tableView删除"
    /// 属性包装器使用
    case propertyWrapperUsage = "属性包装器使用"
    /// 修改UIPicker选中行字体颜色
    case modifyPickerSelectedRowFontColor = "修改UIPicker选中行字体颜色"
    /// 修改UIPickerView选中行后取消背景
    case removePickerSelectedRowBackground = "修改UIPickerView选中行后取消背景"
    /// 阿拉伯数字转成中文大写
    case arabicNumberToChineseUppercase = "阿拉伯数字转成中文大写"
    /// Button防止暴力点击
    case buttonClickPrevention = "Button防止暴力点击"
    /// textField限制字符串长度,限制输入类型
    case textFieldStringLimit = "textField限制字符串长度,限制输入类型"
    /// 数组去重
    case arrayDeduplication = "数组去重"
    /// 字典合并
    case dictionaryMerge = "字典合并"
    /// Cell圆角+阴影
    case cellCornerRadiusAndShadow = "Cell圆角+阴影"
    /// 改变UIPicker选中行字体颜色
    case changePickerSelectedRowFontColor = "改变UIPicker选中行字体颜色"
    /// 修改CollectionViewCell叠加顺序
    case modifyCollectionViewCellOrder = "修改CollectionViewCell叠加顺序"
    /// 控制器悬浮小窗
    case controllerFloatingWindow = "控制器悬浮小窗"
    /// 常见系统权限获取
    case systemPermissions = "常见系统权限获取"
    /// Scrollow无限轮播
    case infiniteScroll = "Scrollow无限轮播"
    /// 播放Gif动图
    case playGif = "播放Gif动图"
    /// 获取文字高度
    case getTextHeight = "获取文字高度"
    /// 直播间-->聊天
    case liveChat = "直播间-->聊天"
    /// 直播间-->飘屏
    case liveScreen = "直播间-->飘屏"
    /// 直播间-->关注人数
    case liveFollowers = "直播间-->关注人数"
    /// 长连接Socket使用
    case socketUsage = "长连接Socket使用"
    /// 相机作为背景
    case cameraAsBackground = "相机作为背景"
    /// 内购
    case inAppPurchase = "内购"
    /// 支付宝
    case alipay = "支付宝"
    /// 微信
    case weChat = "微信"
    /// 图片文件/图片URL/视频文件/视频URL保存到本地
    case saveFilesToLocal = "图片文件/图片URL/视频文件/视频URL保存到本地"
    /// 列表每个cell嵌套倒计时
    case cellCountdown = "列表每个cell嵌套倒计时"
    /// 动画翻转图片
    case imageFlipAnimation = "动画翻转图片"
    /// textView监听
    case textViewListener = "textView监听"
    /// textField监听
    case textFieldListener = "textField监听"
    /// tableView嵌套collectionView
    case tableViewNestedCollectionView = "tableView嵌套collectionView"
    /// 模态控制器多种效果
    case modalControllerEffects = "模态控制器多种效果"
    /// 跑马灯
    case marquee = "跑马灯"
    /// FD高度缓存
    case fdHeightCache = "FD高度缓存"
    /// runtime黑魔法交换使用
    case runtimeSwizzling = "runtime黑魔法交换使用"
    /// 瀑布流
    case waterfallFlow = "瀑布流"
    /// tableView圆角
    case tableViewCornerRadius = "tableView圆角"
    /// collectionView圆角
    case collectionViewCornerRadius = "collectionView圆角"
    /// 无限轮播图(可替换图片url/自定义View)
    case infiniteCarousel = "无限轮播图(可替换图片url/自定义View)"
    /// 导航栏自定义效果
    case customNavigationBar = "导航栏自定义效果"
    /// 按钮文字图片位置
    case buttonTextImagePosition = "按钮文字图片位置"
    /// 购物车-->单选
    case shoppingCartSingleSelection = "购物车-->单选"
    /// 直播间-->多选
    case liveMultiSelection = "直播间-->多选"
    /// 换肤
    case skinChange = "换肤"
    /// 换logo
    case logoChange = "换logo"
    /// Svga播放
    case svgaPlayback = "Svga播放"
    /// DSBridge使用
    case dsBridgeUsage = "DSBridge使用"
    /// 搜索历史和记录
    case searchHistory = "搜索历史和记录"
    /// 系统地图的使用
    case systemMapUsage = "系统地图的使用"
    /// 极光推送
    case jpush = "极光推送"
    /// 友盟推送
    case umengPush = "友盟推送"
    /// tableView二级折叠
    case tableViewTwoLevelCollapse = "tableView二级折叠"
    /// tableView三级折叠
    case tableViewThreeLevelCollapse = "tableView三级折叠"
    /// 蓝牙使用
    case bluetoothUsage = "蓝牙使用"
    /// 常见加解密
    case commonEncryptionDecryption = "常见加解密"
    /// FMDB封装使用
    case fmdbUsage = "FMDB封装使用"
    /// wkwebView不同缓存类型表现
    case wkWebViewCacheBehaviors = "wkwebView不同缓存类型表现"
    /// 相机滤镜
    case cameraFilter = "相机滤镜"
    /// 常规正则判断
    case regexJudgement = "常规正则判断"
    /// AdVance人脸识别
    case advanceFaceRecognition = "AdVance人脸识别"
    /// 仿微信右上角弹出菜单
    case weChatMenu = "仿微信右上角弹出菜单"
    /// 错题解决库
    case errorResolutionLibrary = "错题解决库"
}


struct GMHomeModel: Codable {
    
    var content: String?
    var type: HomeType?
}
