//
//  AppDelegate.swift
//  Hercircle
//
//  Created by Rahul Patel on 24/06/21.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn
import TwitterKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let clientID = "390299276052-d6kd60ln2jhmamqhiis4lnqn28d99smm.apps.googleusercontent.com"
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        GIDSignIn.sharedInstance().clientID = clientID
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        TWTRTwitter.sharedInstance().start(withConsumerKey:"b7RlE1IN6YKffyDeQ1dd71cLg", consumerSecret:"b0n2VbREB4IEpCcJphollYOTQm7Q6xZdxoqJOyHSQSkGwRp5P3")
        
        setUpIQKeyboard()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue)
        }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        if GIDSignIn.sharedInstance().handle(url) {
            return GIDSignIn.sharedInstance().handle(url)
        } else if TWTRTwitter.sharedInstance().application(app, open: url, options: options) {
            return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        } else {
            return ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
        }
    }
    
    func setUpIQKeyboard() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

}

