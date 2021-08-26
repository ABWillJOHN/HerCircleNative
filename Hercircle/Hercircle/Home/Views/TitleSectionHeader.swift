//
//  GoalsTrackingCell.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit

class TitleSectionHeader: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.setAttributes(with: UIColor(r: 56, g: 56, b: 56))
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel(text: "", font: UIFont(name: "MuseoSans-300", size: 16)!)
        label.numberOfLines = 2
        return label
    }()
    
    override func prepareForReuse() {
        titleLabel.text = ""
        descLabel.text = ""
    }
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = VerticalStackView(arrangedSubviews: [
            titleLabel,
            descLabel
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    func populateData(title: String, description: String?, titleColor: (CGFloat, CGFloat, CGFloat)) {
        titleLabel.text = title
        if let d = description {
            descLabel.text = d
        }
        titleLabel.setAttributes(with: UIColor(r: titleColor.0, g: titleColor.1, b: titleColor.2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
