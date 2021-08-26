//
//  lifeStyleVC.swift
//  Hercircle
//
//  Created by Apple on 02/08/21.
//

import UIKit

class lifeStyleVC: UIViewController {
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tblView: UITableView!
    var titleArray:[String] = [String]()
    var descArray:[String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let header = FitnessHeader.instanceFromNib()
        registerCustomCell()
        self.viewTop.addSubview(header)
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.separatorStyle = .none
        self.tblView.showsVerticalScrollIndicator = false
        self.titleArray = ["Moderately Active","Active","Sedentry"]
        self.descArray = ["Your new to fitness training","You have been training regularly","You are fit and ready for intensive workout plan"]
        getUserDietDetail()

        // Do any additional setup after loading the view.
    }
    
    // MARK:- REGISTER TABLEVIEW
    func registerCustomCell(){
        self.tblView.register(UINib.init(nibName: "StepOneCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "StepOneCustomTableViewCell")
    }
    
    @IBAction func goToActivityView() {
        
        if let vc = StartActivityVC(nibName: "StartActivityVC", bundle: nil) as? StartActivityVC
        {
             self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getUserDietDetail(){
        
        DietFitnessVM().getDietDetail(name: "9B597449-E30A-42DA-94E4-C4096A6CC3F2") { (result) in
            switch result {
            case .success(let dietDetail):
                DispatchQueue.main.async {
                    if dietDetail?.statusCode == 200 {
                        DietFitnessData.shared.userDietFitness = dietDetail
                        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK:-  TABLEVIEW DELEGATE AND DATASOURCE
extension lifeStyleVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepOneCustomTableViewCell") as! StepOneCustomTableViewCell
        
        cell.titleLabel.text = self.titleArray[indexPath.row]
        cell.descriptionLabel.text = self.descArray[indexPath.row]
        cell.descriptionLabel.textColor = UIColor.lightGray
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        headerView.backgroundColor = UIColor.white
        let headerTitleLbl:UILabel = UILabel()
        headerView.addSubview(headerTitleLbl)
        headerTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        headerTitleLbl.text = "How is your Lifestyle?"
        headerTitleLbl.font = UIFont.systemFont(ofSize: 20)
        headerTitleLbl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        headerTitleLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        headerTitleLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        headerTitleLbl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0).isActive = true
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        footerView.backgroundColor = UIColor.white
        let nextBtn:UIButton = UIButton()
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.backgroundColor = UIColor.systemGreen
        nextBtn.layer.cornerRadius = 8.0
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(nextBtn)
        nextBtn.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -20).isActive = true
        nextBtn.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20).isActive = true
        nextBtn.addTarget(self, action: #selector(goToActivityView), for: .touchUpInside)
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 90
    }
    
}

