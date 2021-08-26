//
//  StackButton.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/16/21.
//

import UIKit

class StackButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 8
        contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    

}
