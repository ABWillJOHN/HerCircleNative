//
//  JobDetailsCell.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit

protocol ApplyJobCellDelegate: AnyObject {
  func applyJob(jobId: Int, userId: String)
}

class JobDetailsCell: BaseCell {
    
    let shareButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "share"), for: .normal)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "save"), for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(text: "Content Management Program Advisor", font: UIFont(name: "MuseoSans-700", size: 14)!, numberOfLines: 2)
        label.textColor = UIColor(r: 3, g: 1, b: 76)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel(text: "Hyderabad", font: UIFont(name: "MuseoSans-300", size: 12)!)
        label.textColor = UIColor(r: 3, g: 1, b: 76)
        return label
    }()
    
    let applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(UIColor(r: 255, g: 3, b: 111), for: .normal)
        button.titleLabel?.font = UIFont(name: "MuseoSans-500", size: 10)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor(r: 255, g: 3, b: 111).cgColor
        return button
    }()
    
    weak var delegate : ApplyJobCellDelegate?
    var jobInfo: GrowJobsListing?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyButton.addTarget(self, action: #selector(applyJob(sender:)), for: .touchUpInside)
        shareButton.constrainWidth(constant: 20)
        shareButton.constrainHeight(constant: 20)
        saveButton.constrainWidth(constant: 20)
        saveButton.constrainHeight(constant: 20)
        
        let locStack = UIStackView(arrangedSubviews: [
            locationLabel,
            shareButton,
            saveButton
        ])
        locStack.spacing = 16
        
        let stackView = VerticalStackView(arrangedSubviews: [
            titleLabel,
            locStack,
            applyButton
        ], spacing: 6)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    @objc func applyJob(sender: UIButton) {
        if let jobId = jobInfo?.jobid,
           let delegate = delegate, let id = SigninUserHandler.shared.getUserDeytails()?.data.first?.userId {
            delegate.applyJob(jobId: jobId, userId: id)
        }
    }
    
    override func prepareForReuse() {
        locationLabel.text = ""
        titleLabel.text = ""
    }
    
    func populateData(with info: GrowJobsListing?) {
        guard let info = info else {
            return
        }
        jobInfo = info
        titleLabel.text = info.titleHeader
        locationLabel.text = info.location
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
