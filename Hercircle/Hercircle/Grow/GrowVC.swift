//
//  GrowVC.swift
//  Hercircle
//
//  Created by vivekp on 16/07/21.
//

import UIKit

enum GrowEnum : String {
    case upskil = "upskill"
    case grow = "grow"
    case creative = "creative"
    case masterclass = "masterclass"
    case jobs = "jobs"
    case talentHunt = "talent hunt"
    case corner = "corner"
    case courses = "courses"
}

class GrowVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var userStories : Stories? = nil
    var arrMasterClass = [InfiniteStory]() // masterclass
    var arrUpskillsCourses = [InfiniteStory]()
    var arrJobs: [GrowJobsListing]?
    var arrCreativeCornerHelper = [CreativeCornor]()
    var arrMasterClassHelper = [InfiniteStory]() // masterclass
    var arrUpskillsCoursesHelper = [InfiniteStory]()
    var arrJobsHelper = [GrowJobsListing]()
    var arrMasterClassPostCount : Int = 1
    var arrUpskillsCoursesPostCount : Int = 1
    var arrJobsPostCount : Int = 1
    var arrCreativeCornerPostCount : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getStroies()
        tableView.delegate = self
        tableView.dataSource = self
        self.registerHeaderCell()
    }

    func getStroies() {
        
        vcViewModelGrow().getGrowStories(viewCurrent: self.view) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        self.userStories = user?.data
                        self.getJobs()
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(title:/user?.systemMsg, actionText1: "OK") { _ in }
                        }
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                DispatchQueue.main.async {
                    self.showAlert(title:"Please enter correct OTP", actionText1: "OK") { _ in }
                }
                
            }
        }
    }
    
    func getJobs() {
        
        vcViewModelGrow().getGrowJobs(viewCurrent: self.view) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        self.arrJobs = user?.data
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
                    self.showAlert(title:"Please enter correct OTP", actionText1: "OK") { _ in }
                }
                
            }
        }
    }
    
    private func registerHeaderCell() {
        tableView.register(UINib(nibName: "GrowSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: GrowSectionHeaderView.reuseIdentifier)
    }
    
    //Footer Header Selectors
    @objc func btnViewAllAction(sender:UIButton)
    {
        switch sender.tag {
        case 0 :
            let vc = UIStoryboard.init(name: "Grow", bundle: Bundle.main).instantiateViewController(withIdentifier: "GrowVCAllStories") as? GrowVCAllStories
            vc?.arrMasterClass = self.arrMasterClass
            vc?.firstHeading = GrowEnum.upskil.rawValue
            vc?.secondHeading = GrowEnum.masterclass.rawValue
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        case 1 :
            let vc = UIStoryboard.init(name: "Grow", bundle: Bundle.main).instantiateViewController(withIdentifier: "GrowVCJobs") as? GrowVCJobs
            vc?.firstHeading = GrowEnum.grow.rawValue
            vc?.secondHeading = GrowEnum.jobs.rawValue
            vc?.arrJobs = self.arrJobs
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        case 3 :
            let vc = UIStoryboard.init(name: "Grow", bundle: Bundle.main).instantiateViewController(withIdentifier: "GrowVCAllStories") as? GrowVCAllStories
            vc?.firstHeading = GrowEnum.creative.rawValue
            vc?.secondHeading = GrowEnum.corner.rawValue
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    
        case 4 :
            let vc = UIStoryboard.init(name: "Grow", bundle: Bundle.main).instantiateViewController(withIdentifier: "GrowVCAllStories") as? GrowVCAllStories
            vc?.arrMasterClass = self.arrUpskillsCourses
            vc?.firstHeading = GrowEnum.upskil.rawValue
            vc?.secondHeading = GrowEnum.courses.rawValue
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        default :
           break
        }
     
    }
    
    @objc func btnLoadMoreAction(sender:UIButton)
    {
        switch sender.tag {
        case 0 :
            self.arrMasterClassHelper.removeAll()
            arrMasterClassPostCount = arrMasterClassPostCount + 1
            arrMasterClass.forEach { model in
                if(arrMasterClassHelper.count <= 4 * arrMasterClassPostCount){
                self.arrMasterClassHelper.append(model)
                }
            }
           
        case 1 :
            self.arrJobsHelper.removeAll()
            arrJobsPostCount = arrJobsPostCount + 1
            arrJobs?.forEach { model in
                if(/arrJobsHelper.count <= 4 * arrJobsPostCount){
                self.arrJobsHelper.append(model)
                }
            }
        case 2 :
            break
        case 3 :
            self.arrCreativeCornerHelper.removeAll()
            arrCreativeCornerPostCount = arrCreativeCornerPostCount + 1
            self.userStories?.creativeCornor.forEach { model in
                if(/self.arrCreativeCornerHelper.count <= 4 * arrCreativeCornerPostCount){
                self.arrCreativeCornerHelper.append(model)
                }
            }
            
        case 4 :
            
            self.arrUpskillsCoursesHelper.removeAll()
            arrUpskillsCoursesPostCount = arrUpskillsCoursesPostCount + 1
            self.arrUpskillsCourses.forEach { model in
                
                if(/self.arrUpskillsCoursesHelper.count <= 4 * arrUpskillsCoursesPostCount){
                self.arrUpskillsCoursesHelper.append(model)
                }
            }
        
        default :
           break
        }
        self.tableView.reloadData()
    }
}


extension GrowVC : UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: Utils.getClassName(className: GrowSectionHeaderView.self)) as? GrowSectionHeaderView else { return UIView() }
        switch section {
        case 0 :
            cell.lblFirstHeading.text = GrowEnum.upskil.rawValue
            cell.lblSecondHeading.text = GrowEnum.masterclass.rawValue
        case 1 :
            cell.lblFirstHeading.text = GrowEnum.grow.rawValue
            cell.lblSecondHeading.text = GrowEnum.jobs.rawValue
          
        case 2 :
            cell.lblFirstHeading.text = GrowEnum.jobs.rawValue
            cell.lblSecondHeading.text = GrowEnum.talentHunt.rawValue
            
        case 3 :
            cell.lblFirstHeading.text = GrowEnum.creative.rawValue
            cell.lblSecondHeading.text = GrowEnum.corner.rawValue
        
        case 4 :
            cell.lblFirstHeading.text = GrowEnum.upskil.rawValue
            cell.lblSecondHeading.text = GrowEnum.courses.rawValue
        
        default :
           break
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != 2 {
      let tempView = GrowSectionFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
            tempView.btnViewAll.tag = section
            tempView.btnLoadMore.tag = section
            tempView.btnViewAll.addTarget(self,action: #selector(btnViewAllAction),for:.touchUpInside)
            tempView.btnLoadMore.addTarget(self,action: #selector(btnLoadMoreAction),for:.touchUpInside)
            return tempView
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            if(self.arrMasterClassPostCount == 1){
            self.arrMasterClass.removeAll()
            self.userStories?.infiniteStory.forEach({ model in
                if model.mediaURL.count > 0 && model.mediaURL.contains("m3u8") {
                    self.arrMasterClass.append(model)
                }
            })}
            return (self.arrMasterClassPostCount == 1) ? (self.arrMasterClass.count > 4 ? 4 : /self.arrMasterClass.count) : /self.arrMasterClassHelper.count
        case 1 :
            return 1
        case 2 :
            return 1
        case 3 :
            return (self.arrCreativeCornerPostCount == 1) ? (/self.userStories?.creativeCornor.count > 4 ? 4 : /self.userStories?.creativeCornor.count) : /self.arrCreativeCornerHelper.count
        case 4 :
            if(self.arrUpskillsCoursesPostCount == 1){
            self.arrUpskillsCourses.removeAll()
            self.userStories?.infiniteStory.forEach({ model in
                if !model.mediaURL.contains("m3u8") {
                    self.arrUpskillsCourses.append(model)
                }
            })}
            return (self.arrUpskillsCoursesPostCount == 1) ? (/self.arrUpskillsCourses.count > 4 ? 4 : /self.arrUpskillsCourses.count) : /self.arrUpskillsCoursesHelper.count
        default :
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 1 {
          
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Utils.getClassName(className: GrowJobCell.self)) as? GrowJobCell else { return UITableViewCell()}
            cell.arrJobs = self.arrJobs
            return cell
            
        } else if indexPath.section == 2 {
           
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Utils.getClassName(className: GrowJobPostCell.self)) as? GrowJobPostCell else { return UITableViewCell()}
            return cell
            
        } else if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Utils.getClassName(className: GrowPostCell.self)) as? GrowPostCell else { return UITableViewCell()}
            cell.model = self.arrMasterClass[indexPath.row]
            return cell
            
        } else if indexPath.section == 3 {
           
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Utils.getClassName(className: GrowPostCell.self)) as? GrowPostCell else { return UITableViewCell()}
            cell.creativeCornerModel = self.userStories?.creativeCornor[indexPath.row]
            return cell
            
        }
        else if indexPath.section == 4 {
           
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Utils.getClassName(className: GrowPostCell.self)) as? GrowPostCell else { return UITableViewCell()}
            cell.model = self.arrUpskillsCourses[indexPath.row]
            return cell
            
        }
        else {
           
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Utils.getClassName(className: GrowPostCell.self)) as? GrowPostCell else { return UITableViewCell()}
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0 , 4:
            let vc = UIStoryboard.init(name: "Grow", bundle: Bundle.main).instantiateViewController(withIdentifier: "GrowWebVC") as? GrowWebVC
            if(indexPath.section == 0){
                vc?.strUrl = self.arrMasterClass[indexPath.row].contentURL
            }
            else if(indexPath.section == 4) {
                vc?.strUrl = self.arrUpskillsCourses[indexPath.row].contentURL
            }
            else if(indexPath.section == 3){
                vc?.strUrl = /self.userStories?.creativeCornor[indexPath.row].contentURL
            }
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        default :
           break
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 1){
            return self.arrJobsPostCount == 1 ? CGFloat(self.arrJobsPostCount * 340) : CGFloat(self.arrJobsPostCount * 300)
        }
        return UITableView.automaticDimension
    }
}
