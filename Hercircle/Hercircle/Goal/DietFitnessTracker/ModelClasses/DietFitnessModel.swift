//
//  DietFitnessModel.swift
//  Hercircle
//
//  Created by Gaurav on 04/08/21.
//

import Foundation
// MARK: - UserDietData
class UserDietData: Codable {
    let data: [Datum]
    let dietMaster: [dietMaster]
    let exerciseMaster: [exerciseMaster]
    let analytics: analytics
    let statusCode: Int
    let success: Bool
    let userMsg, systemMsg: String?
}

// MARK: - Analytics
class analytics: Codable {
    let calories: Calories?
    let caloryconsume: Caloryconsume?
    let weightDetails: WeightDetails?
    let mealDetails: MealDetails?
    let waterIntake: WaterIntake?
    let exerciseDetails: ExerciseDetails?
}

// MARK: - Calories
class Calories: Codable {
    let Age: Int
    let Goal, RecommendedCalories, RecommendedCaloriesExercise, WaterIntake: String?
}

// MARK: - caloryconsume
class Caloryconsume: Codable {
    let TotalcalConsume, CaloriesLeft, Caloriesburnt: String?
}

// MARK: - WeightDetails
class WeightDetails: Codable {
    let Week, ThreeMonths, SixMonths: String?
}

class MealDetails: Codable {
    let WeeklyMeal, ThreeMonthsCalory, SixMonthsMeal: String?

}
class WaterIntake: Codable {
    let WeeklyWaterQnt,ThreeMonthsWaterQnt,SixMonthsWaterQnt: String?
}
class ExerciseDetails: Codable {
    let WeeklyExercise,ThreeMonthsExercise,SixMonthsExercise: String?
}

// MARK: - Datum
class Datum: Codable {
    let userFitness_ID: Int
    let user_ID, user_DOB: String?
    let weight, current_Weight, height: Int
    let goal: String?
    let target_weight: Int
    let target_Date: String?
    let lifestyle, created_by, created_Date: String?
    let active: Bool
}

// MARK: - DietMaster
class dietMaster: Codable {
    let diet_ID: Int
    let name: String?
    let calories: Double
    let serving_Size: String?
    let active: Bool
}

// MARK: - ExerciseMaster
class exerciseMaster: Codable {
    let exercise_ID: Int
    let exercise_Name: String?
    let calories_Burnt: Int
    let exercise_Intensity: String?

}

//////////////////CaloriData///////////////////////////////////////

// MARK: - UserCaloriData
class UserCaloriData: Codable {
    let data: data
    //let mealDetails: [String: mealDetails]//[mealDetails] //[mealDetails: String] //[String: mealDetails]
   // let exerciseDetails: [String: exerciseDetails]//[exerciseDetails] //[exerciseDetails: String] //[String: exerciseDetails]
    let statusCode: Int
    let success: Bool
    let userMsg, systemMsg: String
}

// MARK: - DataClass
class data: Codable {
    let RecommendCalory, RecommendCaloryExercise, TotalcalConsume, CaloriesLeft: String
    let Caloriesburnt: String

}

// MARK: - ExerciseDetail
/*class exerciseDetails: Codable {
    let ExerciseName, ExerciseID, Qunatity, Caloryburn: String

}*/

// MARK: - MealDetail
/*class mealDetails: Codable {
    let DietName, DietID, Qunatity, Calory: String

}*/

class dietPostModel: Codable {
    let data: String?
    let statusCode: Int?
    let userMsg, systemMsg: String?
}


