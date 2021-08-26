//
//  LifeStyleTableViewCell.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit

class LifeStyleTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var weightInputTxtFld: UITextField!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var seperatorLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
