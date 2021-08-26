//
//  MustWatchCell.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit

class MustWatchCell: BaseCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let categoryLabel: UILabel = {
        let label = UILabel(text: "Food", font: UIFont(name: "MuseoSans-300", size: 12)!)
        label.textColor = UIColor(r: 39, g: 156, b: 142)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(text: "Balanced diet And Its Essential Factors", font: UIFont(name: "MuseoSans-700", size: 16)!)
        label.textColor = UIColor(r: 56, g: 56, b: 56)
        label.numberOfLines = 2
        return label
    }()
    
    let separatorLabel: UILabel = {
        let label = UILabel(text: "|", font: UIFont(name: "MuseoSans-300", size: 12)!)
        label.textColor = UIColor(r: 126, g: 126, b: 126)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel(text: "Sunetra Ghose", font: UIFont(name: "MuseoSans-300", size: 12)!)
        label.textColor = UIColor(r: 126, g: 126, b: 126)
        return label
    }()
    let dateTimeLabel: UILabel = {
        let label = UILabel(text: "May 30, 2021", font: UIFont(name: "MuseoSans-300", size: 12)!)
        label.textColor = UIColor(r: 126, g: 126, b: 126)
        return label
    }()
    
    let threeDotbutton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "3dot"), for: .normal)
        return button
    }()
    
    let playbutton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
               
        let authorStackView = UIStackView(arrangedSubviews: [
            authorLabel,
            separatorLabel,
            dateTimeLabel,
            UIView()
        ])
        
        let buttonStack = VerticalStackView(arrangedSubviews: [
            threeDotbutton,
            UIView()
        ])
        
        let categoryStack = UIStackView(arrangedSubviews: [
            VerticalStackView(arrangedSubviews: [
                categoryLabel,
                titleLabel,
                authorStackView
            ], spacing: 2),
            buttonStack
        ])
        
        let stackView = VerticalStackView(arrangedSubviews: [
            imageView,
            categoryStack,
        ])
            
        addSubview(stackView)
        
        imageView.constrainHeight(constant: 150)
        threeDotbutton.constrainWidth(constant: 5)
        threeDotbutton.constrainHeight(constant: 20)
        playbutton.constrainWidth(constant: 20)
        playbutton.constrainHeight(constant: 20)
        imageView.addSubview(playbutton)
        playbutton.centerInSuperview()
        
        stackView.spacing = 10
        authorStackView.spacing = 5
        
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        categoryLabel.text = ""
        titleLabel.text = ""
        authorLabel.text = ""
        dateTimeLabel.text = ""
    }
    
    func populateData(with info: MediaInfo?) {
        guard let info = info else {
            return
        }
        imageView.sd_setImage(with: URL(string: info.mediaFileName ?? ""), completed: nil)
        categoryLabel.text = info.categoryName
        titleLabel.text = info.titleHeader
        authorLabel.text = info.author
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        if let date = formatter.date(from: info.validFrom ?? "") {
            dateTimeLabel.text = formatter.string(from: date)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
