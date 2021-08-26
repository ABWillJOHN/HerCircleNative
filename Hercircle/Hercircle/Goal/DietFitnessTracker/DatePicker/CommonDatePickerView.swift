//
//  CommonDatePickerView.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit

class CommonDatePickerView: UIView {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var mydatepicker: UIDatePicker!
    @IBOutlet weak var doneBtn: UIButton!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    
    class func commonDatePickerNib() -> CommonDatePickerView {
        return UINib(nibName: "CommonDatePickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CommonDatePickerView
    }

}
