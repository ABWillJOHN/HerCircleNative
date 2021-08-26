//
//  GrowVC.swift
//  Hercircle
//
//  Created by vivekp on 16/07/21.
//

import UIKit

class GrowVCJobs: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrJobs: [GrowJobsListing]? // masterclass
    var firstHeading , secondHeading : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.registerHeaderCell()
    }
    
    private func registerHeaderCell() {
        tableView.register(UINib(nibName: "GrowSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: GrowSectionHeaderView.reuseIdentifier)
    }
}


extension GrowVCJobs : UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: Utils.getClassName(className: GrowSectionHeaderView.self)) as? GrowSectionHeaderView else { return UIView() }
        cell.lblFirstHeading.text = /self.firstHeading
        cell.lblSecondHeading.text = /self.secondHeading
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utils.getClassName(className: GrowJobCell.self)) as? GrowJobCell else { return UITableViewCell()}
        cell.arrJobs = self.arrJobs
        cell.viewAll = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height
    }
}
