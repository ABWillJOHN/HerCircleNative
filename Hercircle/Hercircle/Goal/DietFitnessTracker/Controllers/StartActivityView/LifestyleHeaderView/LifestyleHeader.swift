//
//  LifestyleHeader.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit

class LifestyleHeader: UIView {
    @IBOutlet weak var lifestyleHeaderTitle: UILabel!
    
    @IBOutlet weak var liufestyledesLbl: UILabel!
    
    @IBOutlet weak var arrowBtn: UIButton!
    
    @IBOutlet weak var weightSegmentCOntrol: UISegmentedControl!
    
    @IBOutlet weak var seperatorLbl: UILabel!

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    
    class func LifestyleHeaderNib() -> LifestyleHeader {
        return UINib(nibName: "LifestyleHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LifestyleHeader
    }

}
