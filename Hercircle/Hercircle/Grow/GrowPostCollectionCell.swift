//
//  GrowPostCollectionCell.swift
//  Hercircle
//
//  Created by vivekp on 18/07/21.
//

import UIKit

class GrowPostCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTilte: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnshare: UIButton!
    @IBOutlet weak var btnBookmark: UIButton!
   
    var arrBookMarks : [BookMarksList]? {
        didSet {
            arrBookMarks?.forEach({ bookMarkModel in
                if (model?.jobid == bookMarkModel.jobID){
                    self.btnBookmark.setImage(bookMarkModel.isBook == true ? UIImage.init(named: "Group") : UIImage.init(named: "bookmark"), for: .normal)
                }
            })
        }
    }
    var model : GrowJobsListing? {
        didSet {
            self.btnApply.isUserInteractionEnabled = /model?.isJobApplied == true ? false : true
            self.btnApply.setTitleColor(/model?.isJobApplied == true ? UIColor.white : UIColor.systemPink, for: .normal)
            self.btnApply.backgroundColor = /model?.isJobApplied == true ? UIColor.systemPink : UIColor.white
            self.btnBookmark.setImage(/model?.isBook == true ? UIImage.init(named: "Group") : UIImage.init(named: "bookmark"), for: .normal)
            self.lblTilte.text = /model?.titleHeader
            self.lblLocation.text = /model?.location
        }
    }
}
