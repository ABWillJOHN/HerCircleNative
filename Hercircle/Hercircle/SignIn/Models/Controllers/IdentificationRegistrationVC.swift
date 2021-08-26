//
//  IdentificationRegistrationViewController.swift
//  Hercircle
//
//  Created by vishal modem on 6/30/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import DialCountries
import AuthenticationServices

class IdentificationRegistrationVC: UIViewController, UITextFieldDelegate , DialCountriesControllerDelegate {
    
    var userName : String?
    var userid : String?
    var mobile : String?
    var email : String?
    var txnId : String?

    func didSelected(with country: Country) {
        self.countryTextField?.text = country.name
        self.countryCodeTextField?.text = country.dialCode
    }
    
    enum SignupWay {
        case mobile
        case email
    }

    enum ButtonTitles: String {
        case continueText = "Continue"
        case getOtp = "Get OTP"
    }

    @IBOutlet weak var mobileView: MobileView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var countryTextField: BottomLineTextField!
    @IBOutlet weak var emailStackview: UIStackView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet var bottomCardView: UIView!
    
    @IBOutlet weak var emailTextField: BottomLineTextField!
    @IBOutlet weak var otpView: OTPView!
    
    lazy var mobileTextField = mobileView.mobileNumberTextField
    lazy var countryCodeTextField = mobileView.countryCodeTextfield
    lazy var btnSelectCountryCode = mobileView.btnSelectCountryCode
    
    
    @IBOutlet weak var imgMaleCheckMark: UIImageView!
    @IBOutlet weak var imgFemaleCheckMark: UIImageView!
    
    
    var blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    var isMobileInput = false
    fileprivate var isBottomCardVisible = false
    private let bottomCardHeight: CGFloat = 200
    
