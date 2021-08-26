//
//  OTPView.swift
//  Hercircle
//
//  Created by vishal modem on 7/4/21.
//

import UIKit

class OTPView: UIView {

    @IBOutlet weak var resendOTPButton: UIButton!
    @IBOutlet var otpTextFields: [BottomLineTextField]!
    @IBOutlet weak var OPTTimeLabel: UILabel!
    var otpText = ""
    
    var handleButtonState: ((Bool) -> ())?
    var timer: Timer?
    var totalTime = 24
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        guard let view = loadViewFromNib(nibName: "OTPView") else { return }
        view.frame = self.bounds
        
        self.addSubview(view)
        otpTextFields.forEach { tf in
            tf.delegate = self
        }
        resendOTPButton.isHidden = true
    }
    
    func startOtpTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        print(self.totalTime)
        self.OPTTimeLabel.text = self.timeFormatted(self.totalTime) // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                resendOTPButton.isHidden = false
            }
        }
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        var seconds: Int = totalSeconds % 60
        var minutes: Int = (totalSeconds / 60) % 60
//        if totalSeconds == 60 {
//            seconds = 60
//            minutes = 0
//        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
        totalTime = 24
        updateTimer()
    }
    
    func clearOtpText() {
        otpTextFields.forEach { tf in
            tf.text = ""
        }
    }
}

extension OTPView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1 ) && (string.count > 0) && string != " " {
            if textField == otpTextFields[0] {
                otpTextFields[1].becomeFirstResponder()
            }
            
            if textField == otpTextFields[1] {
                otpTextFields[2].becomeFirstResponder()
            }
            
            if textField == otpTextFields[2] {
                otpTextFields[3].becomeFirstResponder()
            }
            
            if textField == otpTextFields[3] {
                otpTextFields[4].becomeFirstResponder()
            }
            
            if textField == otpTextFields[4] {
                otpTextFields[5].becomeFirstResponder()
            }

            textField.text = string
            
            setOtpText()
            return false
            
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            if textField == otpTextFields[1] {
                otpTextFields[0].becomeFirstResponder()
            }
            if textField == otpTextFields[2] {
                otpTextFields[1].becomeFirstResponder()
            }
            if textField == otpTextFields[3] {
                otpTextFields[2].becomeFirstResponder()
            }
            if textField == otpTextFields[4] {
                otpTextFields[3].becomeFirstResponder()
            }
            
            if textField == otpTextFields[5] {
                otpTextFields[4].becomeFirstResponder()
            }
          
            if textField == otpTextFields[0] {
                otpTextFields[0].resignFirstResponder()
            }
            
            textField.text = ""
            
            setOtpText()
            return false
        } else if (textField.text?.count)! >= 1 {
            if textField == otpTextFields[0] {
                if let text = otpTextFields[1].text, text.isEmpty {
                    otpTextFields[1].becomeFirstResponder()
                    otpTextFields[1].text = string
                }
            }
            
            if textField == otpTextFields[1] {
                if let text = otpTextFields[2].text, text.isEmpty {
                    otpTextFields[2].becomeFirstResponder()
                    otpTextFields[2].text = string
                }
            }
            
            if textField == otpTextFields[2] {
                if let text = otpTextFields[3].text, text.isEmpty {
                    otpTextFields[3].becomeFirstResponder()
                    otpTextFields[3].text = string
                }
            }
            
            if textField == otpTextFields[3] {
                if let text = otpTextFields[4].text, text.isEmpty {
                    otpTextFields[4].becomeFirstResponder()
                    otpTextFields[4].text = string
                }
            }
            
            if textField == otpTextFields[4] {
                if let text = otpTextFields[5].text, text.isEmpty {
                    otpTextFields[5].becomeFirstResponder()
                    otpTextFields[5].text = string
                }
            }
            
            if textField == otpTextFields[5] {
                otpTextFields[5].resignFirstResponder()
            }
            
            setOtpText()
            return false
        }
        
        return false
    }
    
    private func isAnyTextFieldEmpty() -> Bool {
        

                var tempFlag = false
                otpTextFields.forEach { (tf) in
                    if /tf.text?.trim().isEmpty {
                        tempFlag = true
                    }
                }
                return tempFlag
    }
    
    fileprivate func setOtpText() {
        otpText = ""
        otpTextFields.forEach { tf in
            guard let text = tf.text else {
                return
            }
            otpText = otpText + text
        }
        handleButtonState?(isAnyTextFieldEmpty())
    }
}
