//
//  TodayTopicCVCell.swift
//  hercircle
//
//  Created by Keyur Baravaliya on 19/07/21.
//

import UIKit

class TodayTopicCVCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAuthornameAndTime: UILabel!
    
    var onTapMoreAction:(()->())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    
    @IBAction func btnMoreAction(_ sender: UIButton) {
        if let getOnTapMoreAction = self.onTapMoreAction {
            getOnTapMoreAction()
        }
    }
}
