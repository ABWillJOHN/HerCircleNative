//
//  LifeStyleFooterView.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit
protocol LifeStyleFooterViewDelegate {
    func tapOnNextBtn()
}

class LifeStyleFooterView: UIView {

    @IBOutlet weak var nextButton: UIButton!
  
    @IBOutlet weak var birthTitleLbl: UILabel!
    
    @IBOutlet weak var datepickerBaseView: UIView!
    
    @IBOutlet weak var dateBtn: UIButton!
    
    @IBOutlet weak var dateResultLbl: UILabel!
    
    var delegate: LifeStyleFooterViewDelegate?

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    class func LifestyleFooterNib() -> LifeStyleFooterView {
        return UINib(nibName: "LifeStyleFooterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LifeStyleFooterView
    }
    
    @IBAction func actionNextBtn(sender: UIButton){
        self.delegate?.tapOnNextBtn()
    }

}
