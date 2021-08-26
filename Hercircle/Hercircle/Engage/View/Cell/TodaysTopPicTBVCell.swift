//
//  TodaysTopPicTBVCell.swift
//  hercircle
//
//  Created by Keyur Baravaliya on 19/07/21.
//

import UIKit
import Foundation
import PINRemoteImage

class TodaysTopPicTBVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
   
    
    
    @IBOutlet weak var collectionview: UICollectionView!{
        didSet {
            collectionview.register(UINib.init(nibName: "TodayTopicCVCell", bundle: nil), forCellWithReuseIdentifier: "TodayTopicCVCell")
        }
    }
    
    var selectedCellIndex:IndexPath = IndexPath.init(row: 0, section: 0)
    var todayTopicsList:[CreativeCornors]? = nil
    var onTapTodayTopic:((CreativeCornors)->())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        
    }
    
    
    func scrollToNextCell(isLeftSide:Bool = false){
        
        //get cell size

        
        let visibleRect = CGRect(origin: self.collectionview.contentOffset, size: self.collectionview.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionview.indexPathForItem(at: visiblePoint) {
            //MARK:- check count
            print("visiblity index of collection view \(visibleIndexPath.row)")
            if isLeftSide == true {
                if visibleIndexPath.row == 0 {
                    
                }else {
                    self.collectionview.scrollToItem(at: IndexPath.init(row: visibleIndexPath.row - 3, section: 0), at: .left, animated: true)
                }
                
            }else {
                self.collectionview.scrollToItem(at: IndexPath.init(row: visibleIndexPath.row + 3, section: 0), at: .left, animated: true)
            }
        }
    }


    @IBAction func btnLeftSideAction(_ sender: UIButton) {
        self.scrollToNextCell(isLeftSide: true)
    }
    
    @IBAction func btnRightSideAction(_ sender: UIButton) {
        self.scrollToNextCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Collectionview delegate and datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.todayTopicsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: "TodayTopicCVCell", for: indexPath) as! TodayTopicCVCell
        if let todaylistDetails = self.todayTopicsList?[indexPath.row]{
            cell.lblTitle.text = todaylistDetails.categoryName ?? ""
            cell.lblDesc.text = todaylistDetails.titleHeader ?? ""
            cell.imgView.pin_updateWithProgress = true
            cell.imgView.pin_setImage(from: URL(string: todaylistDetails.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)
        }

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionview.frame.height/3-10
        let width = self.collectionview.frame.width
        return CGSize.init(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedTodayTopic = self.todayTopicsList?[indexPath.row] {
            if let getAct = self.onTapTodayTopic {
                getAct(selectedTodayTopic)
            }
        }
    }
    
}
