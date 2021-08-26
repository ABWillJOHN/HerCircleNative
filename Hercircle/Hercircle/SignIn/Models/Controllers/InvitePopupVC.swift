//
//  InvitePopupViewController.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/25/21.
//

import UIKit
import FBSDKShareKit
import MessageUI
import TwitterKit


class InvitePopupVC: UIViewController, MFMailComposeViewControllerDelegate {

    private let urlString = "https://hercircle.in"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func launchFacebook(_ sender: UIButton) {
        let content = ShareLinkContent()
        guard let url = URL(string: urlString) else {
            return
        }
        content.contentURL = url
        let dialog = ShareDialog(fromViewController: self, content: content, delegate: nil)
        dialog.show()
    }
    
    @IBAction func launchWhatsapp(_ sender: UIButton) {
        let urlWhats = "https://wa.me/917386383992/?text=\(urlString)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                } else {
                    print("Cannot Open Whatsapp")
                }
            }
        }
    }
    
    @IBAction func launchTwitter(_ sender: UIButton) {
//        let composer = TWTRComposer()
//        composer.setURL(URL(string: urlString)!)
//        composer.show(from: self) { (result) in
//            if result == TWTRComposerResult.cancelled{
//                print("tweet is canceled by user")
//            }else {
//                print(result)
//                print("tweet successfully")
//            }
//        }
        
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            // App must have at least one logged-in user to compose a Tweet
            let composer = TWTRComposerViewController.emptyComposer()
            present(composer, animated: true, completion: nil)
        } else {
            // Log in, and then check again
            TWTRTwitter.sharedInstance().logIn { session, error in
                if session != nil { // Log in succeeded
                    let composer = TWTRComposerViewController.emptyComposer()
                    self.present(composer, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
    
    @IBAction func launchMail(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setSubject("Invitation")
            mail.setMessageBody(urlString, isHTML: true)
            mail.mailComposeDelegate = self
            present(mail, animated: true)
        }
        else {
            print("Email cannot be sent")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       if let _ = error {
          self.dismiss(animated: true, completion: nil)
       }
       switch result {
          case .cancelled:
          print("Cancelled")
          break
          case .sent:
          print("Mail sent successfully")
          break
          case .failed:
          print("Sending mail failed")
          break
          default:
          break
       }
       controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func copyLinkClicked(_ sender: UIButton) {
        UIPasteboard.general.string = urlString
        self.dismiss(animated: true, completion: nil)
    }
    
}
