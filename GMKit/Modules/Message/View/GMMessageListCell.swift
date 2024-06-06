//
//  GMMessageListCell.swift
//  Gimme
//
//  Created by hule on 2024/5/24.
//

import UIKit

class GMMessageListCell: UITableViewCell {

    var model: GMChatModel? {
        didSet {
            countButton.isHidden = true
            nameLabel.text = model?.name
            timeLabel.text = model?.time
            contentLabel.text = model?.recent
            iconView.kf.setImage(with: URL(string:  model?.pic ?? "logo"),placeholder: UIImage(named: "logo"))
        }
    }
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        countButton.layer.masksToBounds = true
        countButton.layer.cornerRadius = 20 / 2
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = 48 / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
