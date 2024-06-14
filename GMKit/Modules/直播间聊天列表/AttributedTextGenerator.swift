import UIKit

// 定义富文本元素类型
enum RichTextElementType {
    case text(String, UIFont, UIColor, CGFloat, Bool)
    case image(UIImage, CGSize, CGFloat, Bool)
    
    init(text: String, font: UIFont = UIFont.systemFont(ofSize: 14), color: UIColor = UIColor.black, trailingPadding: CGFloat = 0, isClickable: Bool = true) {
        self = .text(text, font, color, trailingPadding, isClickable)
    }
    
    init(image: UIImage, size: CGSize, trailingPadding: CGFloat = 0, isClickable: Bool = true) {
        self = .image(image, size, trailingPadding, isClickable)
    }
}

// 定义富文本元素结构体
struct RichTextElement {
    let type: RichTextElementType
    
    // 提供一个简便的初始化方法
    init(text: String, font: UIFont = UIFont.systemFont(ofSize: 14), color: UIColor = UIColor.black, trailingPadding: CGFloat = 0, isClickable: Bool = true) {
        self.type = .text(text, font, color, trailingPadding, isClickable)
    }
    
    init(image: UIImage, size: CGSize, trailingPadding: CGFloat = 0, isClickable: Bool = true) {
        self.type = .image(image, size, trailingPadding, isClickable)
    }
}

// 定义富文本视图类
class RichTextView: UITextView, UITextViewDelegate {

    // 点击回调
    var clickCallback: ((RichTextElement) -> Void)?
    
    // 初始化
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextView()
    }
    
    // 设置UITextView属性
    private func setupTextView() {
        isEditable = false
        isScrollEnabled = false
        delegate = self
        isUserInteractionEnabled = true
        textContainer.lineFragmentPadding = 0
        textContainerInset = .zero
    }
    
    // 配置富文本
    func configure(with elements: [RichTextElement]) {
        let attributedString = NSMutableAttributedString()
        
        for element in elements {
            switch element.type {
            case .text(let text, let font, let color, let trailingPadding, let isClickable):
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: font,
                    .foregroundColor: color
                ]
                let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
                if isClickable {
                    // 给可点击文本添加点击事件
                    let range = NSRange(location: 0, length: attributedText.length)
                    attributedText.addAttribute(.link, value: "text://\(text)", range: range)
                }
                attributedString.append(attributedText)
                attributedString.append(NSAttributedString(string: String(repeating: " ", count: Int(trailingPadding))))
                
            case .image(let image, let size, let trailingPadding, let isClickable):
                let attachment = NSTextAttachment()
                attachment.image = image
                attachment.bounds = CGRect(origin: .zero, size: size)
                let imageString = NSMutableAttributedString(attachment: attachment)
                if isClickable {
                    // 给可点击图片添加点击事件
                    let range = NSRange(location: 0, length: imageString.length)
                    imageString.addAttribute(.link, value: "image://\(image.hashValue)", range: range)
                }
                attributedString.append(imageString)
                attributedString.append(NSAttributedString(string: String(repeating: " ", count: Int(trailingPadding))))
            }
        }
        
        self.attributedText = attributedString
    }
    
    // UITextViewDelegate方法处理点击事件
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let scheme = URL.scheme ?? ""
        switch scheme {
        case "text":
            if let text = URL.host {
                let element = RichTextElement(text: text)
                clickCallback?(element)
            }
        case "image":
            if let imageHashValue = URL.host, let hashValue = Int(imageHashValue) {
                // 在这里你可以根据 hashValue 找到对应的图片
                // 由于 hashValue 不能唯一标识 UIImage, 你可以在 RichTextElement 中保存图片的唯一标识符
                // clickCallback?(.image(找到的图片, size: CGSize.zero, trailingPadding: 0, isClickable: true))
            }
        default:
            break
        }
        return false
    }
}
