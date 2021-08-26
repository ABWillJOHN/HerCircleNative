//
//  TileCellCollectionViewCell.swift
//  Hercircle
//
//  Created by Apple on 15/07/21.
//

import UIKit

protocol TileCellCollectionViewCellDelegate: AnyObject {
    func callAskExpertView(btn: UIButton)
}

class TileCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDisc: UILabel!
    @IBOutlet weak var btnDisc: UIButton!
    
    @IBOutlet weak var viewBack: UIView!
    weak var delegate: TileCellCollectionViewCellDelegate?


    override func awakeFromNib() {
        super.awakeFromNib()
        viewBack.layer.cornerRadius = 10;
        viewBack.layer.masksToBounds = true;

        viewBack.layer.borderColor = UIColor.systemGray.cgColor;
        viewBack.layer.borderWidth = 0.5;
        // Initialization code
    }
    
    @IBAction func actionAskExpert(sender: UIButton) {
        self.delegate?.callAskExpertView(btn: sender)
    }

}
