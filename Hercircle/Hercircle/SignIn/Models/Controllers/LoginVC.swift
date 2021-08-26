//
//  LoginViewController.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/28/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import DialCountries
import AuthenticationServices

class LoginVC: UIViewController, GIDSignInDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding , DialCountriesControllerDelegate{
    
    func didSelected(with country: Country) {
        self.countryCodeTextField?.text = country.dialCode
        // self.btnSelectCountryCode?.setImage(country.flag, for: .normal)
    }
    
    var userName : String?
    var userid : String?
    var txnId : String?
    var password : String?
    var result : SignIn?
    private let signupSegue = "signupSegue"
    private let forgotPasswordSegue = "forgotPasswordSegue"
    
    enum LoginState {
        case signinWithEmailPassword
        case signinWithMobilePassword
        case signinWithEmailOTP
        case signinWithMobileOTP
        case signup
        case forgotPassword
    }
    
    enum ButtonTitles: String {
        case signin = "Sign In"
        case signinWithOtp = "or Sign in with OTP"
        case signinWithPassword = "or Sign in with Password"
        case signupNow = "Signup Now"
        case sendOTP = "Send OTP"
        case changeEmail = "Change Email"
        case changeMobileNumber = "Change Mobile Number"
        case verifyNcontinue = "Verify & Continue"
    }
    
    enum LabelTitles: String {
        case heySignin = "Hello, sign in and be part of Her Circle with you at its core"
        case heySignup = "Hello, Sign up to be a part of Her Circle"
        case enterOtpMobile = "Enter the OTP we just sent to your mobile number"
        case enterOTPEmail = "Enter the OTP we just sent to your email"
        case orSigninWith = "or Sign in with"
        case orSignupWith = "or Sign up With"
        case newUser = "New user?"
        case haveAnAccount = "Have an account?"
    }
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var passwordTextField: BottomLineTextField!
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signinWithOTP: UIButton!
    @IBOutlet weak var orSigninWithLabel: UILabel!
    @IBOutlet weak var newUserLabel: UILabel!
    @IBOutlet weak var signupNowButton: UIButton!
    @IBOutlet weak var otpView: OTPView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var keepMeSigninStackview: UIStackView!
    @IBOutlet weak var mobileView: MobileView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    lazy var countryCodeView = mobileView.countryCodeView
    lazy var emailTextField = mobileView.mobileNumberTextField
    lazy var countryCodeTextField = mobileView.countryCodeTextfield
    lazy var btnSelectCountryCode = mobileView.btnSelectCountryCode
    
    
    var socialEmail: String?
    var isMobileInput = false {
        didSet {
            if isMobileInput {
                countryCodeView?.isHidden = false
                emailTextField?.floatingLabelXPadding = -80
            } else {
                emailTextField?.floatingLabelXPadding = 0
                countryCodeView?.isHidden = true
            }
        }
    }
    
