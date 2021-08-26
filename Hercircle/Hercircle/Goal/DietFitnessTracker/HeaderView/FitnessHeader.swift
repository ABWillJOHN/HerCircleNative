//
//  FitnessHeader.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit
protocol FitnessHeaderDelegate {
    func topTabOptions(strAccess: String)
}

class FitnessHeader: UIView {
    @IBOutlet weak var btnBurger: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnDiary: UIButton!
    @IBOutlet weak var btnInSights: UIButton!
    @IBOutlet weak var btnCommunities: UIButton!
    @IBOutlet weak var btnAnalytics: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    var delegate: FitnessHeaderDelegate!


    @IBAction func topActionPerformed(sender: UIButton) {
        self.delegate.topTabOptions(strAccess: sender.accessibilityIdentifier!)
    }

   
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
   
    class func instanceFromNib() -> FitnessHeader {
        return UINib(nibName: "FitnessHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FitnessHeader
    }
    

}
