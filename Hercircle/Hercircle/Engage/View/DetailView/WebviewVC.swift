//
//  WebviewVC.swift
//  Hercircle
//
//  Created by Rahul Patel on 22/07/21.
//

import UIKit
import WebKit

class WebviewVC: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    var webUrlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: webUrlString ?? "https://www.apple.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


}
