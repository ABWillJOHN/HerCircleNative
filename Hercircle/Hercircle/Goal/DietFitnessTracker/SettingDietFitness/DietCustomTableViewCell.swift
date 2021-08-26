//
//  DietCustomTableViewCell.swift
//  Hercircle
//
//  Created by Apple on 15/08/21.
//

import UIKit

class DietCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var qusTitleLbl: UILabel!
    
    @IBOutlet weak var qusDescriptionLbl: UILabel!
    
    @IBOutlet weak var arrowButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
