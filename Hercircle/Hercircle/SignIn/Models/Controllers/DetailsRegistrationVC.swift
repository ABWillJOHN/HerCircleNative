//
//  RegistrationViewController.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/25/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices
import DropDown

class DetailsRegistrationVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextField: BottomLineTextField!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var confirmPasswordTextfield: BottomLineTextField!
    @IBOutlet weak var passwordTextfield: BottomLineTextField!
    
    var gender : String?
    var countryID : String?
    var email : String?
    var mobile : String?
    var hasAgreedToTermsAndConditions = false
    
    var dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableContinueButton()
        usernameTextField.delegate = self
        passwordTextfield.delegate = self
        confirmPasswordTextfield.delegate = self
    }
    
    @IBAction func continueButtonClicked(_ sender: UIButton) {
        
        if chechTextFieldValidation(/passwordTextfield.text?.trim(),/confirmPasswordTextfield.text?.trim()){
            self.userSignUp()
        }
  
    }
    
    
    
    @IBAction func handleTermsCheckMark(_ sender: SelectionButton) {
        sender.hasCheckMark = !sender.hasCheckMark
        if !isAnyTextFielEmpty() && sender.hasCheckMark {
            enableContinueButton()
        } else {
            disableContinueButton()
        }
        hasAgreedToTermsAndConditions = sender.hasCheckMark
    }
    
    @IBAction func handleSubscribeCheckMark(_ sender: SelectionButton) {
        sender.hasCheckMark = !sender.hasCheckMark
    }
    
    @IBAction func termsAndConditionsClicked(_ sender: UIButton) {
    }
    
    @IBAction func handleSignIn(_ sender: UIButton) {
        if let loginVC = self.navigationController?.viewControllers[0] as? LoginVC {
            loginVC.loginState = .signinWithEmailPassword
            self.navigationController?.popToViewController(loginVC, animated: true)
        }
    }
    
    @IBAction func handleGoogleSignin(_ sender: UIButton) {
        GmailAuthenticator.shared.signin(on: self)
    }
    
    @IBAction func handleFacebookSignin(_ sender: UIButton) {
        FacebookAuthenticator.shared.signin(on: self) { result,error in
            if error != nil {
                self.showAlert(title: error?.localizedDescription ?? "", actionText1: "OK", action1: {_ in})
            }
            if let userDetails = result as? [String:String] {
                let email = userDetails["email"]
                let id = userDetails["id"]
                let fn = userDetails["first_name"]
                let ln = userDetails["last_name"]
                let gender = userDetails["gender"]
                self.socialSignin(userName: "facebook-" + (id ?? ""), email: email, password: nil, firstName: fn, lastName: ln, gender: gender)
            }
            
        }
    }
    
    func socialSignin(userName: String?, email: String?, password: String?, firstName: String?, lastName: String?, gender: String?, mobile: String? = nil, countryID: String? = nil) {
        
        vcViewModel().postSocialSignUp(userName: /userName?.trim(), pass: /password?.trim(), firstname: /firstName?.trim(), lastName: /lastName?.trim(), mobile: /mobile, email: /email, gender: /gender, countryId: /countryID, newsletterCheck: "false", viewCurrent: self.view, result:{ (result) in
            switch result {
            case .success(let user):
                if user?.statusCode == 200 {
                    DispatchQueue.main.async {
                        UserDefaults.signinEmail = email
                        if user?.systemMsg == "Data inserted successfully!" {
                            if let vc = self.navigationController?.viewControllers[1] as? IdentificationRegistrationVC {
                                vc.isMobileInput = false
                                vc.email = email
                                self.navigationController?.popToViewController(vc, animated: true)
                            }
                        } else {
                            SideMenuHandler.shared.presentSideMenu(with: self)
                        }
                    }
                }
            case .failure(let error):
                print("the error \(error)")
            }
        })
    }
    
    //MARK:-Check Validation Method
    func chechTextFieldValidation(_ password : String , _ confirmpassword :String) -> Bool{
        let value = Validation.shared.validatePassword(password,confirmpassword)
        switch value {
        case .success:
            return true
        case .failure(let str):
            alertMessase(message: str) {}
        }
        return false
    }
    
    @IBAction func handleAppleSignin(_ sender: UIButton) {
        AppleAuthenticator.shared.signin(on: self)
    }
    
    @IBAction func handleSkip(_ sender: UIButton) {
        SideMenuHandler.shared.presentSideMenu(with: self)
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
        guard let enteredText = textField.text else {
            return
        }
        
        if(textField == self.usernameTextField){
            self.usernameSuggestion(sender: textField)
        }
        
        if !isAnyTextFielEmpty(),  hasAgreedToTermsAndConditions {
            enableContinueButton()
        } else {
            disableContinueButton()
        }
    }
    
    private func isAnyTextFielEmpty() -> Bool {
        return usernameTextField.text == "" || passwordTextfield.text == "" || confirmPasswordTextfield.text == ""
    }
    
    func usernameSuggestion(sender : UITextField) {
    
        vcViewModel().postUsernameSuggestion(userName: /self.usernameTextField.text?.trim(), firstName: /self.usernameTextField.text?.trim(), lastName: /self.usernameTextField.text?.trim(), viewCurrent: self.view, result:{ (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                      
                    } else {
                       
                      //  DismissAlert.info.showWithType(type: .info, message:/user?.systemMsg)
                    }
                    self.dropDown.anchorView = sender
                    self.dropDown.dataSource = user?.data ?? []
                    self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        self.usernameTextField?.text = item
                        if item.trim().isEmpty == false{
                            self.enableContinueButton()
                        }
                    }
                    self.dropDown.show()
                    self.dropDown.width = sender.frame.size.width
                    self.dropDown.show()
                }
            case .failure(let error):
                print("the error \(error)")
                //self.showAlert(message: error.errorDescription)
            }
        })
    }
    
    func userSignUp() {
    
        let encryptedPassword = /AesEncryption().encrypt(encryptedText: /passwordTextfield.text?.trim(), keyString: encrpytKey)
        
        vcViewModel().getSignUp(userName: /self.usernameTextField.text?.trim(), pass:encryptedPassword , firstname: /self.usernameTextField.text?.trim(), lastName: /self.usernameTextField.text?.trim(), mobile: /self.mobile, email: /self.email, gender: /self.gender, countryId: /self.countryID, newsletterCheck: "false", viewCurrent: self.view, result:{ (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        UserDefaults.signinPassword = self.passwordTextfield.text
                        self.showAlert(title: "You are registered successfully", actionText1: "OK") {_ in
                            self.performSegue(withIdentifier: "categorySelectionSegue", sender: self)
                        }
                    } else {
                        
                    }
                }
            case .failure(let error):
                print("the error \(error)")
            }
        })
    }

    
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}



extension DetailsRegistrationVC: GIDSignInDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            self.showAlert(title: error?.localizedDescription ?? "", actionText1: "OK", action1: {_ in})
            return
        }
        if let user = user {
            socialSignin(userName: "google-" + user.userID, email: user.profile.email, password: nil, firstName: user.profile.givenName, lastName: user.profile.familyName, gender: nil)
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let email = appleIDCredential.email
            let fullname = appleIDCredential.fullName
            let fn = fullname?.givenName
            let ln = fullname?.familyName
            
            self.socialSignin(userName: "apple-" + userIdentifier, email: email, password: nil, firstName: fn, lastName: ln, gender: nil)
            
        }
    }
    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        self.showAlert(title: error.localizedDescription, actionText1: "OK", action1: {_ in})
//    }
}
