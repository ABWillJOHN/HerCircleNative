//
//  DiaryView.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit

class DiaryView: UIView {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var diaryCollectionView: UICollectionView!
    
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var dateValueLbl: UILabel!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    class func DiaryviewinstanceFromNib() -> DiaryView {
        return UINib(nibName: "DiaryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DiaryView
    }


}
