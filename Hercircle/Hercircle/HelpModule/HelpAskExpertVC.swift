//
//  HelpAskExpertVC.swift
//  Hercircle
//
//  Created by Apple on 16/07/21.
//

import UIKit

class HelpAskExpertVC: UIViewController {
    @IBOutlet weak var lblNm: UILabel!
    @IBOutlet weak var txtView: UITextView!
    var expert: Experts!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDisc: UILabel!
    @IBOutlet weak var imgView: UIImageView!

   
    @IBOutlet weak var tblView: UITableView!
    var userInfo: SignIn?

    override func viewDidLoad() {
        super.viewDidLoad()
        userInfo = SigninUserHandler.shared.getUserDeytails()
        self.lblNm.text = "\(self.expert.salutation). " + "\(self.expert.firstName) " + "\( self.expert.lastName)"
        self.lblTitle.text = "\(self.expert.salutation). " + "\(self.expert.firstName) " + "\( self.expert.lastName)"
        self.lblDisc.text = self.expert.profession
        self.imgView.downloadImageFrom(link: self.expert.imageURL, contentMode: UIView.ContentMode.scaleAspectFit)

        // Do any additional setup after loading the view.
    }

    @IBAction func previousQueries() {
        if let vc = Questions_HelpVC(nibName: "Questions_HelpVC", bundle: nil) as? Questions_HelpVC
       {
            vc.expert = self.expert
            self.navigationController?.pushViewController(vc, animated: true)
       }
    }
    @IBAction func backAction () {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func askToExpert () {
        
        // Create Date
        let date = Date()

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YYYY-MM-dd" //"YY/MM/dd"

        // Convert Date to String
        let dat = dateFormatter.string(from: date)
        
        if let UID = userInfo?.data[0].userId  {
            if (UID.count > 0 && self.txtView.text.count > 0){

                HelpVM().postQuestionToExpert(queryDesc: self.txtView.text.trim(), assigned: "\(self.expert!.expertID)", isActive: 1, createdBy: UID, createdOn: dat, helplineCatId: 0) { result in
                    switch result {
                    case .success(let Expert):
                        DispatchQueue.main.async {
                            if Expert?.statusCode == 200 {
                                self.txtView.text = ""
                                self.showAlert(title:"Data inseted sucessfully", actionText1: "OK") { _ in }
                            } else {
                                //self?.showAlert(message: deviceInfo?.message ?? "")
                            }
                        }
                    case .failure(let error):
                        print("the error \(error)")
                        
                        DispatchQueue.main.async {
                            self.showAlert(title:"Something is wrong", actionText1: "OK") { _ in }
                        }
                    }
                }
                
            }

        }
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
