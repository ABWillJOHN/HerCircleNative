//
//  CommunityVC.swift
//  Hercircle
//
//  Created by vivekp on 30/07/21.
//

import UIKit

class CommunityVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var  arrCommList = [PopularCommunties]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCommunitiesApi()
        tableView.delegate = self
        tableView.dataSource = self
      
    }
    
    override open func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        getCommunitiesApi()
    }

    
    
    
    func getCommunitiesApi() {
        
        DietFitnessVM().getDietCommunitites(user: DietFitnessData.shared.userId) { (result) in
            switch result {
            case .success(let user):
                self.arrCommList.removeAll()
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        user?.data.popularCommunities.forEach({ CommunitiesModel in
                           
                            if(CommunitiesModel.trackerId == 1){
                                self.arrCommList.append(CommunitiesModel)
                            }
                            
                        })
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

   

    @IBAction func btnViewAll(_ sender: Any) {
    }
}


extension CommunityVC : UITableViewDataSource ,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityCell") as? DietCommunityCell else { return UITableViewCell()}
        cell.arrCommList = self.arrCommList
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
