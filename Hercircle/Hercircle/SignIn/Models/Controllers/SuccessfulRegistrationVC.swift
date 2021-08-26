//
//  SuccessfulRegistrationViewController.swift
//  Hercircle
//
//  Created by vishal modem on 6/28/21.
//

import UIKit

class SuccessfulRegistrationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func handleCompleteProfile(_ sender: UIButton) {
        
    }
    
    @IBAction func handleDoItLater(_ sender: UIButton) {
        SideMenuHandler.shared.presentSideMenu(with: self)
    }
    
    //MARK:- set root to ApppDelegate Methods
    
}
