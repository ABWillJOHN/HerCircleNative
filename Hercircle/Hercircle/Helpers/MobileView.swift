//
//  MobileView.swift
//  Hercircle
//
//  Created by vishal modem on 7/6/21.
//

import UIKit
import DialCountries

class MobileView: UIView {
   
    
    @IBOutlet weak var btnSelectCountryCode: UIButton!
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var countryCodeTextfield: BottomLineTextField!
    @IBOutlet weak var mobileNumberTextField: BottomLineTextField!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        guard let view = loadViewFromNib(nibName: "MobileView") else { return }
        view.frame = self.bounds
        
        self.addSubview(view)
        setCountryCodeTFViews()
    }
    
    private func setCountryCodeTFViews() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow-down"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(countryCodeTextfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        countryCodeTextfield.rightView = button
        countryCodeTextfield.rightViewMode = .always
        
//        let countryImageView = UIImageView(image: UIImage(named: "ic_notifications"))
//        countryImageView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(25), height: CGFloat(25))
//        countryCodeTextfield.leftView = countryImageView
//        countryCodeTextfield.leftViewMode = .always
    }
    
   
}
