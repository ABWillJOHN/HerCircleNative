//
//  DinnerListTableViewCell.swift
//  Hercircle
//
//  Created by Apple on 05/08/21.
//

import UIKit
protocol DinnerListTableViewCellDelegate {
    func setQuantity(btn: UIButton)
}

class DinnerListTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var btnIncrement: UIButton!
    @IBOutlet weak var btnDecrement: UIButton!
    var delegate: DinnerListTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnAction(sender: UIButton){
        self.delegate?.setQuantity(btn: sender)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