    private var signupState: SignupWay = .email {
        didSet {
            switch signupState {
            case .email:
                mobileView.isHidden = true
                otpView.isHidden = true
                emailStackview.isHidden = false
                continueButton.setTitle(ButtonTitles.continueText.rawValue, for: .normal)
            default:
                emailStackview.isHidden = true
                mobileView.isHidden = false
                otpView.isHidden = true
                continueButton.setTitle(ButtonTitles.getOtp.rawValue, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurView)
        view.addSubview(bottomCardView)
        blurView.frame = view.bounds
        
        signupState = isMobileInput ? .email : .mobile
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnBlurView(_:)))
        blurView.addGestureRecognizer(tap)
        
        setupBottomCardView()
        showHideBottomCardView()
        blurView.alpha = 0
        mobileTextField?.delegate = self
        
        segmentedControl.addTarget(self, action: #selector(handleValueChange(control:)), for: .valueChanged)
        
        otpView.resendOTPButton.addTarget(self, action: #selector(handleResendOtp), for: .touchUpInside)
        if signupState == .mobile {
            otpView.handleButtonState = { [weak self] isEmpty in
                if isEmpty {
                    self?.disableContinueButton()
                } else {
                    self?.enableContinueButton()
                }
            }
        }
        self.countryTextField?.text = "India"
        if !isMobileInput {
            disableContinueButton()
        }
        
        btnSelectCountryCode?.addTarget(self, action: #selector(countryCodeSelection), for: .touchUpInside)
        mobileTextField?.floatingLabelXPadding = -100
        mobileView.isHidden = isMobileInput
        setupCountryTextField()
    }
    
    @objc func handleResendOtp() {
        sendOtp(integer: 2) //2 reset // 1 send first time
    }
    
    @objc func countryCodeSelection() {
        DispatchQueue.main.async {
            
            let cv = DialCountriesController(locale: Locale(identifier: "en"))
            cv.delegate = self
            cv.show(vc: self)
        }
    }
    
    @objc func handleTapOnBlurView(_ gesture: UITapGestureRecognizer) {
        showHideBottomCardView()
    }
    @IBAction func btnSelectCountry(_ sender: Any) {
        
        DispatchQueue.main.async {
            
            let cv = DialCountriesController(locale: Locale(identifier: "en"))
            cv.delegate = self
            cv.show(vc: self)
        }
    }
    
    @objc func handleValueChange(control: UISegmentedControl) {
        switch control.selectedSegmentIndex {
        case 0:
            print(control.selectedSegmentIndex)
        default:
            showAlert(title: "Sorry", message: "This part of Her Circle is only for those above 18. You can continue to enjoy our stories and videos on Home Page.", actionText1: "Go to Homepage", actionText2: "Cancel", action1: { _ in
                self.navigateToLoginVC()
            })
        }
    }
    
    private func setupCountryTextField() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow-down"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(countryTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        countryTextField.rightView = button
        countryTextField.rightViewMode = .always
    }

    @IBAction func menProfileTapped(_ sender: UIButton) {
        showAlert(title: "Sorry", message: "This part of HerCircle is only for women. You can continue to enjoy our stories and videos home page.", actionText1: "Tell your women friends about us", actionText2: "Go to Homepage") { _ in
            self.showHideBottomCardView()
        } action2: { _ in
            self.navigateToLoginVC()
        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailRegistrationSegue", let vc = segue.destination as? DetailsRegistrationVC {
            vc.gender = "F"
            vc.countryID = "1"
            vc.email = /self.email?.count > 0 ? self.email : /emailTextField.text?.trim()
            vc.mobile = /self.mobile?.count > 0 ? self.mobile : /mobileTextField?.text?.trim()
        }
    }
    
    @IBAction func womenProfileTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func continueButtonClicked(_ sender: UIButton) {
        switch sender.currentTitle {
        case ButtonTitles.continueText.rawValue:
            otpView.invalidateTimer()
            if signupState == .mobile {
               self.otpVerify(integer: 1)  // from mobile
            } else {
                performSegue(withIdentifier: "detailRegistrationSegue", sender: self) // from email
            }
        default:
            if let number = mobileTextField?.text, number.isValidPhone {
                sendOtp(integer: 1)
            }
        }
    }
    
    func sendOtp(integer :Int) {
    
        vcViewModel().postOtpSend(userName: /mobileTextField?.text?.trim(),  viewCurrent: self.view) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        
                        self.userid = user?.data.userId
                        self.userName = user?.data.userName
                        self.txnId = user?.data.txnId

                        self.otpView.isHidden = false
                        self.otpView.invalidateTimer()
                        self.otpView.clearOtpText()
                        self.otpView.startOtpTimer()
                        self.otpView.resendOTPButton.isHidden = true
                        self.continueButton.setTitle(ButtonTitles.continueText.rawValue, for: .normal)
                        self.disableContinueButton()
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
       
      //  performSegue(withIdentifier: "detailRegistrationSegue", sender: self)

        vcViewModel().postOtpVerify(userId: /self.userid ,  userName: /self.userName, txnId: txnId , otp:/otpView.otpText, viewCurrent: self.view) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        if integer == 2 {
                            SideMenuHandler.shared.presentSideMenu(with: self)
                        } else {
                            self.performSegue(withIdentifier: "detailRegistrationSegue", sender: self)
                        }
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

    
    @IBAction func handleCheckMark(_ sender: SelectionButton) {
        sender.hasCheckMark = !sender.hasCheckMark
    }
    
    @IBAction func handleSignIn(_ sender: UIButton) {
        navigateToLoginVC()
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
                        self.email = email
                        UserDefaults.signinEmail = email
                        if user?.systemMsg == "Data inserted successfully!" {
                            self.isMobileInput = false
                            self.signupState = .mobile
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
    
    func setupBottomCardView() {
        bottomCardView.constrainHeight(constant: bottomCardHeight)
        bottomCardView.constrainWidth(constant: view.frame.width - 100)
        bottomCardView.centerInSuperview()
        bottomCardView.layer.cornerRadius = 16
        bottomCardView.subviews[0].layer.cornerRadius = 16
        bottomCardView.subviews[0].layer.masksToBounds = true
        
    }
    
    fileprivate func showHideBottomCardView() {
        if isBottomCardVisible {
            isBottomCardVisible = false
            UIView.animate(withDuration: 0.3) {
                self.bottomCardView.alpha = 1
            } completion: { _ in
                self.blurView.alpha = 1
            }
        } else {
            isBottomCardVisible = true
            UIView.animate(withDuration: 0.3) {
                self.bottomCardView.alpha = 0
            } completion: { _ in
                self.blurView.alpha = 0
            }
        }
    }
    
    private func navigateToLoginVC() {
        if let loginVC = self.navigationController?.viewControllers[0] as? LoginVC {
            loginVC.loginState = .signinWithEmailPassword
            self.navigationController?.popToViewController(loginVC, animated: true)
        }
    }
}

extension IdentificationRegistrationVC: GIDSignInDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
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

extension IdentificationRegistrationVC {
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let enteredText = textField.text, enteredText.isValidPhone  {
//            enableContinueButton()
//        }
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if otpView.isHidden == false {
            otpView.isHidden = true
            otpView.clearOtpText()
            continueButton.setTitle(ButtonTitles.getOtp.rawValue, for: .normal)
            disableContinueButton()
        }
        guard let text = textField.text else {
            return true
        }
        
//        if !text.isValidPhone {
//            disableContinueButton()
//        }
        if text.count > 2 {
            isMobileInput = string.isEmpty ? text.isNumeric : text.isNumeric && string.isNumeric
        } else {
            isMobileInput = false
        }

         let phonetxt = textField.text! + string
        if isMobileInput {
            if phonetxt.count > 9 && phonetxt.count < 11 && phonetxt.isValidPhone{
                enableContinueButton()
            }
            else {
                disableContinueButton()
            }
        }
        return true
    }
    
}
