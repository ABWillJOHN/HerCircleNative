//
//  TitleSectionFooter.swift
//  Hercircle
//
//  Created by vishal modem on 7/19/21.
//

import UIKit

class TitleSectionFooter: UICollectionReusableView {
    
    var view: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        return v
    }()
    
    let viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("view all", for: .normal)
        button.setTitleColor(UIColor(r: 126, g: 126, b: 126), for: .normal)
        button.titleLabel?.font = UIFont(name: "MuseoSans-300", size: 12)
        return button
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        view.constrainHeight(constant: 2)
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                UIView(),
                viewAllButton
            ]),
            view
        ])
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SectionFooter: UICollectionReusableView {
    
    let view: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        return v
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(view)
        view.constrainHeight(constant: 2)
        view.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
