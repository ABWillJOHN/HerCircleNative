//
//  SideMenuHandler.swift
//  Hercircle
//
//  Created by vishal modem on 7/5/21.
//

import UIKit

class SideMenuHandler {
    
    static let shared = SideMenuHandler()
       private init() {}
    
    func presentSideMenu(with viewController: UIViewController) {
        let sbMain = UIStoryboard(name: StoryboardID.main, bundle: nil)
        
        guard let tabBarHomeVC = sbMain.instantiateViewController(withIdentifier: ViewControllerID.tabBarHomeVC) as? TabBarHomeVC,
              let leftMenuViewController = sbMain.instantiateViewController(withIdentifier: ViewControllerID.leftMenuViewController) as? LeftMenuViewController,
              let rightMenuController = sbMain.instantiateViewController(withIdentifier: ViewControllerID.rightMenuViewController) as? RightMenuViewController else {
            return
        }
        
        let navigationViewController: UINavigationController = UINavigationController(rootViewController: tabBarHomeVC)
        
        //Create Side Menu View Controller with main, left and right view controller
        let sideMenuViewController = SlideMenuController(mainViewController: navigationViewController, leftMenuViewController: leftMenuViewController, rightMenuViewController: rightMenuController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = sideMenuViewController
        appDelegate.window?.makeKeyAndVisible()
    }
}
