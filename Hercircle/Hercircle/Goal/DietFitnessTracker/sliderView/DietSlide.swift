//
//  DietSlide.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit
protocol DietSlideDelegate {
    func moveToStepSelect()
}

class DietSlide: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sliderScrollview: UIScrollView!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var slidePageControl: UIPageControl!
    
    var delegate: DietSlideDelegate?
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
   
    class func instanceFromNib() -> DietSlide {
        return UINib(nibName: "DietSlide", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DietSlide
    }
    
    @IBAction func moveToStep (sender: UIButton) {
        self.delegate?.moveToStepSelect()
    }
    

}
