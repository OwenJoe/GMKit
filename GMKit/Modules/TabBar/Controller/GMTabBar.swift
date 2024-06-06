//
//  GMTabBar.swift
//  Gimme
//
//  Created by hule on 2024/5/23.
//

import UIKit

class GMTabBar: UITabBar {
    private var backgroundImageView: UIImageView?

      override func layoutSubviews() {
          super.layoutSubviews()

          if backgroundImageView == nil {
              if let backgroundImage = UIImage(named: "tap") {
                  backgroundImageView = UIImageView(image: backgroundImage)
                  backgroundImageView!.frame = bounds
                  insertSubview(backgroundImageView!, at: 0)
              }
          }

      }
    



      override func draw(_ rect: CGRect) {
          // 可以在这里对 TabBar 进行额外的绘制
      }
    

}
