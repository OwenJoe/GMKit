//
//  GMChatListTableView.swift
//  GMKit
//
//  Created by hule on 2024/6/14.
//

import UIKit

class GMChatOneTableView: UITableView{
    //设置GCD定时器
    var autoScrollTimer: DispatchSourceTimer?
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTableGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    func setupUI() {
        
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: GMScrollChatCellKey, bundle: nil), forCellReuseIdentifier: GMScrollChatCellKey)
        self.estimatedRowHeight = UITableView.automaticDimension
        self.rowHeight = UITableView.automaticDimension
        self.separatorStyle = .none
        self.backgroundColor = .clear
        self.transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    

    

}


extension GMChatOneTableView: UIScrollViewDelegate {
    
    
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
    
    // 启动自动滚动
    func startAutoScroll() {
        guard autoScrollTimer == nil else { return  }
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer.schedule(deadline: .now(), repeating: 1.0)
        timer.setEventHandler { [weak self] in
            self?.autoScrollTableView()
        }
        timer.resume()
        autoScrollTimer = timer
        print("开始 -》")
    }

    // 停止自动滚动
    func stopAutoScroll() {
        autoScrollTimer?.cancel()
        autoScrollTimer = nil
        print("结束 -》")
    }

    @objc func autoScrollTableView() {
        print("滚动----》")
        // 获取当前滚动位置
        let currentOffset = self.contentOffset.y
        
        // 计算每次滚动的量
        let scrollAmount: CGFloat = 50
        
        // 判断是否翻转
        let isReversed = !self.transform.isIdentity
        
        // 计算下一个滚动位置
        let nextOffset: CGPoint
        if isReversed {
            nextOffset = CGPoint(x: 0, y: currentOffset - scrollAmount)
        } else {
            nextOffset = CGPoint(x: 0, y: currentOffset + scrollAmount)
        }

        // 检查是否超出范围
        if nextOffset.y >= 0 && nextOffset.y <= self.contentSize.height - self.frame.size.height {
            // 滚动到下一个位置
            self.setContentOffset(nextOffset, animated: true)
        } else {
            // 如果超出范围，停止定时器
            stopAutoScroll()
        }
    }

}


//代理
extension GMChatOneTableView:UITableViewDelegate, UITableViewDataSource {

    
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



//遮罩效果处理
extension GMChatOneTableView {
    //只有顶部有遮罩效果，配合transform列表翻转后跟着翻转
//    func setTableGradientLayer() {
//        // 创建渐变层
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor(white: 0, alpha: 0.05).cgColor,
//            UIColor(white: 0, alpha: 1.0).cgColor
//        ]
//        gradientLayer.locations = [0.0, 0.4] // 设置颜色的范围
//
//        // 根据视图的 transform 属性调整渐变层的起点和终点
//        if self.transform.isIdentity {
//            gradientLayer.startPoint = CGPoint(x: 0, y: 0) // 默认起点
//            gradientLayer.endPoint = CGPoint(x: 0, y: 0.30) // 默认终点
//        } else {
//            // 假设只有 y 轴翻转变换
//            gradientLayer.startPoint = CGPoint(x: 0, y: 1) // 翻转后的起点
//            gradientLayer.endPoint = CGPoint(x: 0, y: 0.70) // 翻转后的终点
//        }
//
//        gradientLayer.frame = self.bounds
//
//        // 将渐变层设置为视图的遮罩
//        self.layer.mask = gradientLayer
//    }

    //上下都有遮罩效果
    func setTableGradientLayer() {
        // 创建顶部渐变层
        let topGradientLayer = CAGradientLayer()
        topGradientLayer.colors = [
            UIColor(white: 0, alpha: 0.05).cgColor,
            UIColor(white: 0, alpha: 1.0).cgColor
        ]
        topGradientLayer.locations = [0.0, 0.4] // 设置颜色的范围
        topGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        topGradientLayer.endPoint = CGPoint(x: 0, y: 0.3)
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height / 2)

        // 创建底部渐变层
        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.colors = [
            UIColor(white: 0, alpha: 1.0).cgColor,
            UIColor(white: 0, alpha: 0.05).cgColor
        ]
        bottomGradientLayer.locations = [0.6, 1.0] // 设置颜色的范围
        bottomGradientLayer.startPoint = CGPoint(x: 0, y: 0.7)
        bottomGradientLayer.endPoint = CGPoint(x: 0, y: 1)
        bottomGradientLayer.frame = CGRect(x: 0, y: self.bounds.height / 2, width: self.bounds.width, height: self.bounds.height / 2)

        // 创建一个容器图层容纳所有渐变层
        let containerLayer = CALayer()
        containerLayer.frame = self.bounds
        containerLayer.addSublayer(topGradientLayer)
        containerLayer.addSublayer(bottomGradientLayer)

        // 将容器图层设置为视图的遮罩
        self.layer.mask = containerLayer
    }

}
