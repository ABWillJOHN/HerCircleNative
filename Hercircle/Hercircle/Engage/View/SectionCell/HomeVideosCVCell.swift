//
//  HomeVideosCVCell.swift
//  hercircle
//
//  Created by Keyur Baravaliya on 20/07/21.
//

import UIKit

class HomeVideosCVCell: UICollectionViewCell {

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var videoImgView: UIImageView!
    @IBOutlet weak var lblVideoTiming: UILabel!
    @IBOutlet weak var lblNameAndTime: UILabel!
    
    var onTapPlayAction:(()->())? = nil
    var onTapMoreAction:(()->())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnPlayAction(_ sender: UIButton) {
        if let getPlayAct = self.onTapPlayAction {
            getPlayAct()
        }
    }
    
    @IBAction func btnMoreAction(_ sender: UIButton) {
        if let getMoreAct = self.onTapMoreAction {
            getMoreAct()
        }
    }
}
