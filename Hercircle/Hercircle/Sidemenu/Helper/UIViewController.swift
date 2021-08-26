//
//  UIViewController.swift
//
//  Created by Rahul Patel on 20/04/18.
//

import UIKit

extension UIViewController {

  //Set Navigation Bar Item Image for TabBar
  func setNavigationBarItem() {
    guard let menuImage = UIImage(named: "ic_menu")?.withRenderingMode(.alwaysOriginal),
          let notificationImage = UIImage(named: "ic_notifications")?.withRenderingMode(.alwaysOriginal) else {
      print("Not found menu or notification image")
      return
    }
    addLeftBarButtonWithImage(menuImage)
    addRightBarButtonWithImage(notificationImage)
  }

  //Load the UIView using Nibname
  func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
    return UINib(
      nibName: nibNamed,
      bundle: bundle
    ).instantiate(withOwner: nil, options: nil)[0] as? UIView
  }

  //Check current viewcontroller is presented, Pushed or not
  func isModal() -> Bool {
    if let navigationController = self.navigationController {
      if navigationController.viewControllers.first != self {
        return false
      }
    }
    if self.presentingViewController != nil {
      return true
    }
    if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
      return true
    }
    if self.tabBarController?.presentingViewController is UITabBarController {
      return true
    }
    return false
  }

  //Get topViewController from UIApllication Window or Current Navigation Controller
  public func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
      if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    if let presented = base?.presentedViewController {
      return topViewController(presented)
    }
    return base
  }
}
