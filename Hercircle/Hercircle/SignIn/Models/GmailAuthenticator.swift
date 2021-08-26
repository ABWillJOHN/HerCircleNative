//
//  GoogleAuthenticator.swift
//  Hercircle
//
//  Created by vishal modem on 7/5/21.
//

import UIKit
import GoogleSignIn

class GmailAuthenticator {

    static let shared = GmailAuthenticator()
    private init() {}

    func signin<T: GIDSignInDelegate & UIViewController>(on viewController: T) {
        GIDSignIn.sharedInstance().delegate = viewController
        GIDSignIn.sharedInstance().signIn()
    }
}
