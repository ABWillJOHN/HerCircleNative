//
//  vcModel.swift
//  restNew
//
//  Created by Rahul Patel on 02/07/21.
//

import UIKit
import Foundation

//struct vcModel: Codable {
//
//    let data : String?
//    let statusCode : Int?
//    let success : Bool?
//    let userMsg : String?
//    let systemMsg : String?
//    let sessioncheck : Bool?
//    let quantity : Bool?
//    let userValidation : Bool?
//}
//
//struct SignIn: Codable {
//
//    let data: userInfo
//    let statusCode: Int?
//    let userMsg, systemMsg: String?
//    let success, sessioncheck, userValidation: Bool?
//}
//
//struct userInfo: Codable {
//
//    let userID, userName: String?
//    let displayName: String?
//    let gender: String?
//    let firstName, lastName: String?
//    let email, mobileNumber, countryCode: String?
//    let dob, location: String?
//    let profileFilePath, bannerFilePath: String?
//    let roleID: Int?
//    let dnd: Bool?
//    let loginDeviceID, loginToken: String?
//    let verifyEmail: Bool?
//    let gUsername, fbUsername, appleUsername: String?
//    let status: String?
//    let password : String?
//    let pushNotficationStatus, fcmToken, deviceType, deviceID: String?
//}


import UIKit

import Foundation

struct vcModel: Codable {
    let data : String?
    let statusCode : Int?
    let success : Bool?
    let userMsg : String?
    let systemMsg : String?
    let sessioncheck : Bool?
    let quantity : Bool?
    let userValidation : Bool?
}

struct SignIn: Codable {
    let data: [userInfo]
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct Grow: Codable {
    let data: Stories?
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct GrowJobs: Codable {
    let data: [GrowJobsListing]?
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct Bookmarks: Codable {
    let data: [BookMarksList]?
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct BookMarksList: Codable {
    let userID : String?
    let jobID : Int?
    var isBook :Bool? = false
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct GrowJobsListing: Codable {
    let jobid: Int?
    var isBook : Bool? = false
    var isJobApplied :Bool? = false
    let titleHeader , description , location , companyName , source: String?
    let companyLogo : String?
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}


struct Stories : Codable {
    let creativeCornor: [CreativeCornor]
    let infiniteStory: [InfiniteStory]
}

struct InfiniteStory : Codable {
    
    let contentId  , contentTypeId , categoryId:Int?
    let titleHeader , author , contentSummary , isLeadStory , mediaFileName , mediaURL , contentURL , categoryName , subCategoryName : String
    let validFrom : String
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct CreativeCornor : Codable {
    
    let contentId  , contentTypeId , categoryId:Int?
    let titleHeader , author , contentSummary , isLeadStory , mediaFileName , mediaURL , contentURL , categoryName , subCategoryName : String
    let validFrom : String
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
    
}

struct UserSuggestions: Codable {
    let data: [String]
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct ErrorMsg: Codable {
    let data: String
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct userInfo: Codable {
    let userId, userName , txnId , password: String?
    let displayName: String?
    let gender: String?
    let firstName, lastName: String?
    let email, mobileNumber, countryCode: String?
    let dob, location: String?
    let profileFilePath, bannerFilePath: String?
    let roleID: Int?
    let dnd: Bool?
    let loginDeviceID, loginToken: String?
    let verifyEmail: Bool?
    let gUsername, fbUsername, appleUsername: String?
    let status: String?
    let pushNotficationStatus, fcmToken, deviceType, deviceID: String?
}

struct SignInModel: Codable {
    let data: userInfo
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

////Insights//////////////
struct CommunitiesModel: Codable {
    let data : CommunitiesList
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}

struct InsightsModel: Codable {
    let data : Insights?
    let statusCode: Int?
    let userMsg, systemMsg: String?
    let success, sessioncheck, userValidation: Bool?
}


struct Insights : Codable {
    
    let engageVideo : [InsightsListing]
}


struct InsightsListing : Codable {
    
    let contentId , contentTypeId , categoryId : Int?
    let titleHeader  , mediaFileName , mediaURL , categoryName ,subCategoryName , contentURL : String?
    let author , validUpTo : String?
}


struct CommunitiesList : Codable {
    let popularCommunities : [PopularCommunties]
}

struct PopularCommunties : Codable {
     
    let communityId , interestId  , communityId1 , members , trackerId : Int?
    let communityName , communityDescription , mediaFileName : String?
    let isPublic : Bool?
    var isJoined : Bool?
    
}
