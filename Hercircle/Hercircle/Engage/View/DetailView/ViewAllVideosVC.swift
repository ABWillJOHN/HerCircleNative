//
//  ViewAllVideosVC.swift
//  hercircle
//
//  Created by Keyur Baravaliya on 22/07/21.
//

import UIKit

class ViewAllVideosVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    @IBOutlet var collectionView: UICollectionView!{
        didSet {
            collectionView.register(UINib.init(nibName: "HomeVideosCVCell", bundle: nil), forCellWithReuseIdentifier: "HomeVideosCVCell")
            collectionView.collectionViewLayout = createCompositionalLayout()
        }
    }
    
    var videosTopList:[CreativeCornors]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Must-Watch Video's"
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    //MARK:- Collectionview delegate and datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videosTopList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVideosCVCell", for: indexPath) as! HomeVideosCVCell
        if let getVideosDetails = self.videosTopList?[indexPath.row] {
            cell.lblTitle.text = getVideosDetails.categoryName
            cell.lblDesc.text = getVideosDetails.titleHeader
            cell.videoImgView?.pin_updateWithProgress = true
            cell.videoImgView?.pin_setImage(from: URL(string: getVideosDetails.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = Double(200.0)
//        let width = Double(self.collectionView.frame.width/2-10)
//        print("videos cell height's ===>%@\(height)")
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


}
