//
//  HelpModel.swift
//  Hercircle
//
//  Created by Gaurav on 16/07/21.
//

import Foundation
import UIKit

/////////////////////////Help experts Data here //////////////////////////////////////////////////
struct Help: Codable {
    let data: [Experts]
    let statusCode: Int
    let success: Bool
    let userMsg, systemMsg: String
}

// MARK: - Experts
struct Experts: Codable {
    let expertID: Int
    let salutation: String
    let firstName, middleName, lastName, specializationTitle: String
    let specializationSummary, profession, professionalExperience, specializationAreas: String
    let isChargable: Bool
    let mediaFileName, qualification: String
    let associatedWith: String
    let workingAt, email, mobileNumber, availabilitySlots: String
    let imageURL: String
}
//MARK: - Ask Experts
struct HelpAskQuestion: Codable {
    let data: String
    let statusCode: Int
    let success: Bool
    let userMsg, systemMsg: String
}

//MARK: - Get Questions
class HelpGetQuestion: Codable {
    let data: [Questions]
    let statusCode: Int
    let success: Bool
    let userMsg, systemMsg: String

}

// MARK: - Datum
class Questions: Codable {
    let queryId: Int?
    let queryReferenceNumber: String?
    let helplineCategoryID: Int?
    let queryTitle, queryDescription: String?
    let queryAttachement: String?
    let queryStatus: String?
    let assignedTo: Int?
    let expertRemark, expertResolution: String?
    let isActive: Bool?
    let createdBy, createdOn: String?
    let updatedBy, updatedOn: String?
}

// MARK: - DeleteQuestion
class DeleteQuestion: Codable {
    let data: String?
    let statusCode: Int?
    let success: Bool?
    let userMsg, systemMsg: String?
}
