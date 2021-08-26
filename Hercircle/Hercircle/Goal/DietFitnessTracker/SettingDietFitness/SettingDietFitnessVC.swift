//
//  SettingDietFitnessVC.swift
//  Hercircle
//
//  Created by Apple on 15/08/21.
//

import UIKit
protocol SettingDietFitnessVCDelegate {
    func settingViewNavigation()
}

class SettingDietFitnessVC: UIViewController {
    @IBOutlet weak var dietTblView: UITableView!
    var delegate: SettingDietFitnessVCDelegate!
    let quesArray = ["Diet & Fitness Notifications","how is your lifestyle?","what do you want to do?","Height","Weight"]
    let ansArray = ["Enable to switch to the Diet and fitness tracker","Moderatley Active","Gain Weight","180.4cm","75Kg"]
    var notificationSwitch:UISwitch = UISwitch()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.dietTblView.register(UINib.init(nibName: "DietCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "DietCustomTableViewCell")
        

        // Do any additional setup after loading the view.
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
extension SettingDietFitnessVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DietCustomTableViewCell") as! DietCustomTableViewCell
        cell.qusTitleLbl.text = self.quesArray[indexPath.row]
        cell.qusDescriptionLbl.text = self.ansArray[indexPath.row]
        cell.qusTitleLbl.font = UIFont.systemFont(ofSize: 14)
        cell.qusDescriptionLbl.font = UIFont.systemFont(ofSize: 12)
        cell.arrowButton.isHidden = indexPath.row == 0 ? true : false
        if indexPath.row == 0 {
            self.notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(self.notificationSwitch)
            self.notificationSwitch.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20).isActive = true
            self.notificationSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.notificationSwitch.widthAnchor.constraint(equalToConstant: 50).isActive = true
            self.notificationSwitch.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor, constant: 0).isActive = true
            self.notificationSwitch.onTintColor = UIColor.systemGreen
            self.notificationSwitch.addTarget(self, action: #selector(notificationswitchDidChange(_:)), for: .valueChanged)
        }
        cell.selectionStyle = .none
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK:- NOTIFICATION SWITCH ACTION
    @objc func notificationswitchDidChange(_ sender:UISwitch)
    {
        if sender.isOn == true {
            print("Switch is ON")
        }
        else{
            print("Switch is OFF")
        }
    }
}

