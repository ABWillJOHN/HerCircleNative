//
//  CommunityCell.swift
//  Hercircle
//
//  Created by vivekp on 30/07/21.
//

import UIKit

class DietCommunityCell: UITableViewCell ,UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout,UIScrollViewDelegate  {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var  arrCommList : [PopularCommunties]? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    private let kCollectionNumberOfItemsInOneRow = 3
    private let kCollectionPaddingSectionLeft: CGFloat = 12.0
    private let kCollectionPaddingSectionRight: CGFloat = 12.0
    private let kCollectionItemSpacing: CGFloat = 8.0

    override func awakeFromNib() {
        super.awakeFromNib()
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = kCollectionItemSpacing
        flow.sectionInset = UIEdgeInsets(top: 24.0, left: kCollectionPaddingSectionLeft,
                                         bottom: 24.0, right: kCollectionPaddingSectionRight)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnJoined(_ sender: UIButton) {
        
        var model :PopularCommunties = (self.arrCommList?[sender.tag])!
        sender.setTitleColor(/model.isJoined == true ? UIColor.orange : UIColor.white, for: .normal)
        sender.backgroundColor = /model.isJoined == true ? UIColor.white : UIColor.orange
        sender.setTitle(/model.isJoined == true ? "Join" : "Joined", for: .normal)
      
        let dict = [
            "UserID": "9827E332-459E-456A-930E-018784A97C2B",
            "CommunityID": /model.communityId?.toString(),
            "status": /model.isJoined == true ? "0" : "1"
        ] as [String : String]

        DietFitnessVM().postDietCommunities(info: dict) { (result) in
            switch result {
            case .success(_):
                        DispatchQueue.main.async {
                            var newModel = model
                            newModel.isJoined = !(/model.isJoined)
                            model = newModel
                            self.arrCommList?[sender.tag] = model
                            self.collectionView.reloadData()
                            DismissAlert.success.showWithType(type: .success, message: "Success")
                }
            case .failure(let error):
                print("the error \(error)")
                DispatchQueue.main.async {
                    DismissAlert.success.showWithType(type: .success, message: "Success")
                }
            }

        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return /self.arrCommList?.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityCollectionCell", for: indexPath) as! CommunityCollectionCell
        
        let model : PopularCommunties = (self.arrCommList?[indexPath.item])!
        cell.lblCommName.text = model.communityName
        cell.imgComm.sd_setImage(with: URL(string:/model.mediaFileName), placeholderImage: UIImage(named: "left_header"), options: .delayPlaceholder, completed: nil)
        cell.lblMembers.text = /model.members?.toString() + " members"
        cell.btnJoined.setTitleColor(/model.isJoined == true ? UIColor.white : UIColor.orange, for: .normal)
        cell.btnJoined.backgroundColor = /model.isJoined == true ? UIColor.orange : UIColor.white
        cell.btnJoined.setTitle(/model.isJoined == true ? "Joined" : "Join", for: .normal)
        cell.btnJoined.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = kCollectionItemSpacing * CGFloat(kCollectionNumberOfItemsInOneRow - 1)
            + kCollectionPaddingSectionLeft
            + kCollectionPaddingSectionRight
        return CGSize(width: (collectionView.frame.width - padding) / 2.5 , height: 200.0)
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
