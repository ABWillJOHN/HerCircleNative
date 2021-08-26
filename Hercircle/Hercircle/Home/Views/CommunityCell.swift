//
//  CommunityCell.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit
import SDWebImage

class CommunityCell: BaseCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let communityNameLabel: UILabel = {
        let label =  UILabel(text: "Period Planners", font: UIFont(name: "MuseoSans-500", size: 14)!, numberOfLines: 2)
        label.textColor = UIColor(r: 58, g: 58, b: 58)
        return label
    }()
    
    let tickimageView = UIImageView()
       
    let membersLabel: UILabel = {
        let label = UILabel(text: "5254 members", font: UIFont(name: "MuseoSans-500", size: 12)!)
        label.textColor = UIColor(r: 144, g: 144, b: 144)
        return label
    }()

    let joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join", for: .normal)
        button.setTitleColor(UIColor(r: 255, g: 3, b: 111), for: .normal)
        button.titleLabel?.font = UIFont(name: "MuseoSans-500", size: 10)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor(r: 255, g: 3, b: 111).cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /*
        
        addSubview(imageContainerView)
        imageContainerView.fillSuperview()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 140, height: 140))
        imageView.backgroundColor = .purple
        let stackView = VerticalStackView(arrangedSubviews: [
            communityNameLabel,
            membersLabel
        ], spacing: 4)
        imageContainerView.addSubview(stackView)
        stackView.anchor(top: nil, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 8, right: 0))
 */
        
        tickimageView.image = UIImage(named: "tick")
        tickimageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        imageView.constrainWidth(constant: 90)
        imageView.constrainHeight(constant: 75)
        tickimageView.constrainWidth(constant: 10)
        tickimageView.constrainHeight(constant: 10)
        joinButton.constrainHeight(constant: 25)
        addSubview(imageView)
        addSubview(communityNameLabel)
        addSubview(membersLabel)
        addSubview(tickimageView)
        addSubview(joinButton)
        
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: communityNameLabel.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 6, right: 0))
        communityNameLabel.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: membersLabel.topAnchor, trailing: tickimageView.leadingAnchor, padding: .init(top: 6, left: 0, bottom: 6, right: 6))
        tickimageView.anchor(top: imageView.bottomAnchor, leading: communityNameLabel.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 6, left: 6, bottom: 0, right: 2))
        membersLabel.anchor(top: communityNameLabel.bottomAnchor, leading: leadingAnchor, bottom: joinButton.topAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 0, bottom: 8, right: 0))
        joinButton.anchor(top: membersLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        communityNameLabel.text = ""
        membersLabel.text = ""
        joinButton.setTitle("Join", for: .normal)
        joinButton.setTitleColor(UIColor(r: 255, g: 3, b: 111), for: .normal)
        joinButton.backgroundColor = .white
        tickimageView.isHidden = true
    }
    
    func populateData(with info: CommunityInfo?) {
        guard let info = info else {
            return
        }
        imageView.sd_setImage(with: URL(string: info.mediaFileName ?? ""), completed: nil)
        communityNameLabel.text = info.communityName
        membersLabel.text = "\(info.members ?? 0) members"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
