//
//  GMScrollChatController.swift
//  GMKit
//
//  Created by hule on 2024/6/13.
//

import UIKit

class GMScrollChatController: GMBaseViewController {
    var autoScrollTimer: Timer?
    var listArr = [Any]()
    lazy var tableView: GMChatListTableView = {
        let tableView = GMChatListTableView(frame: CGRectMake(100, 150, 250, ScreenHeight * 0.75),style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: GMScrollChatCellKey, bundle: nil), forCellReuseIdentifier: GMScrollChatCellKey)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "直播间滚动聊天列表"
        view.backgroundColor = .white
        view.addSubview(tableView)
//        addGradientToTableView()
        // 开始自动滚动
//        startAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 停止自动滚动
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
}

//列表内容
extension GMScrollChatController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GMScrollChatCellKey, for: indexPath) as? GMScrollChatCell
        cell?.selectionStyle = .none
        return cell ?? GMScrollChatCell()
    }
}


//滚动处理
extension GMScrollChatController {
    
    // 启动自动滚动
       func startAutoScroll() {
//           autoScrollTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoScrollTableView), userInfo: nil, repeats: true)
       }

       // 停止自动滚动
       func stopAutoScroll() {
           autoScrollTimer?.invalidate()
           autoScrollTimer = nil
       }

       // 自动滚动 TableView 的方法
       @objc func autoScrollTableView() {
           // 获取当前滚动位置
           let currentOffset = tableView.contentOffset.y
           // 计算下一个滚动位置
           let nextOffset = CGPoint(x: 0, y: currentOffset + 50) // 增加50个点或者你想滚动的量

           // 检查是否到达底部
           if nextOffset.y < tableView.contentSize.height - tableView.frame.size.height {
               // 滚动到下一个位置
               tableView.setContentOffset(nextOffset, animated: true)
           } else {
               // 如果到达底部，停止定时器
               stopAutoScroll()
           }
       }

       // MARK: - UIScrollViewDelegate

       func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           // 当用户开始拖拽时，停止自动滚动
           stopAutoScroll()
       }

       func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
           if !decelerate {
               // 如果没有减速（立即停止），重新启动自动滚动
               startAutoScroll()
           }
       }

       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           // 如果存在减速，减速结束后重新启动自动滚动
           startAutoScroll()
       }
    

}

//聊天顶部尾部模糊化
extension GMScrollChatController{
    
    func addGradientToTableView() {
        guard let tableViewSuperview = tableView.superview else { return }

        // 创建渐变层
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(white: 0, alpha: 0.05).cgColor,
            UIColor(white: 0, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 0.4] // 设置颜色的范围
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // 设置颜色渐变的起点
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.30) // 设置颜色渐变的终点，形成渐变方向
        gradientLayer.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.width, height: tableView.frame.height)
        
        // 创建一个UIView作为遮罩层
        let gradientView = UIView(frame: tableView.frame)
        gradientView.layer.addSublayer(gradientLayer)

        // 将遮罩视图添加到tableView的superview上，并确保它不会随tableView滚动
        tableViewSuperview.addSubview(gradientView)
        tableViewSuperview.bringSubviewToFront(gradientView)
    }


}
