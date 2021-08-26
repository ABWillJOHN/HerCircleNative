//
//  CustomFooter.swift
//  Hercircle
//
//  Created by Apple on 06/08/21.
//

import UIKit

class CustomFooter: UIView {
    @IBOutlet weak var submitBtn: UIButton!
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.submitBtn.layer.cornerRadius = 8.0
        self.submitBtn.setTitle("Submit", for: .normal)
        self.submitBtn.setTitleColor(UIColor.white, for: .normal)
    }
    
    class func CustomFooterinstanceFromNib() -> CustomFooter {
        return UINib(nibName: "CustomFooter", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomFooter
    }

}
