//
//  GMAlertController.swift
//  Gimme
//
//  Created by hule on 2024/5/28.
//

import UIKit

class GMAlertController  {
    
    static func showAlert(title: String?,
                          message: String?,
                          titleColor: UIColor? = nil,
                          messageColor: UIColor? = nil,
                          backgroundColor: UIColor? = nil,
                          preferredStyle: UIAlertController.Style = .alert,
                          actions: [(String, UIAlertAction.Style, UIColor?, UIColor?, ((UIAlertAction) -> Void)?)] = [("OK", .default, nil, nil, nil)]) {
        
        guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
            print("Error: Unable to find root view controller")
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if let title = title, let titleColor = titleColor {
            let titleAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            let titleString = NSAttributedString(string: title, attributes: titleAttributes)
            alert.setValue(titleString, forKey: "attributedTitle")
        }
        
        if let message = message, let messageColor = messageColor {
            let messageAttributes = [NSAttributedString.Key.foregroundColor: messageColor]
            let messageString = NSAttributedString(string: message, attributes: messageAttributes)
            alert.setValue(messageString, forKey: "attributedMessage")
        }
        
        if let backgroundColor = backgroundColor {
            let backView = alert.view.subviews.first?.subviews.first?.subviews.first
            backView?.backgroundColor = backgroundColor
        }
        
        for actionInfo in actions {
            let action = UIAlertAction(title: actionInfo.0, style: actionInfo.1, handler: actionInfo.4)
            alert.addAction(action)
            
            if let textColor = actionInfo.3 {
                action.setValue(textColor, forKey: "titleTextColor")
            }
        }
        
        viewController.present(alert, animated: true, completion: {
            for actionInfo in actions {
                if let bgColor = actionInfo.2 {
                    for subview in alert.view.subviews.first?.subviews.first?.subviews.first?.subviews ?? [] {
                        if let button = subview as? UIButton, button.titleLabel?.text == actionInfo.0 {
                            button.backgroundColor = bgColor
                            button.setTitleColor(actionInfo.3, for: .normal)
                        }
                    }
                }
            }
        })
    }
}
