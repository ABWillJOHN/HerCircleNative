//
//  Validation.swift
//  Wranga
//
//  Created by Rahul Shivhare on 25/05/20.
//  Copyright © 2020 Wranga. All rights reserved.
//

import UIKit

//for failure and success results
enum ErrorAlert {
    case success
    case failure
    case error
}

//for success or failure of validation with alert message

enum isValid {
    case success
    case failure(ErrorAlert, AlertMessages)
}

enum Valid{
    case success
    case failure(String)
}

let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
let phoneRegex = "^[0-9]{9,15}$"
let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
let passwordRegex = "[A-Z0-9a-z._%@+-]{6,15}"
let idValidation = "[A-Z0-9a-z._%@+-/*]{3,20}"
let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
let idTest = NSPredicate(format: "SELF MATCHES %@", idValidation)


enum AlertMessages: String {
    case inValidEmail = "Please enter valid email address"
    case inValidPhone = "Please enter valid phone number"
    case emptyEmail = "Please enter email address"
    case emptyLogin = "Please enter email or phonenumber or username for login"
    case inValidPSW = "Password must be atleast 6 characters long"
    case enterPassword = "Please enter password"
    case passwordcount = "Password must be at least 8 characters."
    case validPassword = "Please enter a valid password"
    case newPassword = "Please enter new password"
    case confirmPassword = "Please enter confirm password"
    case passwordNotMatch = "Password does not match"
    case oldPassword = "Please enter old password"
    case dob = "Please enter Data of Birth"
    case emptyName = "Please enter Name."
    case logoutPopup = "Are you sure you want to logout?"
    case enterEmailPhone = "Please enter valid email or phonenumber for signup"
    
}

class Validation: NSObject {
    public static let shared = Validation()
    
    //Mark:-SignUp
    func validateSignUp(_ name: String?, _ email:String?, _ password:String?) -> Valid {
        if (name?.isEmpty)!{
            return .failure(AlertMessages.emptyName.rawValue)
        }
        if (email?.isEmpty)!{
            return .failure(AlertMessages.emptyEmail.rawValue)
        }
        if emailTest.evaluate(with: email) == false{
            return .failure(AlertMessages.inValidEmail.rawValue)
        }
        if (password?.isEmpty)! {
            return .failure(AlertMessages.newPassword.rawValue)
        }
        if (password?.count)! < 8 {
            return .failure(AlertMessages.passwordcount.rawValue)
        }
        return .success
    }
    
    func validateEmailPhone(_ email: String?) -> Valid {
        if (email?.isEmpty)!{
            return .failure(AlertMessages.enterEmailPhone.rawValue)
        }
        if (email?.contains("@"))! {
            if emailTest.evaluate(with: email) == false{
                return .failure(AlertMessages.inValidEmail.rawValue)
            }
            else {return .success}
        }
        else if(/email?.isNumeric){
        if phoneTest.evaluate(with: email) == false{
            return .failure(AlertMessages.inValidPhone.rawValue)
        }
        else {return .success}
        }
        else {return .failure(AlertMessages.enterEmailPhone.rawValue)}
    }
    
    
    //MARK:-Login
    func validateLogin(_ email: String?, _ password: String?) -> Valid {
        if (email?.isEmpty)!{
            return .failure(AlertMessages.emptyLogin.rawValue)
        }
        if (email?.contains("@"))! {
            if emailTest.evaluate(with: email) == false{
                return .failure(AlertMessages.inValidEmail.rawValue)
            }
        }
         if(/email?.isNumeric){
        if phoneTest.evaluate(with: email) == false{
            return .failure(AlertMessages.inValidPhone.rawValue)
        }
        }
        if (password?.isEmpty)! {
            return .failure(AlertMessages.enterPassword.rawValue)
        }
        return .success
    }
    
    //MARK:-Reset Password
    func validatePassword(_ password: String?, _ confirmPassword: String?) -> Valid{
        if (password?.trim().isEmpty)! {
            return .failure(AlertMessages.newPassword.rawValue.localized())
        }
        if (password?.trim().count)! < 8 {
            return .failure(AlertMessages.passwordcount.rawValue.localized())
        }
        if (confirmPassword?.trim().isEmpty)! {
            return .failure(AlertMessages.confirmPassword.rawValue.localized())
        }
        if !((password)?.trim().isEqual(confirmPassword))! {
            return .failure(AlertMessages.passwordNotMatch.rawValue.localized())
        }
        return .success
    }
    
    //MARK:-Forgot Password
    func validateForgot(_ email: String?) -> Valid {
        if (email?.isEmpty)!{
            return .failure(AlertMessages.emptyEmail.rawValue)
        }
        if emailTest.evaluate(with: email) == false{
            return .failure(AlertMessages.inValidEmail.rawValue)
        }
        return .success
    }
}
