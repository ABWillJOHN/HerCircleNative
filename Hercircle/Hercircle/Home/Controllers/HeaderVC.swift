//
//  GoalsListController.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit

class HeaderVC: BaseVC, UICollectionViewDelegateFlowLayout {
    private let reuseIdentifier = "headerCell"
    var homeMarqueeData: [MediaInfo]? {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = createLayout()
        self.collectionView!.register(HeaderCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout =  UICollectionViewCompositionalLayout { sectionNumber, env in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(240)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = .init(top: 30, leading: 18, bottom: 0, trailing:18)
                return section
            }
            return nil
        }
        return layout
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = (homeMarqueeData?.count ?? 0)
        return count > 5 ? 5 : count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeaderCell
        if let data = homeMarqueeData?[indexPath.row] {
            cell.populateData(with: data)
        }
        return cell
    }
}
