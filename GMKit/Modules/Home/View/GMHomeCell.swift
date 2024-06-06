//
//  GMHomeCell.swift
//  GMKit
//
//  Created by hule on 2024/6/6.
//

import UIKit

let GMHomeCellID = "GMHomeCell"
class GMHomeCell: UITableViewCell {

    var rowStr: String?
    var model: GMHomeModel? {
        didSet {
            //questionLabel.text = model?.content
            guard let rowStr = rowStr, let content = model?.content else {
                return
            }
            questionLabel.text = "\(rowStr) -->\(content)"
        }
    }


    @IBOutlet weak var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         questionLabel.textColor = .black
    }


    
}
