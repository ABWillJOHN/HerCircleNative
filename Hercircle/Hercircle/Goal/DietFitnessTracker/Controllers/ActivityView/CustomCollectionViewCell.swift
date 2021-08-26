//
//  CustomCollectionViewCell.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    public let baseview: UIView = {
        let myview = UIView()
        myview.translatesAutoresizingMaskIntoConstraints = false
        myview.backgroundColor = .white
        myview.layer.cornerRadius = 5.0
        myview.layer.shadowColor = UIColor.black.cgColor
        myview.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        myview.layer.shadowOpacity = 0.2
        myview.layer.shadowRadius = 4.0
        return myview
    }()
    public let propertyImg: UIImageView = {
        let myImg = UIImageView()
        myImg.translatesAutoresizingMaskIntoConstraints = false
        return myImg
    }()
    public let propertyNameLbl: UILabel = {
        let propertyLbl = UILabel()
        propertyLbl.translatesAutoresizingMaskIntoConstraints = false
        propertyLbl.textColor = UIColor.darkGray
        propertyLbl.text = "Meal Plan"
        propertyLbl.textAlignment = .center
        return propertyLbl
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(baseview)
        baseview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        baseview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        baseview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        baseview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        // Image view
        baseview.addSubview(propertyImg)
        propertyImg.image = UIImage(named: "icon")
        propertyImg.topAnchor.constraint(equalTo: baseview.topAnchor, constant: 10).isActive = true
        propertyImg.widthAnchor.constraint(equalToConstant: 40).isActive = true
        propertyImg.heightAnchor.constraint(equalToConstant: 40).isActive = true
        propertyImg.centerXAnchor.constraint(equalTo: baseview.centerXAnchor, constant: 0).isActive = true
        
        baseview.addSubview(propertyNameLbl)
        propertyNameLbl.topAnchor.constraint(equalTo: propertyImg.bottomAnchor, constant: 5).isActive = true
        propertyNameLbl.leadingAnchor.constraint(equalTo: baseview.leadingAnchor, constant: 5).isActive = true
        propertyNameLbl.trailingAnchor.constraint(equalTo: baseview.trailingAnchor, constant: -5).isActive = true
        propertyNameLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("something wrong")
    }
    
}
