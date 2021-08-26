//
//  GoalsListCell.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit

class GoalsListCell: BaseCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let goalTextLabel: UILabel = {
        let label = UILabel(text: "finance", font: UIFont(name: "MuseoSans-500", size: 14)!, numberOfLines: 2)
        label.textColor = UIColor(r: 58, g: 58, b: 58)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /*
        imageView.constrainWidth(constant: 36)
        imageView.constrainHeight(constant: 36)
        imageView.backgroundColor = .purple
        backgroundColor = .lightGray
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [imageView, UIView()]),
            goalTextLabel
        ])
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 0, right: 16))
 */
        imageView.contentMode = .scaleAspectFill
        imageView.constrainWidth(constant: 60)
        imageView.constrainHeight(constant: 80)
        let stackView = VerticalStackView(arrangedSubviews: [
            imageView,
            goalTextLabel
        ], spacing: 8)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
    }
    
    func populateData(imageString: String, goalTitle: String) {
        imageView.image = UIImage(named: imageString)
        goalTextLabel.text = goalTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
