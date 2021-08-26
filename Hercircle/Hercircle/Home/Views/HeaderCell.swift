//
//  GoalsListCell.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit

class HeaderCell: BaseCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let categoryLabel: UILabel = {
        let label = UILabel(text: "Wellness", font: UIFont(name: "MuseoSans-500", size: 12)!)
        label.textColor = UIColor(r: 42, g: 115, b: 216)
        return label
    }()
        
    let titleLabel: UILabel = {
        let label = UILabel(text: "Eating Disorders: Bulimia", font: UIFont(name: "MuseoSans-700", size: 24)!, numberOfLines: 2)
        label.textColor = UIColor(r: 56, g: 56, b: 56)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.constrainHeight(constant: 150)
        let stackView = VerticalStackView(arrangedSubviews: [
            imageView,
            categoryLabel,
            titleLabel
        ], spacing: 16)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)

    }
    
    override func prepareForReuse() {
        imageView.image = nil
        categoryLabel.text = ""
        titleLabel.text = ""
    }
    
    func populateData(with info: MediaInfo?) {
        guard let info = info else {
            return
        }
        imageView.sd_setImage(with: URL(string: info.mediaFileName ?? ""), completed: nil)
        categoryLabel.text = info.categoryName
        titleLabel.text = info.titleHeader
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
