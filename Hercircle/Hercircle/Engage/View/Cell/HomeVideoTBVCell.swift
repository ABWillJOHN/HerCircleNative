//
//  HomeVideoTBVCell.swift
//  hercircle
//
//  Created by Keyur Baravaliya on 20/07/21.
//

import UIKit

class HomeVideoTBVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    

    @IBOutlet weak var collectionview: UICollectionView!{
        didSet {
            collectionview.register(UINib.init(nibName: "HomeVideosCVCell", bundle: nil), forCellWithReuseIdentifier: "HomeVideosCVCell")
            collectionview.collectionViewLayout = createCompositionalLayout()
        }
    }
    
    var videoList:[CreativeCornors]? = nil
    var onTapPlayAction:((CreativeCornors)->())? = nil
    var onTapMoreAction:((CreativeCornors)->())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Collectionview delegate and datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4//self.videoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionview.dequeueReusableCell(withReuseIdentifier: "HomeVideosCVCell", for: indexPath) as! HomeVideosCVCell
        if let videoDetails = self.videoList?[indexPath.row] {
            cell.lblTitle.text = videoDetails.categoryName ?? ""
            cell.lblDesc.text = videoDetails.titleHeader ?? ""
            cell.videoImgView.pin_updateWithProgress = true
            cell.videoImgView.pin_setImage(from: URL(string: videoDetails.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)
//            cell.onTapPlayAction = {
//                if let getPlayAct = self.onTapPlayAction {
//                    getPlayAct(videoDetails)
//                }
//            }
            cell.onTapMoreAction = {
                if let getMoreAction = self.onTapMoreAction {
                    getMoreAction(videoDetails)
                }
            }
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = self.collectionview.frame.height/2
//        let width = self.collectionview.frame.width/2-10
//        return CGSize.init(width: width, height: height)
//    }
    //MARK: - Helper Method
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.HomeVideosLayoutSection()
            default: return self.HomeVideosLayoutSection()
            }
        }
    }
    private func HomeVideosLayoutSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(145))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets.leading = 10

        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let videoDetails = self.videoList?[indexPath.row]{
            if let getPlayAct = self.onTapPlayAction {
                getPlayAct(videoDetails)
            }
        }

    }
    
}
