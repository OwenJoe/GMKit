//
//  GMTextFieldExt.swift
//  Gimme
//
//  Created by hule on 2024/6/4.
//

extension UITextField {
    
    func setPlaceholder(text: String, color: UIColor, fontSize: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
}
