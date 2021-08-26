//
//  DetailsDairyTableViewCell.swift
//  Hercircle
//
//  Created by Abhinav.prashar on 22/08/21.
//

import UIKit

class DetailsDairyTableViewCell: UITableViewCell {
    @IBOutlet weak var categoriesContainView1: UIView!
    @IBOutlet weak var categoriesContainView2: UIView!
    @IBOutlet weak var categoriesContainView3: UIView!
    @IBOutlet weak var categoriesContainView4: UIView!
    @IBOutlet weak var mealLunchContainView: UIView!
    @IBOutlet weak var mealBreakFastContainView: UIView!
    @IBOutlet weak var mealDinnerContainView: UIView!
    @IBOutlet weak var mealSnacksContainView: UIView!
    var redirectToViewProtocol:RedirectToViewProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    @IBAction func redirectToView(sender: UIControl) {
//        redirectToViewProtocol?.redirectToView(sender: sender)
//    }
    @IBAction func redirectToView(_ sender: UIControl) {
        redirectToViewProtocol?.redirectToView(sender: sender)
    }
}
