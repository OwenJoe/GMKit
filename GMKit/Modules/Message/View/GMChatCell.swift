//
//  GMChatCell.swift
//  Gimme
//
//  Created by hule on 2024/5/24.
//

import UIKit

class GMChatCell: UITableViewCell {


    @IBOutlet weak var includeView: UIView!
    var model: GMChatModel? {
        didSet {
            
            iconView.kf.setImage(with: URL(string:  model?.pic ?? "logo"),placeholder: UIImage(named: "logo"))
            contentLabel.text = model?.content
            if model?.type == .mySelf{
                //适配阿拉伯语系  会用到类似这个特性 semanticContentAttribute 将对象都用容器包装起来
                includeView.semanticContentAttribute = .forceRightToLeft
                iconView.kf.setImage(with: URL(string: "https://a.520gexing.com/uploads/allimg/2021052407/rjyw1w1jihr.jpg"))
            }
            chatBgView.image = model?.type == .mySelf ? UIImage(named: "chat_right")?.stretchableImage()  : UIImage(named: "chat_left")?.stretchableImage()
            
        }
    }
    @IBOutlet weak var chatBgView: UIImageView! //聊天气泡
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = 40 / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
