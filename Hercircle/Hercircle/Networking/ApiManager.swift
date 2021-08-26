//
//  ApiManager.swift
//  Stationmd
//
//  Created by ankit shelar on 01/04/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation
import UIKit

enum MethodType : String {
    case get = "GET"
    case post = "POST"
}

enum ContentType : String {
    case applicationJson = "application/json"
}

enum ApiError : Error {
    case errorMsg(message:String)
    
    var errorDescription:String {
        switch self {
        case let .errorMsg(message): return message
        }
    }
}

class ApiManager {

    static let shared = ApiManager()
    
    fileprivate init() {}
    
    let session = URLSession.shared
    
    var baseUrl:URL?
    
    func fetch<T:Codable,R:Codable>(endpoints:endPoint, endUerName:String, methodType:MethodType, contentType:ContentType, param: R? = nil,isHelpModule: Bool? = false, completion: @escaping(Result<T,ApiError>)->()){
        do {
            var url = URL(string: BaseUrl.baseUrl.baseUrlString + endpoints.rawValue)!

            url = URL(string: BaseUrl.baseUrl.baseUrlString + endpoints.rawValue)!
            if endpoints == .dietUserDetails || endpoints == .userRelatedCommunities {
                url = URL(string: BaseUrl.baseUrl.baseUrlString + endpoints.rawValue + endUerName)!
            }
//            if endpoints == .validateUsername, (endUerName != ""){
//                url = URL(string: BaseUrl.baseUrl.baseUrlString + endpoints.rawValue + endUerName)!
//            } else if endpoints == .home {
//                var baseUrlString = BaseUrl.homeUrl.baseUrlString
//                baseUrlString.removeLast(2)
//                url = URL(string: baseUrlString + endpoints.rawValue)!
//            }
//
//            if isHelpModule == true{
//                let strDomain = "http://10.160.137.82:8080/"
//                url = URL(string: strDomain + endpoints.rawValue)!
//            }
//
//            if endpoints == .grow {
//                url = URL(string: "http://10.160.137.82:8080/hccms_engagearticle/api/Engage/GetStory/Grow")!
//            }
//            else if endpoints == .growJobs {
//                url = URL(string: "http://10.160.137.82:8080/hc_grow/api/Job/GetJobDetails")!
//            }
//            else if endpoints == .growJobsApply {
//                url = URL(string: "http://10.160.137.82:8080/hc_grow/api/Job/JobUserApply")!
//            }
//            if endpoints == .growSetBookmark {
//                url = URL(string: "http://10.160.137.82:8080/hc_grow/api/job/UpdateBookmark")!
//            }
            
            //let url = URL(string: BaseUrl.baseUrl.baseUrlString + endpoints.rawValue)!
            print(url)
           // print("param \(param)")
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = methodType.rawValue
             
            urlRequest.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("F5357124-AE3C-4239-90DE-79151EFF560B" , forHTTPHeaderField: "AppKey")
            urlRequest.addValue(DEVICE_ID?.description ?? "" , forHTTPHeaderField: "ClientIP")
            let sessionId =  "iOS-\(DEVICE_ID?.description ?? "")"
            urlRequest.addValue(sessionId , forHTTPHeaderField: "SessionID")

            if methodType == .post, (param != nil){
                if contentType == .applicationJson {
                    //let jsonData = try? JSONSerialization.data(withJSONObject: param as Any)
                    urlRequest.httpBody = try JSONEncoder().encode(param)
                }
            }
            self.session.dataTask(with: urlRequest) { data, response, error in
                if error == nil {
                    
                    //data check
                    guard let data = data else {
                        completion(.failure(.errorMsg(message: ResponseError.noData.errorDescription)))
                        return
                    }
                    
                    do {
//                        let responseData = String(data: data, encoding: String.Encoding.utf8)
//                        print(responseData as Any)
                        
//                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                            if let responseJSON = responseJSON as? [String: Any] {
//                                print(responseJSON)
//                            }
                        print(String(data: data, encoding: .utf8))
                        let codableData = try JSONDecoder().decode(T.self, from: data)
                        print("CodableData = \(codableData)")
                        completion(.success(codableData))
                    }catch (let error) {
                       
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                                                   if let responseJSON = responseJSON as? [String: Any] {
                                                       print(responseJSON)
                                                    if(responseJSON["systemMsg"] as? String != "Username does not exist."){
                                                      //  if endpoints != .dietPostMeal   {
                                                    self.showAlert(title:responseJSON["systemMsg"] as? String ?? "", actionText1: "OK") { _ in }
                                                       // }
                                                    }
                                                   }
                        
                        print("Error = \(error.localizedDescription)")
                    }
                    
                }else {
                    completion(.failure(.errorMsg(message: error?.localizedDescription ?? "error")))
                }
            }.resume()
            
        }catch (let error) {
            completion(.failure(.errorMsg(message: error.localizedDescription)))
        }
    }
    
    func showAlert(title: String, message: String? = nil, actionText1: String, actionText2: String? = nil, action1: @escaping (UIAlertAction) -> (), action2: ((UIAlertAction) -> ())? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction1  = UIAlertAction(title: actionText1, style: .default, handler: action1)
        controller.addAction(alertAction1)
        if let action2 = action2 {
            let alertAction2 = UIAlertAction(title: actionText2, style: .cancel, handler: action2)
            controller.addAction(alertAction2)
        }
        DispatchQueue.main.async {
            if let topVC = UIApplication.getTopViewController() {
                topVC.present(controller, animated: true)
            }
           
        }
    }
    
}


extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
