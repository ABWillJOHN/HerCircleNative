//
//  LifeStyleView.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit

class LifeStyleView: UIView {

    @IBOutlet weak var backBTn: UIButton!
    
    @IBOutlet weak var stepTitleLbl: UILabel!
    
    @IBOutlet weak var lifestyleTblView: UITableView!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    class func LifestyleNib() -> LifeStyleView {
        return UINib(nibName: "LifeStyleView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LifeStyleView
    }

}
