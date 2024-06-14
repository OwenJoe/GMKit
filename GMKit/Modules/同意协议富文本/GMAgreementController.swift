//
//  GMAgreementController.swift
//  GMKit
//
//  Created by hule on 2024/6/14.
//

import UIKit

class GMAgreementController: GMBaseViewController {
    var label = YYLabel()
    var isImageSelected: Bool = false //同意按钮是否被点击
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAgree()
    }
  
    func setupAgree () {
        
        label = YYLabel.init(frame: CGRectMake(18, 200, ScreenWidth - 36, 60))
        label.numberOfLines = 0
        label.textVerticalAlignment = .center;
        label.textColor = .white
        self.view.addSubview(label)
        
        // 富文本字符串
        let textContent = " Have read and agree《Account cancellation notice and account cancellation Agreement》"
        let text1 = "《Account cancellation notice and account cancellation Agreement》"
        let text = NSMutableAttributedString(string: textContent)
        
        // 设置默认文本颜色为白色
        text.yy_color = .white
        
        // 初始图片
        let initialImage = UIImage(named: "unselect")!
        let selectedImage = UIImage(named: "select")!
        
        // 插入图片
        let imageAttachment = NSMutableAttributedString.yy_attachmentString(withContent: initialImage, contentMode: .center, attachmentSize: CGSize(width: 12, height: 12), alignTo: UIFont.systemFont(ofSize: 14), alignment: .center)
        text.insert(imageAttachment, at: 0) // 在文本前插入图片
        
        // 为图片设置点击效果
        let imageRange = NSRange(location: 0, length: imageAttachment.length)
        text.yy_setTextHighlight(imageRange, color: nil, backgroundColor: .clear) { [weak self] view, str, range, frame in
            guard let self = self else { return }
            
            print("点击了图片")
            self.isImageSelected.toggle()
            // 更新图片显示
            let newImage = self.isImageSelected ? selectedImage : initialImage
            let newImageAttachment = NSMutableAttributedString.yy_attachmentString(withContent: newImage, contentMode: .center, attachmentSize: CGSize(width: 12, height: 12), alignTo: UIFont.systemFont(ofSize: 14), alignment: .center)
            
            // 替换旧图片
            text.replaceCharacters(in: imageRange, with: newImageAttachment)
            
            // 更新YYLabel的文本
            self.updateLabelText(text)
        }
        
        // 设置高亮
        
        // 插入图片后，需要手动调整高亮部分的索引
        let adjustedRangeLocation = imageAttachment.length + (textContent as NSString).range(of: text1).location
        let adjustedNsRange = NSRange(location: adjustedRangeLocation, length: text1.count)
        
        // 设置高亮
        text.yy_setTextHighlight(adjustedNsRange, color: HexString("#F001FF"), backgroundColor: .clear) { [weak self] view, str, range, frame in
          print("点击了高亮协议部分")

        }
        
        // 设置行间距和字体
        text.yy_lineSpacing = 8
        text.yy_font = UIFont.systemFont(ofSize: 14)
        
        // 设置富文本到 YYLabel
        label.attributedText = text
    }
    
    
    // 更新 YYLabel 的文本并重新设置点击效果
    func updateLabelText(_ text: NSMutableAttributedString) {
        let imageRange = NSRange(location: 0, length: 1)
        text.yy_setTextHighlight(imageRange, color: nil, backgroundColor: .clear) { [weak self] view, str, range, frame in
            guard let self = self else { return }
            self.isImageSelected.toggle()
            
            
            // 更新图片显示
            let newImage = self.isImageSelected ? UIImage(named: "select")! : UIImage(named: "unselect")!
            let newImageAttachment = NSMutableAttributedString.yy_attachmentString(withContent: newImage, contentMode: .center, attachmentSize: CGSize(width: 12, height: 12), alignTo: UIFont.systemFont(ofSize: 14), alignment: .center)
            
            // 替换旧图片
            text.replaceCharacters(in: imageRange, with: newImageAttachment)
            
            // 更新YYLabel的文本
            self.updateLabelText(text)
        }
        text.yy_lineSpacing = 8
        label.attributedText = text
    }

}