    var loginState: LoginState = .signinWithEmailPassword {
        didSet {
            switch loginState {
            case .signinWithEmailPassword:
                fallthrough
                
            case .signinWithMobilePassword:
                setSigninUI()
                
            case .signinWithEmailOTP:
                fallthrough
                
            case .signinWithMobileOTP:
                setSigninUI()
                otpView.clearOtpText()
                passwordStackView.isHidden = true
                signInButton.setTitle(ButtonTitles.sendOTP.rawValue, for: .normal)
                signinWithOTP.setTitle(ButtonTitles.signinWithPassword.rawValue, for: .normal)
                
            case .forgotPassword:
                passwordStackView.isHidden = true
                signInButton.setTitle(ButtonTitles.sendOTP.rawValue, for: .normal)
                disableSigninButton()
                keepMeSigninStackview.isHidden = true
                
            default:
                passwordStackView.isHidden = true
                countryCodeView?.isHidden = true
                otpView.isHidden = true
                orSigninWithLabel.text = LabelTitles.orSignupWith.rawValue
                emailTextField?.placeholder = "Mobile Number/Email"
                signInButton.setTitle(ButtonTitles.sendOTP.rawValue, for: .normal)
                signinWithOTP.isHidden = true
                titleLabel.text = LabelTitles.heySignup.rawValue
                changeEmailButton.isHidden = true
                newUserLabel.text = LabelTitles.haveAnAccount.rawValue
                signupNowButton.setTitle(ButtonTitles.signin.rawValue, for: .normal)
                titleLabel.textAlignment = .center
                keepMeSigninStackview.isHidden = true
                clearText()
            }
            otpView.invalidateTimer()
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = UserDefaults.signinEmail, let password = UserDefaults.signinPassword {
            self.signInWithPassword(with: email, password: password)
        }
        
        emailTextField?.delegate = self
        passwordTextField.delegate = self
        countryCodeView?.isHidden = true
        disableSigninButton()
        loginState = .signinWithEmailPassword
        otpView.resendOTPButton.addTarget(self, action: #selector(handleResendOtp), for: .touchUpInside)
        otpView.handleButtonState = { [weak self] isEmpty in
            if isEmpty {
                self?.disableSigninButton()
            } else {
                self?.enableSigninButton()
            }
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
        btnSelectCountryCode?.addTarget(self, action: #selector(countryCodeSelection), for: .touchUpInside)
        
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        let screenSize = UIScreen.main.bounds
        if screenSize.height >= 844 {
            scrollView.isScrollEnabled = false
        } else {
            scrollView.isScrollEnabled = true
        }
    }
    
    @objc func handleResendOtp() {
        sendOtp(integer: 2) //2 resend , 1 send
    }
    
    @objc func countryCodeSelection() {
        DispatchQueue.main.async {
            
            let cv = DialCountriesController(locale: Locale(identifier: "en"))
            cv.delegate = self
            cv.show(vc: self)
        }
    }
    
    private func setSigninUI() {
        countryCodeView?.isHidden = true
        passwordStackView.isHidden = false
        otpView.isHidden = true
        emailTextField?.placeholder = "Mobile Number/Email/UserName"
        signinWithOTP.isHidden = false
        signInButton.setTitle(ButtonTitles.signin.rawValue, for: .normal)
        signinWithOTP.setTitle(ButtonTitles.signinWithOtp.rawValue, for: .normal)
        titleLabel.text = LabelTitles.heySignin.rawValue
        changeEmailButton.isHidden = true
        newUserLabel.text = LabelTitles.newUser.rawValue
        signupNowButton.setTitle(ButtonTitles.signupNow.rawValue, for: .normal)
        orSigninWithLabel.text = LabelTitles.orSigninWith.rawValue
        titleLabel.textAlignment = .center
        keepMeSigninStackview.isHidden = false
        disableSigninButton()
        clearText()
    }
    
    @IBAction func handleSignInWithOTP(_ sender: UIButton) {
        if sender.currentTitle == ButtonTitles.signinWithOtp.rawValue {
            loginState = .signinWithEmailOTP
            return
        }
        loginState = .signinWithEmailPassword
    }
    
    @IBAction func handleCheckMark(_ sender: SelectionButton) {
        sender.hasCheckMark = !sender.hasCheckMark
        print(sender.hasCheckMark)
    }
    
    @IBAction func handleSignup(_ sender: UIButton) {
        
        test()
        
//        if sender.currentTitle == ButtonTitles.signupNow.rawValue {
//            loginState = .signup
//            return
//        }
//        loginState = .signinWithEmailPassword
    }
    
    func test() {
        
        let topView = HelperMethods.topMostController()
        topView.modalPresentationStyle = .fullScreen
        let vc = UIStoryboard(name: "JoinAMeet", bundle: .main).instantiateViewController(withIdentifier: "PopupControler") as!
            PopupControler
        var arrOptions = [MoreOptionsModel]()
        arrOptions = [
            MoreOptionsModel(optionName: "photo/video", image: UIImage(named: "ic_removephoto_outline")),
            MoreOptionsModel(optionName: "tag a friend", image: UIImage(named: "tagfriend")),
            MoreOptionsModel(optionName: "mood", image: UIImage(named: "mood")),
            MoreOptionsModel(optionName: "check in", image: UIImage(named: "checkin")),
            MoreOptionsModel(optionName: "background", image: UIImage(named: "backgound")),
            MoreOptionsModel(optionName: "gif", image: UIImage(named: "gif"))
        ]
        vc.arrOptions = arrOptions
        vc.participantName = "Users in call"
        vc.modalPresentationStyle = .fullScreen
        
        vc.optionSelected = { type in
            debugPrint(type.name)
        }
        topView.present(vc, animated: true, completion: nil)

//        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func handleChangeEmail(_ sender: UIButton) {
        otpView.isHidden = true
        emailTextField?.text = ""
        signInButton.setTitle(ButtonTitles.sendOTP.rawValue, for: .normal)
    }
    
    @IBAction func handleSignin(_ sender: UIButton) {
        if sender.currentTitle == ButtonTitles.sendOTP.rawValue {
            if loginState == .signup {
                if chechEmailPhoneValidation(/emailTextField?.text?.trim()) {
                    self.sendOtp(integer: 1)
                }
            } else {
                self.sendOtp(integer: 1)
            }
        } else if sender.currentTitle == ButtonTitles.signin.rawValue {
            if chechTextFieldValidation(/emailTextField?.text?.trim(),/passwordTextField.text?.trim()){
                self.signInWithPassword(with: emailTextField?.text, password: passwordTextField.text)
            }
        } else {
            otpView.invalidateTimer()
            self.view.endEditing(true)
            if loginState == .signup {
                self.otpVerify(integer: 1)
            } else if loginState == .forgotPassword {
                self.otpVerify(integer: 3)
            }
            else {
                self.otpVerify(integer: 2)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == signupSegue, let vc = segue.destination as? IdentificationRegistrationVC {
            vc.isMobileInput = isMobileInput
            
            if let email = socialEmail?.trim() {
                vc.email = email
                return
            }

            if phoneTest.evaluate(with: self.emailTextField?.text?.trim()) == true{
                vc.mobile = self.emailTextField?.text?.trim()
            }
            else {
                vc.email = self.emailTextField?.text?.trim()
            }
            
        } else if segue.identifier == forgotPasswordSegue, let vc = segue.destination as? ForgotPasswordViewController {
            vc.username = self.userid
        }
    }
    
    
    func sendOtp(integer :Int) {
        
        vcViewModel().postOtpSend(userName: /emailTextField?.text?.trim(),  viewCurrent: self.view) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        
                        self.userid = user?.data.userId
                        self.userName = user?.data.userName
                        self.txnId = user?.data.txnId
                        self.otpView.invalidateTimer()
                        self.otpView.isHidden = false
                        self.otpView.resendOTPButton.isHidden = true
                        self.otpView.startOtpTimer()
                        self.otpView.clearOtpText()
                        self.signInButton.setTitle(ButtonTitles.verifyNcontinue.rawValue, for: .normal)
                        self.disableSigninButton()
                        self.titleLabel.font = UIFont(name: "MuseoSans-700", size: 18)
                        self.titleLabel.textAlignment = .left
                        self.titleLabel.text = self.isMobileInput ? LabelTitles.enterOtpMobile.rawValue + " \(self.emailTextField?.text ?? "")" : LabelTitles.enterOTPEmail.rawValue + " \(self.emailTextField?.text ?? "")"
                        self.changeEmailButton.isHidden = false
                        self.changeEmailButton.setTitle(self.isMobileInput ? ButtonTitles.changeMobileNumber.rawValue : ButtonTitles.changeEmail.rawValue, for: .normal)
                        if(integer == 2){
                            self.showAlert(title: "OTP has been sent again successfully", actionText1: "OK") { _ in }
                        }
                        else {
                            self.showAlert(title: "OTP has been sent successfully", actionText1: "OK") { _ in }
                        }
                    } else {
                        
                    }
                }
            case .failure(let error):
                print("the error \(error)")
            //self?.showAlert(message: error.errorDescription)
            }
        }
    }
    
    
    func otpVerify(integer: Int) {
        
        //  self.performSegue(withIdentifier: "signupSegue", sender: self)
        
        
        vcViewModel().postOtpVerify(userId: /self.userid ,  userName: /self.userName , txnId: /self.txnId , otp:/otpView.otpText, viewCurrent: self.view) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        if integer == 2 {
                            if user?.data.password == nil {
                                DispatchQueue.main.async {
                                    self.showAlert(title:"This email/phone is not registered", actionText1: "OK") { _ in }
                                }
                                return
                            }
                            self.password = user?.data.password
                            self.userName = user?.data.userName
                            self.signInWithOtp(with: self.userName , password: self.password)
                            //SideMenuHandler.shared.presentSideMenu(with: self)
                        }  else if integer == 3 {
                            self.performSegue(withIdentifier: self.forgotPasswordSegue, sender: self)
                        }
                        else {
                            self.performSegue(withIdentifier: self.signupSegue, sender: self)
                        }
                    } else {
                        //self?.showAlert(message: deviceInfo?.message ?? "")
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                self.otpView.resendOTPButton.isHidden = false
                DispatchQueue.main.async {
                    self.showAlert(title:"Please enter correct OTP", actionText1: "OK") { _ in }
                }
            }
        }
    }
    
