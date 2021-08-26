//
//  DropDownButton.swift
//  Hercircle
//
//  Created by Abhinav.prashar on 25/08/21.
//

import UIKit

class DropDownButton: UIView {


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    class func LifestyleFooterNib() -> LifeStyleFooterView {
        return UINib(nibName: "DropDownButton", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DropDownButton
    }
    


}
