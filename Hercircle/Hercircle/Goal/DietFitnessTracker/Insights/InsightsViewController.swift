//
//  InsightsViewController.swift
//  Hercircle
//
//  Created by Apple on 18/08/21.
//

import UIKit

protocol InsightsViewControllerDelegate {
    func getContentURL(strURL: String)
}

class InsightsViewController: UIViewController {

    @IBOutlet weak var lblGoals: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var delegate: InsightsViewControllerDelegate!
    
    var arrInsights = [InsightsListing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "InsightTblCell", bundle: nil), forCellReuseIdentifier: "InsightTblCell")

        
        self.lblGoals.text = "diet and fitness goals"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getInsightsApi()
        tableView.reloadData()
    }
    
    func getInsightsApi() {
        
        DietFitnessVM().getInsightsData { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        self.arrInsights = user?.data?.engageVideo ?? [InsightsListing]()
                        self.tableView.reloadData()
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(title:/user?.systemMsg, actionText1: "OK") { _ in }
                        }
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                DispatchQueue.main.async {
                    self.showAlert(title:error.localizedDescription, actionText1: "OK") { _ in }
                }
            }

        }
        
    }
    
}

extension InsightsViewController : UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrInsights.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var Cell = UITableViewCell()
        if let introCell = self.tableView.dequeueReusableCell(withIdentifier: "InsightTblCell", for: indexPath) as? InsightTblCell {
            
                let model :InsightsListing = self.arrInsights[indexPath.row]
                introCell.lblCategory.text = /model.subCategoryName
                introCell.lblTitle.text = /model.titleHeader
                introCell.lblAuthorAndDate.text = /model.author + " " + /model.validUpTo
            introCell.img.sd_setImage(with: URL(string:/model.mediaFileName), placeholderImage: UIImage(), options: .delayPlaceholder, completed: nil)
            
            Cell = introCell
        }

        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model :InsightsListing = self.arrInsights[indexPath.row]
        var strUrl = "/" + "\(model.contentURL)"
        self.delegate.getContentURL(strURL: strUrl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


