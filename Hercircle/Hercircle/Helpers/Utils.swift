



import UIKit
import AudioToolbox

@objcMembers
class Utils: NSObject{
    
    @objc class func getClassName(className inClass:AnyObject) -> String {
        return String(describing: inClass.self).components(separatedBy: ".").last!
    }
    
    class func getStoryBoardWIthName(name:String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
    
    class func getController(storyboardName:String, storyboardID:String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardID)
    }
 
    class func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        DispatchQueue.main.async {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    
    @objc class func ishavingNotch() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return false
            case 1334:
                return false
            case 1920, 2208:
                return false
            case 2436:
                return true
            case 2688:
                return true
            case 1792:
                return true
            default:
                return false
            }
        }
        return false
    }
    
    class func getPresentedVC () -> UIViewController? {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }

    
    class func getRequiredNameToDisplay(withFirstName firstName: String?, lastName: String?, contactNumber contactNo: String?) -> String? {
        var finalName = ""
        let firstName = firstName?.trim()
        let lastName = lastName?.trim()
        if (/firstName?.count) < 1 && (/lastName?.count) < 1 {
            finalName = /contactNo
        } else if (/firstName?.count) > 0 && (/lastName?.count) < 1 {
            finalName = /firstName
        } else if (/firstName?.count) < 1 && (/lastName?.count) > 0 {
            finalName = /lastName
        } else {
            finalName = "\(/firstName) \(/lastName)"
        }
        return finalName
    }

    class func getIndexPath(cell : UITableViewCell) -> IndexPath? {
        guard let superView = cell.superview as? UITableView else { return nil }
        return superView.indexPath(for: cell)
    }
   
    
}

