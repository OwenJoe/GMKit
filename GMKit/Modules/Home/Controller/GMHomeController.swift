//
//  GMHomeController.swift
//  GMKit
//
//  Created by hule on 2024/6/6.
//

import UIKit

class GMHomeController: GMBaseViewController,UITableViewDelegate, UITableViewDataSource {
  
    var listArr : [GMHomeModel]?
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: GMHomeCellID, bundle: nil), forCellReuseIdentifier: GMHomeCellID)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        view.addSubview(tableView)
        getData()
    }
    
    
    func getData()  {
        listArr = [
            GMHomeModel(content: "切换中东地区,UI变化", type: .middleEastSwitch),
            GMHomeModel(content: "tableView删除", type: .tableViewDelete),
            GMHomeModel(content: "属性包装器使用", type: .propertyWrapperUsage),
            GMHomeModel(content: "修改UIPicker选中行字体颜色", type: .modifyPickerSelectedRowFontColor),
            GMHomeModel(content: "修改UIPickerView选中行后取消背景", type: .removePickerSelectedRowBackground),
            GMHomeModel(content: "阿拉伯数字转成中文大写", type: .arabicNumberToChineseUppercase),
            GMHomeModel(content: "Button防止暴力点击", type: .buttonClickPrevention),
            GMHomeModel(content: "textField限制字符串长度,限制输入类型", type: .textFieldStringLimit),
            GMHomeModel(content: "数组去重", type: .arrayDeduplication),
            GMHomeModel(content: "字典合并", type: .dictionaryMerge),
            GMHomeModel(content: "Cell圆角+阴影", type: .cellCornerRadiusAndShadow),
            GMHomeModel(content: "改变UIPicker选中行字体颜色", type: .changePickerSelectedRowFontColor),
            GMHomeModel(content: "修改CollectionViewCell叠加顺序", type: .modifyCollectionViewCellOrder),
            GMHomeModel(content: "控制器悬浮小窗", type: .controllerFloatingWindow),
            GMHomeModel(content: "常见系统权限获取", type: .systemPermissions),
            GMHomeModel(content: "Scrollow无限轮播", type: .infiniteScroll),
            GMHomeModel(content: "播放Gif动图", type: .playGif),
            GMHomeModel(content: "获取文字高度", type: .getTextHeight),
            GMHomeModel(content: "直播间-->聊天", type: .liveChat),
            GMHomeModel(content: "直播间-->飘屏", type: .liveScreen),
            GMHomeModel(content: "直播间-->关注人数", type: .liveFollowers),
            GMHomeModel(content: "长连接Socket使用", type: .socketUsage),
            GMHomeModel(content: "相机作为背景", type: .cameraAsBackground),
            GMHomeModel(content: "内购", type: .inAppPurchase),
            GMHomeModel(content: "支付宝", type: .alipay),
            GMHomeModel(content: "微信", type: .weChat),
            GMHomeModel(content: "图片文件/图片URL/视频文件/视频URL保存到本地", type: .saveFilesToLocal),
            GMHomeModel(content: "列表每个cell嵌套倒计时", type: .cellCountdown),
            GMHomeModel(content: "动画翻转图片", type: .imageFlipAnimation),
            GMHomeModel(content: "textView监听", type: .textViewListener),
            GMHomeModel(content: "textField监听", type: .textFieldListener),
            GMHomeModel(content: "tableView嵌套collectionView", type: .tableViewNestedCollectionView),
            GMHomeModel(content: "模态控制器多种效果", type: .modalControllerEffects),
            GMHomeModel(content: "跑马灯", type: .marquee),
            GMHomeModel(content: "FD高度缓存", type: .fdHeightCache),
            GMHomeModel(content: "runtime黑魔法交换使用", type: .runtimeSwizzling),
            GMHomeModel(content: "瀑布流", type: .waterfallFlow),
            GMHomeModel(content: "tableView圆角", type: .tableViewCornerRadius),
            GMHomeModel(content: "collectionView圆角", type: .collectionViewCornerRadius),
            GMHomeModel(content: "无限轮播图(可替换图片url/自定义View)", type: .infiniteCarousel),
            GMHomeModel(content: "导航栏自定义效果", type: .customNavigationBar),
            GMHomeModel(content: "按钮文字图片位置", type: .buttonTextImagePosition),
            GMHomeModel(content: "购物车-->单选", type: .shoppingCartSingleSelection),
            GMHomeModel(content: "直播间-->多选", type: .liveMultiSelection),
            GMHomeModel(content: "换肤", type: .skinChange),
            GMHomeModel(content: "换logo", type: .logoChange),
            GMHomeModel(content: "Svga播放", type: .svgaPlayback),
            GMHomeModel(content: "DSBridge使用", type: .dsBridgeUsage),
            GMHomeModel(content: "搜索历史和记录", type: .searchHistory),
            GMHomeModel(content: "系统地图的使用", type: .systemMapUsage),
            GMHomeModel(content: "极光推送", type: .jpush),
            GMHomeModel(content: "友盟推送", type: .umengPush),
            GMHomeModel(content: "tableView二级折叠", type: .tableViewTwoLevelCollapse),
            GMHomeModel(content: "tableView三级折叠", type: .tableViewThreeLevelCollapse),
            GMHomeModel(content: "蓝牙使用", type: .bluetoothUsage),
            GMHomeModel(content: "常见加解密", type: .commonEncryptionDecryption),
            GMHomeModel(content: "FMDB封装使用", type: .fmdbUsage),
            GMHomeModel(content: "wkwebView不同缓存类型表现", type: .wkWebViewCacheBehaviors),
            GMHomeModel(content: "相机滤镜", type: .cameraFilter),
            GMHomeModel(content: "常规正则判断", type: .regexJudgement),
            GMHomeModel(content: "AdVance人脸识别", type: .advanceFaceRecognition),
            GMHomeModel(content: "仿微信右上角弹出菜单", type: .weChatMenu)
            
        ]
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GMHomeCellID, for: indexPath) as? GMHomeCell
        cell?.rowStr = String(indexPath.section)
        cell?.model = listArr?[indexPath.section]
        return cell ?? GMHomeCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let webSocket = GMWebSocketManager.shared
//        webSocket.connect()
//
//        //可以用http://www.websocket-test.com/ 进行在线测试,个别网站测试有问题
//        //现有项目是只有发送对应的格式到后端,后端才会进行消息转发,客户端才能收到消息
//        let jsonObject: [String: Any] = ["room_id": "123456", "roomUid": "123456", "uid": 0, "room_type": 0]
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print("JSON 字符串: \(jsonString)")
//                webSocket.writeText(message: jsonString)
//            }
//        } catch {
//            print("转换 JSON 到字符串时发生错误: \(error)")
//        }

     
//          let vc  =  GMScrollChatChoseController()
//          let vc  =  GMClearScreenController()
//          let vc = GMVoiceRoomController()
//          let vc =  GMVideoRoomController()
          let vc = GMPKRoomController()
          self.navigationController?.pushViewController(vc, animated: true)
    }
}
