//
//  HomeData.swift
//  Hercircle
//
//  Created by vishal modem on 7/21/21.
//

import Foundation

struct HomeData: Codable {
    let data: Categories?
}

struct Categories: Codable {
    let homeLead: [MediaInfo]?
    let todaysTop: [MediaInfo]?
    let engageVideo: [MediaInfo]?
    let creativeCornor: [MediaInfo]?
    let infiniteStory: [MediaInfo]?
}

struct MediaInfo: Codable {
    let contentId, categoryId, contentTypeId : Int?
    let titleHeader: String?
    let author: String?
    let categoryName: String?
    let mediaFileName: String?
    let validFrom: String?
    let contentSummary, contentURL, mediaURL : String?
    let publishedFor, subCategoryName, tags, validUpTo : String?
    let isLeadStory: String?
}

struct CommunityData: Codable {
    let data: [CommunityInfo]?
    let statusCode: Int?
    let success, userValidation, sessioncheck : Bool?
    let systemMsg, userMsg : String?
}

struct CommunityInfo: Codable {
    let communityId, interestId: Int?
    let communityName: String?
    let communityDescription: String?
    let mediaFileName: String?
    let members: Int?
    let isPublic: Bool?
}

struct JobData: Codable {
    let data: [JobInfo]?
    let statusCode: Int?
    let success: Bool?
    let systemMsg, userMsg : String?
}

struct JobInfo: Codable {
    let jobid: Int?
    let titleHeader: String?
    let description: String?
    let location: String?
    let companyName: String?
    let postedBy, companyLogo, source: String?
}
