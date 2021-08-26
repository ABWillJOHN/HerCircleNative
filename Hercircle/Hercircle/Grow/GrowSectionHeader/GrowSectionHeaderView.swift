//
//  GrowSectionHeaderView.swift
//  Hercircle
//
//  Created by vivekp on 16/07/21.
//

import UIKit



class GrowSectionHeaderView: UITableViewHeaderFooterView {

    //MARK:- IBOutlets

    @IBOutlet weak var lblFirstHeading: UILabel!
    @IBOutlet weak var lblSecondHeading: UILabel!
    
    
    //MARK:- Variables
    static let reuseIdentifier = "GrowSectionHeaderView"

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

}
