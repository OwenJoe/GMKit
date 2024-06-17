//
//  GMTextFieldExt.swift
//  Gimme
//
//  Created by hule on 2024/6/4.
//

extension UITextField {
    
    //颜色替换
    func setPlaceholder(text: String, color: UIColor, fontSize: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
    //判断是否为空,特别是多个textField好使
    func getIsEmpty() -> String? {
        if text!.isEmpty {
            return "This field is required."
        } else {
            return nil
        }
    }
}
