//
//  Questions_HelpVC.swift
//  Hercircle
//
//  Created by Apple on 18/07/21.
//

import UIKit

class Questions_HelpVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    var helpQuestions: HelpGetQuestion?
    var expert: Experts!
    var signIn: SignIn!
    @IBOutlet weak var lblTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "question_ExpertCell", bundle: nil), forCellReuseIdentifier: "question_ExpertCell")
        self.lblTitle.text = "\(self.expert.salutation). " + "\(self.expert.firstName) " + "\( self.expert.lastName)"
        signIn = SigninUserHandler.shared.getUserDeytails()
        getQuestionsToExperts()
        self.tblView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    func getQuestionsToExperts() {
        if let UID = signIn.data[0].userId {
            let userInfo = ["CreatedBy" : UID , "AssignedTo" : self.expert.expertID] as [String : Any]

            HelpVM().getQueriesToExpert(createdBy: UID, assignedTo: "\(self.expert.expertID)", param: userInfo) { (result) in
            switch result {
            case .success(let Questions):
                DispatchQueue.main.async {
                    if Questions?.statusCode == 200 {
                        self.helpQuestions = Questions
                        self.tblView.reloadData()
                    } else {
                        self.helpQuestions = Questions
                        self.tblView.reloadData()
                        //self?.showAlert(message: deviceInfo?.message ?? "")
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                
                
               // DispatchQueue.main.async {
                    self.showAlert(title:"Something is wrong", actionText1: "OK") { _ in }
               // }
            }
        }
        }
    }
    
    func deletQueries (index: Int) {
        if let UID = signIn.data[0].userId, let qriID =  self.helpQuestions?.data[index].queryId{
            HelpVM().deleteQueries(updateBy: UID, queryID: "\(qriID)") { (result) in
                switch result {
                case .success(let Questions):
                    DispatchQueue.main.async {
                        if Questions?.statusCode == 200 {
                            self.getQuestionsToExperts()
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

    
    @IBAction func backAction () {
        self.navigationController?.popViewController(animated: true)
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

extension Questions_HelpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let cnt = self.helpQuestions?.data.count {
            count = cnt
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let questionCell = tableView.dequeueReusableCell(withIdentifier: "question_ExpertCell", for: indexPath) as?  question_ExpertCell{
            questionCell.imgView.downloadImageFrom(link: self.expert.imageURL, contentMode: UIView.ContentMode.scaleAspectFit)
            questionCell.lblDisc.text = self.helpQuestions?.data[indexPath.row].queryDescription
            cell = questionCell
            
        }
        return cell
    }
    
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            deletQueries(index: indexPath.row)
            // remove the item from the data model

            // delete the table view row

        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    
    
}

