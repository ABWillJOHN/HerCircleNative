//
//  AnalyticsTBVCell.swift
//  Hercircle
//
//  Created by Apple on 13/08/21.
//

import UIKit

class AnalyticsTBVCell: UITableViewCell {

    @IBOutlet weak var mainContainView: UIView!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainContainView.addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
