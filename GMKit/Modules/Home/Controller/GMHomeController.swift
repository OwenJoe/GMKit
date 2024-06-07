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
            GMHomeModel.init(content: "切换中东地区,UI变化", type: .defaultType),
            GMHomeModel.init(content: "tableView删除", type: .defaultType),
            GMHomeModel.init(content: "属性包装器使用", type: .defaultType),
            GMHomeModel.init(content: "修改UIPicker选中行字体颜色", type: .defaultType),
            GMHomeModel.init(content: "修改UIPickerView选中行后取消背景", type: .defaultType),
            GMHomeModel.init(content: "阿拉伯数字转成中文大写", type: .defaultType),
            GMHomeModel.init(content: "Button防止暴力点击", type: .defaultType),
            GMHomeModel.init(content: "textField限制字符串长度,限制输入类型", type: .defaultType),
            GMHomeModel.init(content: "数组去重", type: .defaultType),
            GMHomeModel.init(content: "字典合并", type: .defaultType),
            GMHomeModel.init(content: "Cell圆角+阴影", type: .defaultType),
            GMHomeModel.init(content: "改变UIPicker选中行字体颜色", type: .defaultType),
            GMHomeModel.init(content: "修改CollectionViewCell叠加顺序", type: .defaultType),
            GMHomeModel.init(content: "控制器悬浮小窗", type: .defaultType),
            GMHomeModel.init(content: "常见系统权限获取", type: .defaultType),
            GMHomeModel.init(content: "Scrollow无限轮播", type: .defaultType),
            GMHomeModel.init(content: "播放Gif动图", type: .defaultType),
            GMHomeModel.init(content: "获取文字高度", type: .defaultType),
            GMHomeModel.init(content: "直播间-->聊天", type: .defaultType),
            GMHomeModel.init(content: "直播间-->飘屏", type: .defaultType),
            GMHomeModel.init(content: "直播间-->关注人数", type: .defaultType),
            GMHomeModel.init(content: "长连接Socket使用", type: .defaultType),
            GMHomeModel.init(content: "相机作为背景", type: .defaultType),
            GMHomeModel.init(content: "内购", type: .defaultType),
            GMHomeModel.init(content: "支付宝", type: .defaultType),
            GMHomeModel.init(content: "微信", type: .defaultType),
            GMHomeModel.init(content: "图片文件/图片URL/视频文件/视频URL保存到本地", type: .defaultType),
            GMHomeModel.init(content: "列表每个cell嵌套倒计时", type: .defaultType),
            GMHomeModel.init(content: "动画翻转图片", type: .defaultType),
            GMHomeModel.init(content: "textView监听", type: .defaultType),
            GMHomeModel.init(content: "textField监听", type: .defaultType),
            GMHomeModel.init(content: "tableView嵌套collectionView", type: .defaultType),
            GMHomeModel.init(content: "模态控制器多种效果", type: .defaultType),
            GMHomeModel.init(content: "跑马灯", type: .defaultType),
            GMHomeModel.init(content: "FD高度缓存", type: .defaultType),
            GMHomeModel.init(content: "runtime黑魔法交换使用", type: .defaultType),
            GMHomeModel.init(content: "瀑布流", type: .defaultType),
            GMHomeModel.init(content: "tableView圆角", type: .defaultType),
            GMHomeModel.init(content: "collectionView圆角", type: .defaultType),
            GMHomeModel.init(content: "无限轮播图(可替换图片url/自定义View)", type: .defaultType),
            GMHomeModel.init(content: "导航栏自定义效果", type: .defaultType),
            GMHomeModel.init(content: "按钮文字图片位置", type: .defaultType),
            GMHomeModel.init(content: "购物车-->单选", type: .defaultType),
            GMHomeModel.init(content: "直播间-->多选", type: .defaultType),
            GMHomeModel.init(content: "换肤", type: .defaultType),
            GMHomeModel.init(content: "换logo", type: .defaultType),
            GMHomeModel.init(content: "Svga播放", type: .defaultType),
            GMHomeModel.init(content: "DSBridge使用", type: .defaultType),
            GMHomeModel.init(content: "搜索历史和记录", type: .defaultType),
            GMHomeModel.init(content: "系统地图的使用", type: .defaultType),
            GMHomeModel.init(content: "极光推送", type: .defaultType),
            GMHomeModel.init(content: "友盟推送", type: .defaultType),
            GMHomeModel.init(content: "搜索历史和记录", type: .defaultType),
            GMHomeModel.init(content: "tableView二级折叠", type: .defaultType),
            GMHomeModel.init(content: "tableView三级折叠", type: .defaultType),
            GMHomeModel.init(content: "蓝牙使用", type: .defaultType),
            GMHomeModel.init(content: "常见加解密", type: .defaultType),
            GMHomeModel.init(content: "FMDB封装使用", type: .defaultType),
            GMHomeModel.init(content: "wkwebView不同缓存类型表现", type: .defaultType),
            GMHomeModel.init(content: "相机滤镜", type: .defaultType),
            GMHomeModel.init(content: "常规正则判断", type: .defaultType),
            GMHomeModel.init(content: "AdVance人脸识别", type: .defaultType),
            GMHomeModel.init(content: "仿微信右上角弹出菜单", type: .defaultType)
            
            
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
}
