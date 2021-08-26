//
//  vcViewModel.swift
//  restNew
//
//  Created by Rahul Patel on 02/07/21.
//

import UIKit
import Foundation

class vcViewModelGrow: NSObject {
    
    override init() {
        super.init()
    }
    
    func getGrowStories(viewCurrent: UIView?, result: @escaping(Result<Grow?,ApiError>) -> Void){
        ApiManager.shared.fetch(endpoints: .grow, endUerName: "", methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
    func getGrowJobs(viewCurrent: UIView?, result: @escaping(Result<GrowJobs?,ApiError>) -> Void){
        ApiManager.shared.fetch(endpoints: .growJobs, endUerName: "", methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
    func getBookmarks(viewCurrent: UIView?, result: @escaping(Result<Bookmarks?,ApiError>) -> Void){
        ApiManager.shared.fetch(endpoints: .getBookMarks, endUerName: "", methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
    
    
    func getGrowSetBookmark(jobId: String? , userId : String? , isBook : String? , viewCurrent: UIView?, result: @escaping(Result<Grow?,ApiError>) -> Void){
        
        let info = ["JobID":  jobId,"UserID": userId , "IsBook" :isBook]
        ApiManager.shared.fetch(endpoints: .growSetBookmark, endUerName: "", methodType: .post, contentType: .applicationJson, param: info, completion: result)
    }
    
    func getGrowJobsApply(jobId: String? , userId : String? , ipaddress : String? , operationgSystem : String, viewCurrent: UIView?, result: @escaping(Result<Grow?,ApiError>) -> Void){
        
        let info = ["JobID":  jobId, "UserID": userId , "IPAddress" : ipaddress , "OperationSystem" : operationgSystem]
        ApiManager.shared.fetch(endpoints: .growJobsApply, endUerName: "", methodType: .post, contentType: .applicationJson, param: info, completion: result)
    }
   
}

