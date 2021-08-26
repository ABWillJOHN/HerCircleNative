//
//  ListCollectionViewCell.swift
//  Hercircle
//
//  Created by Apple on 16/07/21.
//

import UIKit

protocol ListCollectionViewCellDelegate: AnyObject {
    func callAskExpertViewFromList(btn: UIButton)
}

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblNm: UILabel?
    @IBOutlet weak var lblDiscrip: UILabel?
    @IBOutlet weak var imgVw: UIImageView?
    @IBOutlet weak var btnChat: UIButton?
    weak var delegate: ListCollectionViewCellDelegate?
    
    @IBAction func actionAskExpertView(sender: UIButton) {
        self.delegate?.callAskExpertViewFromList(btn: sender)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
