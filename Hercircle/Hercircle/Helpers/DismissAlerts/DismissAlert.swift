//
import Foundation
import UIKit
import SwiftMessages

enum SwiftAlertType: Int {

    case error
    case info
    case success
    case otp
}

enum DismissAlert : String{

    case success = "Success"
    case oops = "Oops"
    case login = "Login Successfull"
    case locationPermission = "Location Permissions"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
    case info = "Warning"
    case confirmation = "Confirmation"

    //Dismiss alert
    func dismiss(message: String?, cancelTitle: String) {

        let alert = UIAlertController(title: self.rawValue, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
        }
        alert.addAction(cancel)
    }

    func select(message: String?, cancelTitle: String?, options: String?..., didSelect:@escaping(_ index: Int?) -> Void) {

        let alert = UIAlertController(title: self.rawValue, message: message, preferredStyle: .alert)
        for (i,option) in options.enumerated() {
            let action = UIAlertAction(title: option, style: .default, handler: { (action) in
                didSelect(i)
            })
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            didSelect(nil)
        }
        alert.addAction(cancel)
    }

    func show(message : String){

        let warning = MessageView.viewFromNib(layout: MessageView.Layout.statusLine)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        warning.configureContent(title:"", body: message, iconText: "")
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: UIWindow.Level.statusBar.rawValue))
        SwiftMessages.show(config: warningConfig, view: warning)
    }

    //Warning messages
    func showWithType(type : Theme, message : String) {

       

        //Error
        let error = MessageView.viewFromNib(layout: .messageView)
        error.configureTheme(.error)
        error.configureDropShadow()
        error.configureTheme(backgroundColor: UIColor.black , foregroundColor: UIColor.white)
        error.configureContent(title:"", body: message)
        error.button?.setTitle("", for: .normal)
        error.button?.isHidden = true

        //Warning
        let warning = MessageView.viewFromNib(layout: MessageView.Layout.messageView)
        warning.configureContent(title: "", body: message, iconText: "")
        warning.configureTheme(backgroundColor: UIColor.black , foregroundColor: UIColor.white)
        warning.configureDropShadow()
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationStyle = .bottom
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: UIWindow.Level.alert.rawValue))

        //Success
        let success = MessageView.viewFromNib(layout: .messageView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureContent(title:"", body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .bottom
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: UIWindow.Level.normal.rawValue))

        switch type {
        case .error:
            SwiftMessages.show(view: error)
        case .info:
            SwiftMessages.show(config: warningConfig, view: warning)
        case .success:
            SwiftMessages.show(config: successConfig, view: success)
        default:
            break
        }
    }
}


fileprivate let KIndicatorViewTag = 101010
class ViewUtils: NSObject {

     static func noDataAvailable(view: UIView, strMsg : String? = "No Data Available") {
         let noDataLbl = UILabel(frame: CGRect(x: view.frame.size.width/2 - 100, y: view.frame.size.height/2 - 20, width: 200, height: 40))
         noDataLbl.text = strMsg
         noDataLbl.textAlignment = .center
         noDataLbl.font = UIFont(name: "Roboto-Medium", size: 18)
         view.addSubview(noDataLbl)
     }
     class func makeShakdowOnView(shadowView:UIView) {
         //        let shadowPath = UIBezierPath(rect: shadowView.bounds)
         shadowView.layer.masksToBounds = false
         shadowView.layer.shadowColor = UIColor.black.cgColor
         shadowView.layer.shadowOffset = CGSize(width: 0, height: 0.2)
         shadowView.layer.shadowOpacity = 0.2
         //        shadowView.layer.shadowPath = shadowPath.cgPath
     }

    class func alertMessase(withTitle : String? = "Message", message : String?, cancelAction : (()->())? = nil , okAction : @escaping (()->()), controller : UIViewController) {

         let alertMessageController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
         let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
             cancelAction?()
         }
         let okButton = UIAlertAction(title: "Ok", style: .default) { (ok) in
             okAction()
         }
         if cancelAction != nil {
             alertMessageController.addAction(cancelButton)
         }
         alertMessageController.addAction(okButton)
         controller.present(alertMessageController, animated: true, completion: nil)
     }
}

extension UIView {
    func shadow(color: UIColor, opacity : Float, sizeX : CGFloat, sizeY : CGFloat,shadowRadius : CGFloat){
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: sizeX, height: sizeY)
        layer.shadowRadius = shadowRadius

    }

    func border(color : UIColor, width : CGFloat,radius : CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = radius
    }
}

//MARK: Add/Remove load indicator method
func addLoadIndicator(){
    removeLoadIndicator()
    let loadView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,  height: UIScreen.main.bounds.size.height))
    loadView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.1)
    loadView.tag = KIndicatorViewTag
    let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)
    activityIndicator.tag = KIndicatorViewTag+1
    activityIndicator.color = UIColor.black
    activityIndicator.center = loadView.center
    loadView.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.delegate?.window??.addSubview(loadView)
}

func removeLoadIndicator(){
    let appWindow = UIApplication.shared.delegate?.window
    appWindow??.viewWithTag(KIndicatorViewTag)?.viewWithTag(KIndicatorViewTag+1)?.removeFromSuperview()
    appWindow??.viewWithTag(KIndicatorViewTag)?.removeFromSuperview()
}

func alertMessase(strOk: String? = "Ok",withTitle : String? = "Message", message : String?, cancelAction : (()->())? = nil , okAction : @escaping (()->())) {

    let alertMessageController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
    let cancelButton = UIAlertAction(title:"Cancel", style: .cancel) { (cancel) in
        cancelAction?()
    }
    let okButton = UIAlertAction(title: strOk, style: .default) { (ok) in
        okAction()
    }
    if cancelAction != nil {
        alertMessageController.addAction(cancelButton)
    }
    alertMessageController.addAction(okButton)
    let appWindow = UIApplication.shared.delegate?.window??.rootViewController
    appWindow?.present(alertMessageController, animated: true, completion: nil)
}


