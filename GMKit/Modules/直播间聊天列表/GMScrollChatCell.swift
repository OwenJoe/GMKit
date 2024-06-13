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
        self.layer.cornerRadius = 4
    }

    
    
}
