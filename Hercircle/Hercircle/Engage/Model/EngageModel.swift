//
//  EngageModel.swift
//  Hercircle
//
//  Created by Rahul Patel on 21/07/21.
//

import Foundation

class EngageModel: Codable {
    let data: DataClass?
    let statusCode: Int?
    let success: Bool?
    let userMsg, systemMsg: String?

}

// MARK: - DataClass
class DataClass: Codable {
    let categories: [Category]?
    let homeLead, engageLead, editorChoice, todaysTop: [CreativeCornors]?
    let creativeCornor, engageVideo, infiniteStory: [CreativeCornors]?
}

// MARK: - Category
class Category: Codable {
    let categoryId: Int
    let categoryName: String?
    let createdBy: String?
    let createdOn: String?
    let updatedBy: String?
    let updatedon: String?
    let subCategories: [SubCategory]?
}
// MARK: - SubCategory
class SubCategory: Codable {
    let categoryId: Int
    let categoryName: String?
    let createdBy: String?
    let createdOn: String?
    let updatedBy: String?
    let updatedon: String?
}


// MARK: - CreativeCornor
class CreativeCornors: Codable {
    let contentId, contentTypeId, categoryId: Int
    let titleHeader, author, validFrom, validUpTo: String?
    let contentSummary, tags: String?
    let publishedFor: String?
    let isLeadStory: String?
    let mediaFileName: String?
    let mediaURL: String?
    let contentURL: String?
    let categoryName: String?
    let subCategoryName: String?

}

//class EngageModel: Codable {
//    let data: DataClass
//    let statusCode: Int
//    let success: Bool
//    let userMsg, systemMsg: String
//
//    init(data: DataClass, statusCode: Int, success: Bool, userMsg: String, systemMsg: String) {
//        self.data = data
//        self.statusCode = statusCode
//        self.success = success
//        self.userMsg = userMsg
//        self.systemMsg = systemMsg
//    }
//}
//
//
//
////// MARK: - DataClass
//class DataClass: Codable {
//    let categories: [Category]
//    let homeLead, engageLead, editorChoice, todaysTop: [CreativeCornor]
//    let creativeCornor, engageVideo, infiniteStory: [CreativeCornor]
//
//    init(categories: [Category], homeLead: [CreativeCornor], engageLead: [CreativeCornor], editorChoice: [CreativeCornor], todaysTop: [CreativeCornor], creativeCornor: [CreativeCornor], engageVideo: [CreativeCornor], infiniteStory: [CreativeCornor]) {
//        self.categories = categories
//        self.homeLead = homeLead
//        self.engageLead = engageLead
//        self.editorChoice = editorChoice
//        self.todaysTop = todaysTop
//        self.creativeCornor = creativeCornor
//        self.engageVideo = engageVideo
//        self.infiniteStory = infiniteStory
//    }
//}
//
//// MARK: - Category
//class Category: Codable {
//    let categoryID: Int
//    let categoryName: String
//    let createdBy: String
//    let createdOn: String
//    let updatedBy: String
//    let updatedon: String
//    let subCategories: [Category]?
//
//    enum CodingKeys: String, CodingKey {
//        case categoryID = "categoryId"
//        case categoryName, createdBy, createdOn, updatedBy, updatedon, subCategories
//    }
//
//    init(categoryID: Int, categoryName: String, createdBy: String, createdOn: String, updatedBy: String, updatedon: String, subCategories: [Category]?) {
//        self.categoryID = categoryID
//        self.categoryName = categoryName
//        self.createdBy = createdBy
//        self.createdOn = createdOn
//        self.updatedBy = updatedBy
//        self.updatedon = updatedon
//        self.subCategories = subCategories
//    }
//}
//
//
//
//// MARK: - CreativeCornor
//class CreativeCornor: Codable {
//    let contentID, contentTypeID, categoryID: Int
//    let titleHeader, author, validFrom, validUpTo: String
//    let contentSummary, tags: String
//    let publishedFor: String
//    let isLeadStory: String
//    let mediaFileName: String
//    let mediaURL: String
//    let contentURL: String
//    let categoryName: String
//    let subCategoryName: String
//
//    enum CodingKeys: String, CodingKey {
//        case contentID = "contentId"
//        case contentTypeID = "contentTypeId"
//        case categoryID = "categoryId"
//        case titleHeader, author, validFrom, validUpTo, contentSummary, tags, publishedFor, isLeadStory, mediaFileName, mediaURL, contentURL, categoryName, subCategoryName
//    }
//
//    init(contentID: Int, contentTypeID: Int, categoryID: Int, titleHeader: String, author: String, validFrom: String, validUpTo: String, contentSummary: String, tags: String, publishedFor: String, isLeadStory: String, mediaFileName: String, mediaURL: String, contentURL: String, categoryName: String, subCategoryName: String) {
//        self.contentID = contentID
//        self.contentTypeID = contentTypeID
//        self.categoryID = categoryID
//        self.titleHeader = titleHeader
//        self.author = author
//        self.validFrom = validFrom
//        self.validUpTo = validUpTo
//        self.contentSummary = contentSummary
//        self.tags = tags
//        self.publishedFor = publishedFor
//        self.isLeadStory = isLeadStory
//        self.mediaFileName = mediaFileName
//        self.mediaURL = mediaURL
//        self.contentURL = contentURL
//        self.categoryName = categoryName
//        self.subCategoryName = subCategoryName
//    }
//}
//
//
