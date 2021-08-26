//
//  NameSearchView.swift
//  Hercircle
//
//  Created by Apple on 06/08/21.
//

import UIKit


class NameSearchView: UIView {
    @IBOutlet weak var searchResultTbl: UITableView!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    class func registerNameSearchView() -> NameSearchView {
        return UINib(nibName: "NameSearchView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NameSearchView
    }
}
