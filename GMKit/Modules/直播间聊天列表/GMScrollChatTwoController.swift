//
//  GMScrollChatController.swift
//  GMKit
//
//  Created by hule on 2024/6/13.
//

import UIKit

class GMScrollChatTwoController: GMBaseViewController {
    
    var listArr = [Any]()
    lazy var tableView: GMChatTwoTableView = {
        let tableView = GMChatTwoTableView(frame: CGRect(x: 100, y: 150, width: 250, height: UIScreen.main.bounds.height * 0.75), style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "直播间滚动聊天列表"
        view.backgroundColor = .gray
        view.addSubview(tableView)
        // 开始自动滚动
        tableView.startAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 停止自动滚动
        tableView.stopAutoScroll()
    }
}

