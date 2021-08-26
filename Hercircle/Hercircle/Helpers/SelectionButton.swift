//
//  SelectionButton.swift
//  Hercircle
//
//  Created by vishal modem on 6/30/21.
//

import UIKit

class SelectionButton: UIButton {
    
    var hasCheckMark = false {
        didSet {
            if hasCheckMark {
                backgroundColor = UIColor(red: 85/255, green: 29/255, blue: 200/255, alpha: 1.0)
                setTitle("✓", for: .normal)
                setTitleColor(.white, for: .normal)
            } else {
                backgroundColor = .white
                setTitle("", for: .normal)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0).cgColor
        layer.cornerRadius = 4
    }

}
