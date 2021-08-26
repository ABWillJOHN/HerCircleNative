//
//  ForgotPasswordViewController.swift
//  Hercircle
//
//  Created by vishal modem on 7/8/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    var username: String?
    
    @IBOutlet weak var confirmPasswordTf: BottomLineTextField!
    @IBOutlet weak var enterPasswordTf: BottomLineTextField!
    
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        enterPasswordTf.delegate = self
        confirmPasswordTf.delegate = self
        disableContinueButton()
        
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        if let username = username, enterPasswordTf.text == confirmPasswordTf.text {
            let encryptedPassword = /AesEncryption().encrypt(encryptedText: /enterPasswordTf.text, keyString: encrpytKey)
            
            vcViewModel().postChangePassword(UserId: /username.trim(), password: encryptedPassword, viewCurrent: self.view) { result in
                switch result {
                case .success(let result) :
                    self.showAlert(title: result?.systemMsg ?? "", actionText1: "OK", action1: {_ in
                        DispatchQueue.main.async {
                            if let loginVC = self.navigationController?.viewControllers[0] as? LoginVC {
                                loginVC.loginState = .signinWithEmailPassword
                                self.navigationController?.popToViewController(loginVC, animated: true)
                            }
                        }

                    })
                case .failure(let error) :
                    self.showAlert(title: error.localizedDescription, actionText1: "OK", action1: {_ in})
                }
            }
        }
    }
    
    func disableContinueButton() {
        continueButton.backgroundColor = UIColor(red: 190/255, green: 189/255, blue: 189/255, alpha: 1.0)
        continueButton.isEnabled = false
    }
    
    func enableContinueButton() {
        continueButton.backgroundColor = UIColor(red: 85/255, green: 29/255, blue: 200/255, alpha: 1.0)
        continueButton.isEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if enterPasswordTf.text == "" || confirmPasswordTf.text == "" {
            disableContinueButton()
        } else {
            enableContinueButton()
        }
    }
    

}
