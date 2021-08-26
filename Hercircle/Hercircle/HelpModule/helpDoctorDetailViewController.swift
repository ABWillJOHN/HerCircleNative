//
//  helpDoctorDetailViewController.swift
//  Hercircle
//
//  Created by Apple on 16/07/21.
//

import UIKit

class helpDoctorDetailViewController: UIViewController {
    var expert: Experts!
    @IBOutlet weak var lblNm: UILabel!
   
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "IntroTblCellTableViewCell", bundle: nil), forCellReuseIdentifier: "IntroCell")
        tblView.register(UINib(nibName: "HelpDrDiscriptionCell", bundle: nil), forCellReuseIdentifier: "DiscriptionCell")
        tblView.register(UINib(nibName: "FooterCell", bundle: nil), forCellReuseIdentifier: "FooterCell")
        self.lblNm.text = "\(self.expert.salutation). " + "\(self.expert.firstName) " + "\( self.expert.lastName)"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
   
    
    @IBAction func backAction () {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func askTheExpert () {
        if let vc = HelpAskExpertVC(nibName: "HelpAskExpertVC", bundle: nil) as? HelpAskExpertVC
       {
            vc.expert = self.expert
            self.navigationController?.pushViewController(vc, animated: true)
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

extension helpDoctorDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var Cell = UITableViewCell()
        if indexPath.row == 0 {
        if let introCell = tableView.dequeueReusableCell(withIdentifier: "IntroCell", for: indexPath) as?  IntroTblCellTableViewCell{
            introCell.lblNm.text = "\(self.expert.salutation). " + "\(self.expert.firstName) " + "\( self.expert.lastName)"
            introCell.lblProfession.text = self.expert.profession
            introCell.lblExperience.text = "EXPERIENCE " + self.expert.professionalExperience
            introCell.lblSpecialities.text = "SPECIALISES IN :- " + self.expert.specializationSummary
            introCell.imageView?.downloadImageFrom(link: self.expert.imageURL, contentMode: UIView.ContentMode.scaleAspectFit)
            Cell = introCell
        }
        } else {
            if let introCell = tableView.dequeueReusableCell(withIdentifier: "DiscriptionCell", for: indexPath) as?  HelpDrDiscriptionCell{
                if indexPath.row == 1 {
                    introCell.lblTitle.text = "About"
                } else {
                    introCell.lblTitle.text = "How it works"
                }
                Cell = introCell
            }
        }
        return Cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var view = UIView()
        if let Cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as? FooterCell{
            view = Cell.contentView
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    
}