    func signInWithOtp(with userName: String?, password: String?) {
        
        vcViewModel().getSignInWithOtp(userName: /userName?.trim(), pass: /password , otp: "true", viewCurrent: self.view) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        SigninUserHandler.shared.storeUserDetails(details: user)
                        SideMenuHandler.shared.presentSideMenu(with: self)
                    } else {
                        //self?.showAlert(message: deviceInfo?.message ?? "")
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                
                DispatchQueue.main.async {
                    self.showAlert(title:"Please enter correct OTP", actionText1: "OK") { _ in }
                }
            }
        }
    }
    
    func signInWithPassword(with userName: String?, password: String?) {
        
         let encryptedPassword = /AesEncryption().encrypt(encryptedText: /password, keyString: encrpytKey)
        
        vcViewModel().getSignIn(userName: /userName?.trim(), pass: encryptedPassword, viewCurrent: self.view) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    SigninUserHandler.shared.storeUserDetails(details: user)
                    if user?.statusCode == 200 {
                        SideMenuHandler.shared.presentSideMenu(with: self)
                    } else {
                        //self?.showAlert(message: deviceInfo?.message ?? "")
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                self.showAlert(title: error.errorDescription, actionText1: "OK", action1: {_ in})
            }
        }
        
        //        vcViewModel().getSignIn(userName: "pandurang", pass: "NB8n4KdxRhs8jlOlkFc/pJ/VkZuvKD37H+uRUQ2h0wU=", viewCurrent: self.view) { (result) in
        //            switch result {
        //            case .success(let user):
        //                DispatchQueue.main.async {
        //                    if user?.statusCode == 200 {
        //                        SideMenuHandler.shared.presentSideMenu(with: self)
        //                    } else {
        //                        //self?.showAlert(message: deviceInfo?.message ?? "")
        //                    }
        //                }
        //            case .failure(let error):
        //                print("the error \(error)")
        //            //self?.showAlert(message: error.errorDescription)
        //            }
        //        }
        
    }
    
    
    //MARK:-Check Validation Method
    func chechTextFieldValidation(_ loginText : String , _ passwordText :String) -> Bool{
        let value = Validation.shared.validateLogin(loginText, passwordText)
        switch value {
        case .success:
            return true
        case .failure(let str):
            alertMessase(message: str) {}
        }
        return false
    }
    
    func chechEmailPhoneValidation(_ loginText : String) -> Bool{
        let value = Validation.shared.validateEmailPhone(loginText)
        switch value {
        case .success:
            return true
        case .failure(let str):
            alertMessase(message: str) {}
        }
        return false
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
                        self.socialEmail = email
                        UserDefaults.signinEmail = email
                        if user?.systemMsg == "Data inserted successfully!" {
                            self.emailTextField?.text = ""
                            self.isMobileInput = false
                            self.performSegue(withIdentifier: self.signupSegue, sender: self)
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
    
    @IBAction func handleForgotPassword(_ sender: UIButton) {
        loginState = .forgotPassword
    }
    
    @IBAction func handleSkip(_ sender: UIButton) {
        SideMenuHandler.shared.presentSideMenu(with: self)
    }
    
    @IBAction func handleGoogleSignin(_ sender: UIButton) {
        GmailAuthenticator.shared.signin(on: self)
    }
    
    @IBAction func handleAppleSignin(_ sender: UIButton) {
        AppleAuthenticator.shared.signin(on: self)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let email = appleIDCredential.email
            let fullname = appleIDCredential.fullName
            let fn = fullname?.givenName
            let ln = fullname?.familyName
            
            self.socialSignin(userName: "apple-" + userIdentifier, email: email, password: nil, firstName: fn, lastName: ln, gender: nil)
            //    let appleIDProvider = ASAuthorizationAppleIDProvider()
            //    appleIDProvider.getCredentialState(forUserID: appleIDCredential.) {  (credentialState, error) in
            //         switch credentialState {
            //            case .authorized:
            //                // The Apple ID credential is valid.
            //                break
            //            case .revoked:
            //                // The Apple ID credential is revoked.
            //                break
            //            case .notFound:
            //                // No credential was found, so show the sign-in UI.
            //            default:
            //                break
            //         }
            //    }
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        self.showAlert(title: error.localizedDescription, actionText1: "OK", action1: {_ in})
//    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            self.showAlert(title: error?.localizedDescription ?? "", actionText1: "OK", action1: {_ in})
            return
        }
        if let user = user {
            socialSignin(userName: "google-" + user.userID, email: user.profile.email, password: nil, firstName: user.profile.givenName, lastName: user.profile.familyName, gender: nil)
        }
    }
    
    func disableSigninButton() {
        signInButton.backgroundColor = UIColor(red: 190/255, green: 189/255, blue: 189/255, alpha: 1.0)
        signInButton.isEnabled = false
    }
    
    func enableSigninButton() {
        signInButton.backgroundColor = UIColor(red: 85/255, green: 29/255, blue: 200/255, alpha: 1.0)
        signInButton.isEnabled = true
    }
    
    func clearText() {
        emailTextField?.text = ""
        passwordTextField.text = ""
        disableSigninButton()
    }
}


