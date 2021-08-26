//
//  GoalsVC.swift
//  Hercircle
//
//  Created by Rahul Patel on 25/06/21.
//

import UIKit

class GoalsVC: SideBaseVC {

    
    @IBOutlet weak var tblView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

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
extension GoalsVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalDashboardCell", for: indexPath) as! GoalDashboardCell
        cell.lblTitle.text = "Proceed"
        switch indexPath.row {
        case 0:
            cell.lblTracker.text = "track your period"
            cell.lblFullNm.text = "period goals"
            break
        case 1:
            cell.lblTracker.text = "plan your pregnancy"
            cell.lblFullNm.text = "fertility & pregnancy goals"
            break
        case 2:
            cell.lblTracker.text = "ace your fitness game"
            cell.lblFullNm.text = "diet & fitness goals"
            break
        default:
            cell.lblTracker.text = "be money wise"
            cell.lblFullNm.text = "finance goals"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
           
            break
        case 2:
            if let vc = SlideViewController(nibName: "SlideViewController", bundle: nil) as? SlideViewController
                   {
                        self.navigationController?.pushViewController(vc, animated: true)
                   }
            break
        default:
            break
        }
    }

}
