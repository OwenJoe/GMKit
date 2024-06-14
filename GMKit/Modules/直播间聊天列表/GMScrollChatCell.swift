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
        myLabel.text = "3143213143214314331432143143314321431433143214314331432143143314321431433143214314331432143143314321431433143214314331432143143314321431433143214314343143Warning once"
        self.addSubview(myLabel)
        myLabel.snp.makeConstraints {
            $0.left.top.equalTo(cellSpace)
            $0.right.bottom.equalTo(-cellSpace)
        }
    }
}


