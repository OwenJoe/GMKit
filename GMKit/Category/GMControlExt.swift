//
//  GMControlExt.swift
//  Gimmi
//
//  Created by hule on 2024/4/28.
//

//import UIKit

import UIKit

class TapHandler {
    static var actions = [UIView: () -> Void]()
    
    static func addTapGesture(to view: UIView, action: @escaping () -> Void) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        actions[view] = action
    }
    
    @objc private static func handleTap(_ gesture: UITapGestureRecognizer) {
        if let view = gesture.view, let action = actions[view] {
            action()
        }
    }
}

extension UIView {
    func addTapGesture(action: @escaping () -> Void) {
        TapHandler.addTapGesture(to: self, action: action)
    }
}
