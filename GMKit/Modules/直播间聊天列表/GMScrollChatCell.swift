//
//  GMScrollChatCell.swift
//  GMKit
//
//  Created by hule on 2024/6/13.
//

import UIKit

let GMScrollChatCellKey = "GMScrollChatCell"
class GMScrollChatCell: UITableViewCell {
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(white: 0, alpha: 0.2)
        setupUI()
        
    }
    
    //初始化UI
    func setupUI()  {
        let tableViewWidth = 250.0
        let cellSpace = 12.0
        let myLabel = YYLabel()
        myLabel.textVerticalAlignment = .center
        /*
         一定要设置preferredMaxLayoutWidth 换行才有效,另外250这个值跟tableView的宽度和Cell都有关系,
         这里250表示tableView宽度是250
         这里24 表示文字在cell的左右间距分别是12,两个加起来就是24
         */
        myLabel.preferredMaxLayoutWidth = tableViewWidth - cellSpace * 2
        myLabel.numberOfLines = 0
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(myLabel)
        myLabel.snp.makeConstraints {
            $0.left.top.equalTo(cellSpace)
            $0.right.bottom.equalTo(-cellSpace)
        }
        
        let elements = [
            GMRichTextElement(type: .text(content: "This is some text ", color: .black, font: .systemFont(ofSize: 14), isClickable: true)),
            GMRichTextElement(type: .image(image: UIImage(named: "高兴表情") ?? UIImage(named: ""), size: CGSize(width: 12, height: 12), isClickable: true)),
            GMRichTextElement(type: .text(content: " and more text", color: .red, font: .boldSystemFont(ofSize: 16), isClickable: false)),
            GMRichTextElement(type: .image(image: UIImage(named: "会员等级") ?? UIImage(named: ""), size: CGSize(width: 16, height: 12), isClickable: true)),
            GMRichTextElement(type: .text(content: "我又不吃美团我又不吃美团我又不吃美团我又不吃美团我又不吃美团我又不吃美团我又不吃美团我又不吃美团我又不吃美团我又不吃美团我又不吃美团我又不吃美团-->结束", color: .black, font: .systemFont(ofSize: 22), isClickable: true)),
        ]

        configure(with: elements, myLabel: myLabel)
    }
    
    func configure(with elements: [GMRichTextElement], myLabel: YYLabel) {
        let attributedString = NSMutableAttributedString()
        
        elements.forEach { element in
            switch element.type {
            case .text(let content, let color, let font, let isClickable):
                let textAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: color,
                    .font: font
                ]
                let attributedText = NSMutableAttributedString(string: content, attributes: textAttributes)
                
                if isClickable {
                    attributedText.yy_setTextHighlight(NSRange(location: 0, length: content.count),
                                                        color: color,
                                                        backgroundColor: .clear) { (view, attrString, range, rect) in
                        print("点击了文字")
                    }
                }
                
                attributedString.append(attributedText)
                
            case .image(let image, let size, let isClickable):
                if let image = image {
                    let imageView = UIImageView(image: image)
                    imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

                    let attachText = NSMutableAttributedString.yy_attachmentString(withContent: imageView, contentMode: .scaleAspectFit, attachmentSize: imageView.bounds.size, alignTo: UIFont.systemFont(ofSize: 100), alignment: .center)

                    if isClickable {
                        let highlight = YYTextHighlight()

                        // 添加点击事件
                        highlight.tapAction = { containerView, text, range, rect in
                            print("点击了图片")
                        }

                        // 将该点击事件添加到富文本中
                        attachText.yy_setTextHighlight(highlight, range: NSRange(location: 0, length: attachText.length))
                    }

                    attributedString.append(attachText)
                }

            }
        }
        
        myLabel.attributedText = attributedString
    }
}

struct GMRichTextElement {
    enum ElementType {
        case text(content: String, color: UIColor, font: UIFont, isClickable: Bool)
        case image(image: UIImage?, size: CGSize, isClickable: Bool)
    }

    var type: ElementType
}
