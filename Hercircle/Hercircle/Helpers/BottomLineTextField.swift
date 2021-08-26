//
//  LineTextField.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/22/21.
//

import UIKit
import JVFloatLabeledTextField

class BottomLineTextField: JVFloatLabeledTextField {
    
    private let color = UIColor(red: 3/255, green: 1/255, blue: 76/255, alpha: 1.0)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setBottomBorder()
        
        guard let placeholderText = placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                   attributes: [NSAttributedString.Key.foregroundColor: color])
        floatingLabelFont = UIFont(name: "MuseoSans-500", size: 12)
        floatingLabelTextColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        floatingLabelActiveTextColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        floatingLabelYPadding = -16
    }
    
    private func setBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: frame.size.height - 1, width: bounds.size.width + 150, height: 1.0)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        
    }

}
