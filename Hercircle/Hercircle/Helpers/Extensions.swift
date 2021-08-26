//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Brian Voong on 2/14/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    func setAttributes(with color: UIColor) {
        let result = text?.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        let attributedString = NSMutableAttributedString(string: String(result?[0] ?? ""), attributes: [.foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1), .font: UIFont(name: "MuseoSans-700", size: 16)!])
        let attributedString1 = NSAttributedString(string: String(" " + (result?[1] ?? "")), attributes: [.foregroundColor: color, .font: UIFont(name: "MuseoSans-100", size: 16)!])
        attributedString.append(attributedString1)
        attributedText = attributedString
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension Int {
    func toString () -> String {
        return String (self)
    }
}


extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

extension String {
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        let regularExpressionForPhone = "^\\d{10}$"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
    
    var containsSpecialCharacters: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    func containsAlphabets() -> Bool {
        let letters = CharacterSet.letters
        
        let range = self.rangeOfCharacter(from: letters)
        
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    var isNumeric: Bool {
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }
    

   
}


let KScreenSize = UIScreen.main.bounds.size
class ExtensionUtils: NSObject {}

//MARK: Extension UIColor
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(
            red: r/255,
            green: g/255,
            blue: b/255, alpha: 1
        )
    }
}

//MARK: Extension String
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    
    //MARK: Localization
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
   
    
    func makeAColl() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    
    func firstCharacterUpperCase() -> String? {
        guard !isEmpty else { return nil }
        let lowerCasedString = self.lowercased()
        return lowerCasedString.replacingCharacters(in: lowerCasedString.startIndex...lowerCasedString.startIndex, with: String(lowerCasedString[lowerCasedString.startIndex]).uppercased())
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension StringProtocol{
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}


//MARK: Extension ScrollView
public extension UIScrollView {
    func addRefreshControl(_ block:@escaping ()->()) {
        self.addSubview(SSRefreshControl().addRefreshControl(block))
    }
}




//MARK: Extension Encodable
extension Encodable {
    var postDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let postDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
        print("Post Dictionary : \(String(describing: postDict))")
        return postDict
    }
    
    var postArray: [[String: Any]]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let postArr = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [[String: Any]] }
        return postArr
    }
}

//MARK: Extension UIImage
extension UIImage {
    
    public func base64(format: ImageFormat) -> String {
        var imageData: NSData
        switch format {
        case .png: imageData = self.pngData() as! NSData
        case .jpeg(let compression): imageData = self.jpegData(compressionQuality: compression)! as NSData
        }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

//MARK: Custom class for Refresh Scroll
class SSRefreshControl: UIRefreshControl {
    var action : (()->())?
    func addRefreshControl(_ block:@escaping ()->()) -> UIRefreshControl {
        action = block
        self.tintColor = UIColor.darkGray
        self.addTarget(self, action: #selector(SSRefreshControl.loadRefreshing), for: .valueChanged)
        return self
    }
    
    @objc func loadRefreshing() {
        action!()
        self.endRefreshing()
    }
}

//MARK: Text field
extension UITextField {
    func addBottomBorder(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIButton {
    func addBottomBorder(color : UIColor? = UIColor.black){
        let border = CALayer()
        let width = CGFloat(1.5)
        border.borderColor = color?.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

class UITextViewPadding : UITextView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textContainerInset = UIEdgeInsets(top: 15, left: 20, bottom: 8, right: 20)
    }
}

//MARK: Extensions Dictionary.
extension Dictionary {
    
    var toJsonString: String {
        let invalidJson = "Invalid Json"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    var toPostData: Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return jsonData
        } catch {
            return nil
        }
    }
}

//MARK: Extension NSDictionary
public extension NSDictionary {
    
    var toJsonString: String {
        let invalidJson = "Invalid Json"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    var toPostData: Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return jsonData
        } catch {
            return nil
        }
    }
    
    func toGoogleData() -> Data{
        do{
            let dataJson = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return dataJson
        }catch let error{
            print(error)
        }
        return Data()
    }
    
    func strMessage() -> String{
        return self.value(forKey: "message") as! String
    }
}

extension NSArray {
    
    var toJsonString: String {
        let invalidJson = "Invalid Json"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}

extension Array {
    
    var toJsonString: String {
        let invalidJson = "Invalid Json"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    mutating func remove(at indexes: [Int]) {
        for index in indexes.sorted(by: >) {
            remove(at: index)
        }
    }
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

extension String{
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToMutableAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSMutableAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func HTMLImageCorrector() -> String {
        var HTMLToBeReturned = self
        while HTMLToBeReturned.range(of: "(?<=width=\")[^\" height]+", options: .regularExpression) != nil{
            if let match = HTMLToBeReturned.range(of: "(?<=width=\")[^\" height]+", options: .regularExpression) {
                HTMLToBeReturned.removeSubrange(match)
                if let match2 = HTMLToBeReturned.range(of: "(?<=height=\")[^\"]+", options: .regularExpression) {
                    HTMLToBeReturned.removeSubrange(match2)
                    let string2del = "width=\"\" height=\"\""
                    HTMLToBeReturned = HTMLToBeReturned.replacingOccurrences(of: string2del, with: "style=\"width: 100%\"")
                }
            }
            
        }
        return HTMLToBeReturned
    }
}

extension UIView{
    enum GradientDirection {
        case horizontal
        case vertical
    }
    
    func fillColors(_ colors: [UIColor], withPercentage percentages: [Double], direction: GradientDirection = .horizontal) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = bounds.size.height/2
        var colorsArray: [CGColor] = []
        var locationsArray: [NSNumber] = []
        var total = 0.0
        locationsArray.append(0.0)
        for (index, color) in colors.enumerated() {
            // append same color twice
            colorsArray.append(color.cgColor)
            colorsArray.append(color.cgColor)
            // Calculating locations w.r.t Percentage of each
            if index + 1 < percentages.count {
                total += percentages[index]
                let location = NSNumber(value: total / 100)
                locationsArray.append(location)
                locationsArray.append(location)
            }
        }
        locationsArray.append(1.0)
        if direction == .horizontal {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        gradientLayer.colors = colorsArray
        gradientLayer.locations = locationsArray
        backgroundColor = .clear
        layer.addSublayer(gradientLayer)
    }
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}


extension UIViewController {
    
    func showAlert(title: String, message: String? = nil, actionText1: String, actionText2: String? = nil, action1: @escaping (UIAlertAction) -> (), action2: ((UIAlertAction) -> ())? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction1  = UIAlertAction(title: actionText1, style: .default, handler: action1)
        controller.addAction(alertAction1)
        if let actionText2 = actionText2 {
            let alertAction2 = UIAlertAction(title: actionText2, style: .cancel, handler: action2)
            controller.addAction(alertAction2)
        }
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

import Foundation

extension UserDefaults {

    private struct Keys {

        static let emailKey = "emailKey"
        static let passwordKey = "passwordKey"

    }

    class var signinEmail: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.emailKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.emailKey)
        }
    }
    
    class var signinPassword: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.passwordKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.passwordKey)
        }
    }
    

}
