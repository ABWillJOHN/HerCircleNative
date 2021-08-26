//
//  HomeTBVFooter.swift
//  hercircle
//
//  Created by Keyur Baravaliya on 19/07/21.
//

import UIKit

class HomeTBVFooter: UITableViewHeaderFooterView {
    
    
    var onTapDownArrrow:(()->())? = nil
    var onTapViewAll:(()->())? = nil
    
    @IBAction func btnDownAction(_ sender: UIButton) {
        if let downAct = self.onTapDownArrrow {
            downAct()
        }
    }
    
    @IBAction func btnViewAllAction(_ sender: UIButton) {
        if let viewAllAct = self.onTapViewAll {
            viewAllAct()
        }
    }

}
