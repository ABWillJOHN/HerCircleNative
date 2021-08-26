////
////  FacebookAuthentication.swift
////  Hercircle
////
////  Created by vishal modem on 7/5/21.
////
//
import UIKit
import FBSDKLoginKit

class FacebookAuthenticator {

    static let shared = FacebookAuthenticator()
    private init() {}

    func signin(on viewController: UIViewController, completion: @escaping (Any?, Error?) -> ()) {
        if let token = AccessToken.current, !token.isExpired {
            getUserInfo(completion: completion)
            return
        }
        
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile", "email"], from: viewController) { result, error in

            if error != nil {
                completion(nil, error)
            } else if let loginResult = result, !loginResult.isCancelled {
                self.getUserInfo(completion: completion)
            }
        }
    }
    
    private func getUserInfo(completion: @escaping (Any?,Error?) -> ()){
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "/me", parameters: ["fields" : "email, name, gender, first_name, last_name"], tokenString: token, version: nil, httpMethod: .get)
            request.start { connection, result, error in
                completion(result, nil)
            }
        }
    }
}
