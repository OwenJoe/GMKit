//
//  GMClearScreenController.swift
//  GMKit
//
//  Created by hule on 2024/6/17.
//

import UIKit

class GMClearScreenController: GMBaseViewController {
    // 直播内容视图
    var contentView: UIView!
    // 覆盖视图
    var overlayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //当前控制器手势侧滑禁止
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    private func setupUI() {
        contentView = UIView(frame: view.bounds)
        contentView.backgroundColor = .white
        view.addSubview(contentView)
        
        let subView01 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        subView01.backgroundColor = .orange
        subView01.addTapGesture {
            print("点击了橘黄色")
        }
        contentView.addSubview(subView01)

        // 创建覆盖视图
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // 半透明黑色
        overlayView.alpha = 0 // 初始时不可见
        view.addSubview(overlayView) // 注意：这里将overlayView添加到self.view上
        
        let subView02 = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        subView02.backgroundColor = .green
        subView02.addTapGesture {
            print("点击了绿色")
        }
        overlayView.addSubview(subView02)
        

        // 添加手势识别器
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture) // 手势识别器添加到self.view上
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)

        switch gesture.state {
        case .began:
            // 手势开始时记录初始状态
            break
        case .changed:
            // 根据滑动方向更新视图位置
            if abs(translation.x) > abs(translation.y) {
                // 允许水平滑动
                // 这里不需要更新contentView的位置，因为手势是在self.view上处理的
            }
        case .ended:
            // 手势结束时判断滑动方向并执行清屏操作
            if velocity.x > 0 {
                // 向右滑动
                // 这里可以添加向右滑动的逻辑，例如隐藏内容
                hideOverlay()
            } else if velocity.x < 0 {
                // 向左滑动
                showOverlay() // 显示覆盖视图
            }
        default:
            break
        }
    }

    private func showOverlay() {
        UIView.animate(withDuration: 0.3) {
            self.overlayView.alpha = 1 // 显示覆盖视图
        }
    }
    
    private func hideOverlay() {
        UIView.animate(withDuration: 0.3) {
            self.overlayView.alpha = 0 // 隐藏覆盖视图
        }
    }
}
