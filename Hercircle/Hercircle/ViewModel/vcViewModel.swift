//
//  vcViewModel.swift
//  restNew
//
//  Created by Rahul Patel on 02/07/21.
//

import UIKit
import Foundation

class vcViewModel: NSObject {
    override init() {
        super.init()
    }
    func getUser(name:String, result: @escaping(Result<vcModel?,ApiError>) -> Void){

        ApiManager.shared.fetch(endpoints: .validateUsername, endUerName:name, methodType: .get, contentType: .applicationJson, param:  "", completion: result)

//        let userInfo = ["UserName":  "pandurang","Password": "NB8n4KdxRhs8jlOlkFc/pJ/VkZuvKD37H+uRUQ2h0wU="]
//        ApiManager.shared.fetch(endpoints: .SignIn_with_password, isAuthRequired: true, methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
        
    }
    func getSignUp(userName:String,pass:String,firstname:String,lastName:String,mobile:String,email:String,gender:String,countryId:String,newsletterCheck:String,viewCurrent: UIView?, result: @escaping(Result<SignIn?,ApiError>) -> Void){

        let userInfo = ["UserName":  userName,"Password": pass , "FirstName" :firstname , "LastName" : lastName , "Mobile" :mobile , "Email" : email , "Gender" : gender , "countryID" : countryId , "NewsletterCheck" :  newsletterCheck , "isOTP": "true"]
        ApiManager.shared.fetch(endpoints: .signUp, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func getSignIn(userName:String,pass:String,viewCurrent: UIView?, result: @escaping(Result<SignIn?,ApiError>) -> Void){

        let userInfo = ["UserName":  userName,"Password": pass]
        ApiManager.shared.fetch(endpoints: .signIn_with_password, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func getSignInWithOtp(userName:String,pass:String,otp:String, viewCurrent: UIView?, result: @escaping(Result<SignIn?,ApiError>) -> Void){

        let userInfo = ["UserName":  userName,"Password": pass ,"IsOTP":otp]
        ApiManager.shared.fetch(endpoints: .signIn_with_password, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    
    
    func postChangePassword(UserId:String, password:String?,viewCurrent: UIView?, result:@escaping(Result<SignIn?,ApiError>) -> Void){

        let userInfo = ["UserId" :  UserId , "password" : password]
        ApiManager.shared.fetch(endpoints: .changeOrForgotPassword, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func postOtpLogin(sessionId:String, userName:String?,viewCurrent: UIView?, result:@escaping(Result<SignIn?,ApiError>) -> Void){

        let userInfo = ["SessionID" :  sessionId , "UserName" : userName]
        ApiManager.shared.fetch(endpoints: .otpLogin, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func postOtpSend(userName:String ,viewCurrent: UIView?, result:@escaping(Result<SignInModel?,ApiError>) -> Void){

        let userInfo = ["UserName" : userName]
        ApiManager.shared.fetch(endpoints: .otpSend, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func postOtpVerify(userId:String, userName:String?, txnId :String?, otp:String? ,viewCurrent: UIView?, result:@escaping(Result<SignInModel?,ApiError>) -> Void){

        let userInfo = ["UserId" :  userId , "UserName" : userName , "OTP" : otp , "txnId" : txnId]
        ApiManager.shared.fetch(endpoints: .otpVerify, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func postOtpVerification(userId:String, sessionId:String, userName:String?, otp:String? ,viewCurrent: UIView?, result:@escaping(Result<SignIn?,ApiError>) -> Void){

        let userInfo = ["UserId":  userId , "SessionID": sessionId , "UserName" : userName , "OTP" : otp]
        ApiManager.shared.fetch(endpoints: .otpVerify, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func postUsernameSuggestion(userName:String, firstName:String, lastName:String?,viewCurrent: UIView?, result:@escaping(Result<UserSuggestions?,ApiError>) -> Void){

        let userInfo = ["UserName":  userName , "FirstName": firstName , "LastName" : lastName]
        ApiManager.shared.fetch(endpoints: .usernameSuggestion, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func postSocialSignUp(userName:String,pass:String,firstname:String,lastName:String,mobile:String,email:String,gender:String,countryId:String,newsletterCheck:String,viewCurrent: UIView?, result: @escaping(Result<SignIn?,ApiError>) -> Void){

        let userInfo = ["UserName":  userName,"Password": pass , "FirstName" :firstname , "LastName" : lastName , "Mobile" :mobile , "Email" : email , "Gender" : gender , "countryID" : countryId , "NewsletterCheck" :  newsletterCheck]
        ApiManager.shared.fetch(endpoints: .signIn_with_password, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
}


extension vcViewModel {
    
    func getHomeData(viewCurrent: UIView?, result: @escaping(Result<HomeData?,ApiError>) -> Void){

        ApiManager.shared.fetch(endpoints: .engage, endUerName: "", methodType: .get, contentType: .applicationJson, param:  "", completion: result)
    }
    
    func getCommunitiesData(viewCurrent: UIView?, result: @escaping(Result<CommunityData?,ApiError>) -> Void){

        ApiManager.shared.fetch(endpoints: .communities, endUerName: "", methodType: .get, contentType: .applicationJson, param:  "", completion: result)
    }
    
    func getUserRelatedCommunitiesData(userId: String, viewCurrent: UIView?, result: @escaping(Result<CommunityData?,ApiError>) -> Void){

        ApiManager.shared.fetch(endpoints: .userRelatedCommunities, endUerName: userId, methodType: .get, contentType: .applicationJson, param:  "", completion: result)
    }
}
