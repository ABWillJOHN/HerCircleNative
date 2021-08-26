//
//  HeaderCollectionReusableView.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var headerBaseview: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
        @IBOutlet weak var caloriesLeftLbl: UILabel!
    @IBOutlet weak var caloriesLeftrValue: UILabel!
    @IBOutlet weak var recommendedLbl: UILabel!
    @IBOutlet weak var recommendedValueLbl: UILabel!
    @IBOutlet weak var caloriesConsumedLbl: UILabel!
    @IBOutlet weak var caloriesIncrementButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
