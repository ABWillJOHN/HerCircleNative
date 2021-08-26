//
//  AppleAuthenticator.swift
//  Hercircle
//
//  Created by vishal modem on 7/5/21.
//

import UIKit
import AuthenticationServices


class AppleAuthenticator {
    static let shared = AppleAuthenticator()
    private init() {}

    func signin<T: UIViewController & ASAuthorizationControllerDelegate & ASAuthorizationControllerPresentationContextProviding>(on viewController: T) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = viewController
        authorizationController.presentationContextProvider = viewController
        authorizationController.performRequests()
    }
}
