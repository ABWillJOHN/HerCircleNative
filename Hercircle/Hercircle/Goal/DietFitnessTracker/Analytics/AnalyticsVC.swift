//
//  AnalyticsVC.swift
//  Hercircle
//
//  Created by Apple on 13/08/21.
//

import UIKit
protocol AnalyticsVCDelegate {
    func viewNavigate(index: Int)
}

class AnalyticsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib.init(nibName: "AnalyticsTBVCell", bundle: nil), forCellReuseIdentifier: "AnalyticsTBVCell")
        }
    }
    var delegate: AnalyticsVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK:- Tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AnalyticsTBVCell", for: indexPath) as! AnalyticsTBVCell
        switch indexPath.row {
        case 0:
            cell.imgview.image = UIImage(imageLiteralResourceName: "weightAnalytics")
            cell.lblTitle.text = "Weight graph"
            break
        case 1:
            cell.imgview.image = UIImage(imageLiteralResourceName: "excerciseAnalytic")
            cell.lblTitle.text = "Excercise graph"
            break
        case 2:
            cell.imgview.image = UIImage(imageLiteralResourceName: "mealAnalytic")
            cell.lblTitle.text = "Diet intake"

            break
        default:
            cell.imgview.image = UIImage(imageLiteralResourceName: "waterTracker")
            cell.lblTitle.text = "Water intake"
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.viewNavigate(index: indexPath.row)
//        let graphVC = GraphVC()
//        self.navigationController?.pushViewController(graphVC, animated: true)
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
