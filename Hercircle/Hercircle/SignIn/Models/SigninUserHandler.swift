//
//  SigninUserHandler.swift
//  Hercircle
//
//  Created by vishal modem on 7/14/21.
//

import Foundation


class SigninUserHandler {
    
    private var userDetails: SignIn?
    
    static let shared = SigninUserHandler()
    private init() {}
    
    func storeUserDetails(details: SignIn?) {
        userDetails = details
    }
    
    func removeUser() {
        userDetails = nil
    }
    
    func getUserDeytails() -> SignIn? {
        return userDetails
    }
}
