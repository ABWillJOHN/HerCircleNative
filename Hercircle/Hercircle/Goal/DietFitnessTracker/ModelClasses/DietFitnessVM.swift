//
//  DietFitnessVM.swift
//  Hercircle
//
//  Created by Apple on 04/08/21.
//

import Foundation
class DietFitnessVM: NSObject {
    override init() {
        super.init()
    }
    func getDietDetail(name:String, result: @escaping(Result<UserDietData?,ApiError>) -> Void){

        ApiManager.shared.fetch(endpoints: .dietUserDetails, endUerName:name, methodType: .get, contentType: .applicationJson, param:  "", completion: result)

    }
    
    func postMealWorkout(user: String,mealId:String, dietID:String,quantity: String, result:@escaping(Result<SignInModel?,ApiError>) -> Void){

        let userInfo = ["UserID" :  user , "DietID" : dietID,"MealID":mealId, "Quantity":  quantity]
        ApiManager.shared.fetch(endpoints: .dietPostMeal, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func getCaloriConsumed(name:String, result: @escaping(Result<UserCaloriData?,ApiError>) -> Void){

        ApiManager.shared.fetch(endpoints: .dietUserDetails, endUerName:name, methodType: .get, contentType: .applicationJson, param:  "", completion: result)

    }
    
    func postLiftStyleData(user: String,dob: String,weight: String, currentWeight: String, height: String,goal: String,target_Weight: String,target_Dt: String,lifeStyle: String, result: @escaping(Result<dietPostModel?,ApiError>) -> Void) {
        let userInfo = ["UserID" :  user , "DOB" : dob,"Weight":weight, "CurrentWeight":  currentWeight, "Height": height, "Goal": goal,"Target_Weight": target_Weight,"Target_Date":target_Dt,"Lifestyle":lifeStyle]
        ApiManager.shared.fetch(endpoints: .postLifeStyle, endUerName:"", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func postWorkout(user: String,ExceciseType_Id:String, excercise_ID:String,quantity: String, result:@escaping(Result<dietPostModel?,ApiError>) -> Void){

        let userInfo = ["UserID" :  user , "ExcerciseID" : excercise_ID,"ExerciseType_ID":ExceciseType_Id, "Quantity":  quantity]
        ApiManager.shared.fetch(endpoints: .postExcercise, endUerName: "", methodType: .post, contentType: .applicationJson, param:  userInfo, completion: result)
    }
    
    func getInsightsData(result: @escaping(Result<InsightsModel?,ApiError>) -> Void){
        ApiManager.shared.fetch(endpoints: .insights, endUerName: "", methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
    func getDietCommunitites(user: String, result: @escaping(Result<CommunitiesModel?,ApiError>) -> Void){
        ApiManager.shared.fetch(endpoints: .userRelatedCommunities, endUerName: user, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
    func postDietCommunities(info :[String:String] , result: @escaping(Result<SignInModel?,ApiError>) -> Void){
        ApiManager.shared.fetch(endpoints: .postLeaveComunity, endUerName: "", methodType: .post, contentType: .applicationJson, param: info, completion: result)
    }
}
