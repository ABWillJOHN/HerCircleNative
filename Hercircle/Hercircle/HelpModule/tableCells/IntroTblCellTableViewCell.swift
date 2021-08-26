//
//  IntroTblCellTableViewCell.swift
//  Hercircle
//
//  Created by Apple on 16/07/21.
//

import UIKit

class IntroTblCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblNm: UILabel!
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var lblSpecialities: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor.gray.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
