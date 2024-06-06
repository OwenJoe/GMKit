//
//  GMChatSendView.swift
//  Gimme
//
//  Created by hule on 2024/5/24.
//

import UIKit

class GMChatSendView: UIView, UITextViewDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    var sendClouse: ((String?) -> Void)?
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var mesagTextView: UITextView!
    @IBOutlet weak var includeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        includeView.layer.masksToBounds = true
        includeView.layer.cornerRadius = 4
        mesagTextView.delegate = self
        sendButton.addTapGesture { [weak self] in
            
            if  Int32(self?.mesagTextView.text.count ?? 0) > 0 {
                
                self?.sendClouse?(self?.mesagTextView.text ?? "")
                self?.mesagTextView.text = ""
                self?.tipLabel.isHidden = false
            }
            
        }
    }
    
    // 当文本视图的文本发生更改时调用
    func textViewDidChange(_ textView: UITextView) {
//        print("Text changed: \(textView.text ?? "")")
        tipLabel.isHidden = textView.text.count > 0 ? true : false
    }
}
