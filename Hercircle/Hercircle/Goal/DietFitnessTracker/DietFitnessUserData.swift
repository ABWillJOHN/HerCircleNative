//
//  DietFitnessUserData.swift
//  Hercircle
//
//  Created by Apple on 04/08/21.
//

import Foundation
import UIKit
class DietFitnessData {
    
    var userDietFitness: UserDietData?
    var userCalories: UserCaloriData?
    var userId = ""
    var bDay = ""
    var weight = ""
    var currentWeight = ""
    var height = ""
    var goal = ""
    var targetWeight = ""
    var targetDt = ""
    var lifestyle = ""
    var monthWeekSelected = 0
    
    static let shared = DietFitnessData()
    private init() {}
}
extension UIView {
    func shadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func buttonShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
    
    func tabShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
    
    
    func addShadow(_ color:CGColor = UIColor.gray.cgColor) {
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addLightShadow(_ color:CGColor = UIColor.lightGray.cgColor) {
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = color
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.masksToBounds = false
        clipsToBounds = false
    }
}
