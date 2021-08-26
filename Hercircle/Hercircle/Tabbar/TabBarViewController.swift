//
//  TabBarHomeVC.swift
//  side+tab
//
//  Created by Rahul Patel on 24/06/21.
//

import UIKit

class TabBarHomeVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
      navigationController?.isNavigationBarHidden = true
      super.viewWillAppear(animated)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
