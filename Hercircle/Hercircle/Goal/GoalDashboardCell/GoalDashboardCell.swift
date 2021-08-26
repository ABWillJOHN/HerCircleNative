//
//  GoalDashboardCell.swift
//  Hercircle
//
//  Created by Apple on 02/08/21.
//

import UIKit

class GoalDashboardCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTracker: UILabel!
    @IBOutlet weak var lblFullNm: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
