//
//  HelpVM.swift
//  Hercircle
//
//  Created by Gaurav on 16/07/21.
//

import Foundation

class HelpVM: NSObject {
    override init() {
        super.init()
    }
    func getUser(result: @escaping(Result<Help?,ApiError>) -> Void){

        ApiManager.shared.fetch(endpoints: .helpGetData, endUerName:"", methodType: .get, contentType: .applicationJson, param:  "",isHelpModule: true, completion: result)

    }
    
    func postQuestionToExpert(queryDesc: String,assigned: String,isActive: Int,createdBy: String,createdOn: String,helplineCatId: Int,result: @escaping(Result<HelpAskQuestion?,ApiError>) -> Void) {
        
        let userInfo = ["QueryDescription" :  queryDesc , "AssignedTo" : assigned , "IsActive" : "\(isActive)" , "CreatedBy" : createdBy, "CreatedOn": createdOn, "HelplineCategoryId": "\(helplineCatId)"]
        ApiManager.shared.fetch(endpoints: .helpPostQuestions, endUerName:"", methodType: .post, contentType: .applicationJson, param:  userInfo,isHelpModule: true, completion: result)
    }
    
    func getQueriesToExpert(createdBy: String, assignedTo: String,param : [String : Any], result: @escaping(Result<HelpGetQuestion?,ApiError>) -> Void) {
        
        let userInfo = ["CreatedBy" : createdBy , "AssignedTo" : assignedTo]
        ApiManager.shared.fetch(endpoints: .helpGetQueries, endUerName:"", methodType: .post, contentType: .applicationJson, param:  userInfo,isHelpModule: true, completion: result)
    }
    
    func deleteQueries(updateBy: String, queryID: String, result: @escaping(Result<DeleteQuestion?,ApiError>) -> Void) {
        let userInfo = ["UpdatedBy" : updateBy.trim(), "QueryId" : queryID.trim()]
        ApiManager.shared.fetch(endpoints: .helpDeleteQueries, endUerName:"", methodType: .post, contentType: .applicationJson, param:  userInfo,isHelpModule: true, completion: result)
        
    }
    
    
}


