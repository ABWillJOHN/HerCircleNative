//
//  GrowWebVC.swift
//  Hercircle
//
//  Created by AmanDev Singh on 21/07/21.
//

//
//  GrowVC.swift
//  Hercircle
//
//  Created by vivekp on 16/07/21.
//


import UIKit
import WebKit

class GrowWebVC: UIViewController, WKNavigationDelegate {
    
    //MARK:-IBOutlet
    @IBOutlet weak var vwWeb: WKWebView!
    
    var strUrl = ""
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string:"https://www.google.com")
        if let url = url{
            vwWeb.load(URLRequest(url: url))
            vwWeb.allowsBackForwardNavigationGestures = true
        }else{
            alertMessase(message: "Url is not found", okAction: {
                self.navigationController?.popViewController(animated: false)
            })
        }
    }
}