extension LoginVC: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField, otpView.isHidden == false {
            otpView.isHidden = true
            otpView.clearOtpText()
            signInButton.setTitle(ButtonTitles.sendOTP.rawValue, for: .normal)
            disableSigninButton()
        }
        guard let text = textField.text, textField == emailTextField else {
            return true
        }
        if text.count > 2 {
            isMobileInput = string.isEmpty ? text.isNumeric : text.isNumeric && string.isNumeric
        } else {
            isMobileInput = false
        }

         let phonetxt = textField.text! + string
        if isMobileInput {
            if phonetxt.count > 9 && phonetxt.count < 11 && phonetxt.isValidPhone{
                enableSigninButton()
            }
            else {
                disableSigninButton()
            }
        } else if (text.contains("@")){
            if !text.isValidEmail() {
                disableSigninButton()
            }
            else {
                enableSigninButton()
            }
        }else if (text.count>0){
            enableSigninButton()
        }

        //        var tempFlag = false
        //        otpView.otpTextFields.forEach { (tf) in
        //            if /tf.text?.trim().isEmpty {
        //                tempFlag = true
        //            }
        //        }
        //
        //        if tempFlag {
        //            disableSigninButton()
        //        } else {
        //            enableSigninButton()
        //        }

        //        if(otpView.otpText.count == 4){
        //            enableSigninButton()
        //        }

        return true
    }

    /*
     func textFieldDidEndEditing(_ textField: UITextField) {

     if let enteredText = emailTextField?.text, (enteredText.isValidEmail() || enteredText.isValidPhone) {
     if (loginState == .signinWithEmailPassword || loginState == .signinWithMobilePassword), passwordTextField.text == "" {
     disableSigninButton()
     } else {
     enableSigninButton()
     }
     return
     }
     disableSigninButton()
     //    }


     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     if textField == emailTextField, otpView.isHidden == false {
     otpView.isHidden = true
     otpView.clearOtpText()
     signInButton.setTitle(ButtonTitles.sendOTP.rawValue, for: .normal)
     disableSigninButton()
     }
     guard let text = textField.text, textField == emailTextField else {
     return true
     }
     if text.count > 2 {
     isMobileInput = string.isEmpty ? text.isNumeric : text.isNumeric && string.isNumeric
     } else {
     isMobileInput = false
     }

     if isMobileInput {
     if !text.isValidPhone {
     disableSigninButton()
     }
     } else if (text.contains("@")){
     if !text.isValidEmail() {
     disableSigninButton()
     }
     }

     //        var tempFlag = false
     //        otpView.otpTextFields.forEach { (tf) in
     //            if /tf.text?.trim().isEmpty {
     //                tempFlag = true
     //            }
     //        }
     //
     //        if tempFlag {
     //            disableSigninButton()
     //        } else {
     //            enableSigninButton()
     //        }

     //        if(otpView.otpText.count == 4){
     //            enableSigninButton()
     //        }

     return true
     }
     */
}
