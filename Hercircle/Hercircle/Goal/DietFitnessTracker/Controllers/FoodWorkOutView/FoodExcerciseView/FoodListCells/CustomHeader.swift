//
//  CustomHeader.swift
//  Hercircle
//
//  Created by Gaurav on 05/08/21.
//

import UIKit

class CustomHeader: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    
    class func CustomHeaderinstanceFromNib() -> CustomHeader {
        return UINib(nibName: "CustomHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomHeader
    }

}
