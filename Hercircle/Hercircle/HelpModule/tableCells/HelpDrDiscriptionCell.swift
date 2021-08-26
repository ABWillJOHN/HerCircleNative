//
//  HelpDrDiscriptionCell.swift
//  Hercircle
//
//  Created by Apple on 16/07/21.
//

import UIKit

class HelpDrDiscriptionCell: UITableViewCell {
    
    @IBOutlet weak var topMarginView: UIView!
    @IBOutlet weak var bottomMarginView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDiscription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
