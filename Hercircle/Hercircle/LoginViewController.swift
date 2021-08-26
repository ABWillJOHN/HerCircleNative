//
//  LoginViewController.swift
//  side+tab
//
//  Created by Rahul Patel on 24/06/21.
//

import UIKit

class LoginViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func btnLogin(_ sender: UIButton) {
    makeRootViewController()
  }
    
  //MARK:- set root to ApppDelegate Methods
  func makeRootViewController() {
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
