//
//  HeaderViewCollectionReusableView.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let headerVC = HeaderVC()
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerVC.view)
        addSubview(line)
        headerVC.view.anchor(top: nil, leading: leadingAnchor, bottom: line.bottomAnchor, trailing: trailingAnchor, size: CGSize(width: frame.width, height: frame.height - 100))
        line.constrainHeight(constant: 2)
        line.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
