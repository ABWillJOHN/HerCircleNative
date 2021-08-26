//
//  StepOneCustomTableViewCell.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit

class StepOneCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tickBtn: UIButton!
    
    @IBOutlet weak var seperatorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
