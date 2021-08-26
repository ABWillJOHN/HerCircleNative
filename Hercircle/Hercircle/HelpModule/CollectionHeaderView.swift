//
//  CollectionHeaderView.swift
//  Hercircle
//
//  Created by Apple on 15/07/21.
//

import UIKit

protocol CollectionHeaderViewDelegate: AnyObject {
   
    
    func setTileView(btn: UIButton)
    func setGridView(btn: UIButton)
}

class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var btnTile: UIButton!
    @IBOutlet weak var btnList: UIButton!
    weak var delegate: CollectionHeaderViewDelegate?
    
    @IBAction func actionTileView(sender: UIButton) {
        self.delegate?.setTileView(btn: sender)
    }
    
    @IBAction func actionGridView(sender: UIButton) {
        self.delegate?.setGridView(btn: sender)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
