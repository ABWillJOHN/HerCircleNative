//
//  GrowJobCell.swift
//  Hercircle
//
//  Created by vivekp on 18/07/21.
//

import UIKit

class GrowJobCell: UITableViewCell ,UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout,UIScrollViewDelegate, UITextFieldDelegate  {
    
    var viewAll :Bool? = false
    var arrJobs: [GrowJobsListing]? {
        didSet {
            
            self.arrSearchJobs = self.arrJobs ?? [GrowJobsListing]()
            self.getBookMarks()
            self.collectionView.reloadData()
        }
    }
    var arrSearchJobs = [GrowJobsListing]()
    var arrBookMarks : [BookMarksList]?
    
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let kCollectionNumberOfItemsInOneRow = 2
    private let kCollectionPaddingSectionLeft: CGFloat = 12.0
    private let kCollectionPaddingSectionRight: CGFloat = 12.0
    private let kCollectionItemSpacing: CGFloat = 8.0

    override func awakeFromNib() {
        super.awakeFromNib()
        txtFldSearch.delegate = self
        txtFldSearch.addTarget(self, action: #selector(searchJob(textField:)), for: .editingChanged)
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = kCollectionItemSpacing
        flow.sectionInset = UIEdgeInsets(top: 24.0, left: kCollectionPaddingSectionLeft,
                                         bottom: 24.0, right: kCollectionPaddingSectionRight)
    }
    
    @objc final private func searchJob(textField: UITextField) {
        if(textField.text?.trim() == ""){
            self.arrSearchJobs = self.arrJobs ?? [GrowJobsListing]()
        }
        else {
        arrSearchJobs = (self.arrJobs?.filter({ model in
            return /model.titleHeader?.contains(/textField.text)
        }))!
        }
        self.collectionView.reloadData()
    }
    
    func getBookMarks() {
        
        vcViewModelGrow().getBookmarks(viewCurrent: self.collectionView) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        self.arrBookMarks = user?.data
                        self.arrSearchJobs.forEach({ jobModel in
                            self.arrBookMarks?.forEach({ bookMarkModel in
                                if(jobModel.jobid == bookMarkModel.jobID){
                                    //jobModel.isBook = bookMarkModel.isBook
                                }
                            })
                        })
                    } else {
                        DispatchQueue.main.async {
                            DismissAlert.error.showWithType(type: .error, message: /user?.systemMsg)
                        }
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                DispatchQueue.main.async {
                    DismissAlert.error.showWithType(type: .error, message: "the error \(error)")
                }
                
            }
        }
    }
    
    func setBookMark(jobId: String? , userId : String? , isBook : String? ) {
        
        vcViewModelGrow().getGrowSetBookmark(jobId:jobId , userId :userId , isBook :isBook ,viewCurrent: self.collectionView) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        self.getBookMarks()
                        self.collectionView.reloadData()
                    } else {
                        DispatchQueue.main.async {
                            DismissAlert.error.showWithType(type: .error, message: /user?.systemMsg)
                        }
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                DispatchQueue.main.async {
                    DismissAlert.error.showWithType(type: .error, message: "the error \(error)")
                }
            }
        }
    }
    
    func applyJob(jobId: String? , userId : String? ,  ipaddress : String? , operationgSystem : String) {
        
        vcViewModelGrow().getGrowJobsApply(jobId: jobId, userId: userId, ipaddress: ipaddress, operationgSystem: operationgSystem ,viewCurrent: self.collectionView) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if user?.statusCode == 200 {
                        self.collectionView.reloadData()
                    } else {
                        DispatchQueue.main.async {
                            DismissAlert.error.showWithType(type: .error, message: /user?.systemMsg)
                        }
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                DispatchQueue.main.async {
                    DismissAlert.error.showWithType(type: .error, message: "the error \(error)")
                }
            }
        }
    }
    
    
    @IBAction func btnBookmark(_ sender: UIButton) {
    
        var model :GrowJobsListing = (self.arrSearchJobs[sender.tag])
        model.isBook = !(model.isBook ?? false)
        self.arrSearchJobs[sender.tag] = model
        sender.setImage(model.isBook == true ? UIImage.init(named: "Group") : UIImage.init(named: "bookmark"), for: .normal)
        self.setBookMark(jobId : /model.jobid?.toString() , userId: "47B2611F-B57F-49EE-8970-1514D359AE82" , isBook: model.isBook == true ? "true" : "false")
    }
    
    @IBAction func btnShare(_ sender: UIButton) {
    
    }
    
    @IBAction func btnApply(_ sender: UIButton) {
        
    
        var model :GrowJobsListing = (self.arrSearchJobs[sender.tag])
        
        if(viewAll == true){
            
            
            let alertController = UIAlertController(title: /model.titleHeader, message: /model.description, preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                sender.setTitleColor(UIColor.white, for: .normal)
                model.isJobApplied = true
                self.arrSearchJobs[sender.tag] = model
                sender.backgroundColor = UIColor.systemPink
                self.applyJob(jobId:/model.jobid?.toString()  , userId:  "47B2611F-B57F-49EE-8970-1514D359AE82" , ipaddress: "192.168.1.1", operationgSystem:  "Mac")
                }
            let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        else {
        
        sender.setTitleColor(UIColor.white, for: .normal)
        model.isJobApplied = true
            self.arrSearchJobs[sender.tag] = model
        sender.backgroundColor = UIColor.systemPink
        self.applyJob(jobId:/model.jobid?.toString()  , userId:  "47B2611F-B57F-49EE-8970-1514D359AE82" , ipaddress: "192.168.1.1", operationgSystem:  "Mac")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return /self.arrSearchJobs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GrowPostCollectionCell", for: indexPath) as! GrowPostCollectionCell
        cell.model = self.arrSearchJobs[indexPath.item]
        cell.btnshare.tag = indexPath.item
        cell.btnApply.tag = indexPath.item
        cell.btnBookmark.tag = indexPath.item
        cell.arrBookMarks = self.arrBookMarks
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = kCollectionItemSpacing * CGFloat(kCollectionNumberOfItemsInOneRow - 1)
            + kCollectionPaddingSectionLeft
            + kCollectionPaddingSectionRight
        return CGSize(width:self.viewAll == true ? (collectionView.frame.width - padding) : (collectionView.frame.width - padding)/2, height: self.viewAll == true ? 140.0 : 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0.01
    }
}
