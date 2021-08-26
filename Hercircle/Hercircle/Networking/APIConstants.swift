//
//  APIConstants.swift
//  Keyword Market
//
//  Created by Admin on 22/11/17.
//  Copyright © 2017 Postgram Pte Ltd. All rights reserved.
//

import Foundation
import UIKit

let DEVICE_ID = UIDevice.current.identifierForVendor

enum endPoint : String {
    
    case signIn_with_password = "us/api/HerCirlce/UserDetails"
    case validateUsername = "us/api/User/ValidateUsername"
    case otpVerify = "us/api/User/OTPVerify"
    case usernameSuggestion = "us/api/User/UsernameSuggestion"
    case otpLogin = "User/OTPLogin"
    case otpSend = "us/api/User/OTPSend"
    case changeOrForgotPassword = "us/api/HerCirlce/Updatecred"
    case signUp = "us/api/HerCirlce"

    //MARK:- Engage
    case engage = "hccms_engagearticle/api/Engage/GetStory/Engage"

    //MARK:- Grow
    case grow = "hccms_engagearticle/api/Engage/GetStory/Grow"
    case growJobs = "hc_grow/api/Job/GetJobDetails"
    case growJobsApply = "hc_grow/api/Job/JobUserApply"
    case growSetBookmark = "hc_grow/api/job/UpdateBookmark"
    case getBookMarks = "hc_grow/api/job/GetBookmark/"

    //MARK:- Home
    
    case communities = "us/api/Communities/GetCommunities"
    case helpGetData = "hccms_help_get/api/Help/GetExpertDetails"
    case helpPostQuestions = "hccms_help_get/api/Help/AddQuery"
    case helpGetQueries = "hccms_help_get/api/Help/GetHelpQuery"
    case helpDeleteQueries = "hccms_help_get/api/Help/DeleteHelpQuery"
    case userRelatedCommunities = "connect/api/Communities/GetCommunities/"
    
    //MARK:- DietFitness Goal
    
    case dietUserDetails = "dt/api/diet/"
    case dietPostMeal = "dt/api/Diet/Meal_Tansaction"
    case postLifeStyle = "dt/api/Diet/Post_DietTracker"
    case postExcercise = "dt/api/Diet/Exercise_Tansaction"
    
    //MARK:-
    case insights = "hccms_engagearticle/api/Engage/GetStory/Engage/4"
    case postLeaveComunity = "connect/api/Communities/JoinLeaveCommunity"
}

