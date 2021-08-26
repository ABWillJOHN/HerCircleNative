//
//  EngageViewModel.swift
//  Hercircle
//
//  Created by Rahul Patel on 21/07/21.
//

import UIKit
import Foundation

class EngageViewModel: NSObject {
    override init() {
        super.init()
    }
    func getStory(name:String, result: @escaping(Result<EngageModel?,ApiError>) -> Void){
        ApiManager.shared.fetch(endpoints: .engage, endUerName:name, methodType: .get, contentType: .applicationJson, param:  "", completion: result)
    }
}
