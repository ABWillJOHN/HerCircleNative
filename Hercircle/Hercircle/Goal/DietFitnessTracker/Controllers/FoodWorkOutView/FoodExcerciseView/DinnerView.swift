//
//  DinnerView.swift
//  Hercircle
//
//  Created by Apple on 05/08/21.
//

import UIKit

class DinnerView: UIView {

    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var dateValueLbl: UILabel!
    
    @IBOutlet weak var dinnerTitleLbl: UILabel!
    
    @IBOutlet weak var dateselectBtn: UIButton!
    
    @IBOutlet weak var caloriesBaseView: UIView!
    
    @IBOutlet weak var caloriesLeftLbl: UILabel!
    
    @IBOutlet weak var caloriesValueLbl: UILabel!
    
    @IBOutlet weak var searchBaseView: UIView!
    
    @IBOutlet weak var searchArrowBtn: UIButton!
    
    @IBOutlet weak var searchresultTxtFld: UITextField!
    
    @IBOutlet weak var incrementBtn: UIButton!
    
    @IBOutlet weak var decrementBtn: UIButton!
    
    @IBOutlet weak var quantityResultLbl: UILabel!
    
    @IBOutlet weak var fooodListTbl: UITableView!
    
    @IBOutlet weak var quantityBaseview: UIView!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.setupDinnerView()
    }
   
    
    // MARK:- SETUP DINNER VIEW
    func setupDinnerView() -> Void {
        self.dateValueLbl.textColor = UIColor.darkGray
        self.dateselectBtn.layer.cornerRadius = 8.0
        self.caloriesBaseView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
        self.caloriesBaseView.layer.cornerRadius = 8.0
        self.searchBaseView.layer.borderWidth = 1.0
        self.searchBaseView.layer.borderColor = UIColor.systemGreen.cgColor
        self.searchBaseView.layer.cornerRadius = 8.0
        self.quantityBaseview.layer.cornerRadius = 8.0
        self.quantityBaseview.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
    }

    class func instanceFromNib() -> DinnerView {
        return UINib(nibName: "DinnerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DinnerView
    }

}
