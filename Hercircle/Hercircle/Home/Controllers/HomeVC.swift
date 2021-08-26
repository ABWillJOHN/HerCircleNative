//
//  ViewController.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/12/21.
//

import UIKit

class HomeVC: SideBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate let headerID = "headerID"
    fileprivate let titleSectionHeader = "TitleSectionHeader"
    fileprivate let titleSectionFooter = "TitleSectionFooter"
    fileprivate let sectionFooter = "SectionFooter"
    
    private let goalsListCell = "GoalsListCell"
    fileprivate let communityCell = "CommunityCell"
    fileprivate let topPickCell = "TopPickCell"
    fileprivate let jobDetailsCell = "JobDetailsCell"
    fileprivate let mustWatchCell = "MustWatchCell"
    
        
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var titleLogoView: TitleLogoView!
    private var yOffset: CGFloat = 0
    
    var homeData: HomeData?
    var communityData: CommunityData?
    var userRelatedCommunityData: CommunityData?
    var jobData: GrowJobs?
        
    let activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        setupTitleLogoView()
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        
        collectionView.collectionViewLayout = createLayout()
        
        self.collectionView!.register(GoalsListCell.self, forCellWithReuseIdentifier: goalsListCell)
        self.collectionView!.register(CommunityCell.self, forCellWithReuseIdentifier: communityCell)
        self.collectionView!.register(TopPickCell.self, forCellWithReuseIdentifier: topPickCell)
        self.collectionView!.register(JobDetailsCell.self, forCellWithReuseIdentifier: jobDetailsCell)
        self.collectionView!.register(MustWatchCell.self, forCellWithReuseIdentifier: mustWatchCell)
        
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: headerID, withReuseIdentifier: headerID)
        collectionView.register(TitleSectionHeader.self, forSupplementaryViewOfKind: titleSectionHeader, withReuseIdentifier: titleSectionHeader)
        collectionView.register(TitleSectionFooter.self, forSupplementaryViewOfKind: titleSectionFooter, withReuseIdentifier: titleSectionFooter)
        collectionView.register(SectionFooter.self, forSupplementaryViewOfKind: sectionFooter, withReuseIdentifier: sectionFooter)

        titleLogoView.connectButton.addTarget(self, action: #selector(connectButtonClicked(sender:)), for: .touchUpInside)
        titleLogoView.engageButton.addTarget(self, action: #selector(engageButtonClicked(sender:)), for: .touchUpInside)
        titleLogoView.growButton.addTarget(self, action: #selector(growButtonClicked(sender:)), for: .touchUpInside)
        titleLogoView.helpButton.addTarget(self, action: #selector(helpButtonClicked(sender:)), for: .touchUpInside)
        titleLogoView.goalsButton.addTarget(self, action: #selector(goalsButtonClicked(sender:)), for: .touchUpInside)
    }
    
    @objc func connectButtonClicked(sender: StackButton) {
        
    }
    
    @objc func engageButtonClicked(sender: StackButton) {
        let vc = UIStoryboard.init(name: "Engage", bundle: Bundle.main).instantiateViewController(withIdentifier: "EngageVC") as? EngageVC
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @objc func growButtonClicked(sender: StackButton) {
        let vc = UIStoryboard.init(name: "Grow", bundle: Bundle.main).instantiateViewController(withIdentifier: "GrowVC") as? GrowVC
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @objc func helpButtonClicked(sender: StackButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelpVC") as? HelpVC
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @objc func goalsButtonClicked(sender: StackButton) {
        
    }
    
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout =  UICollectionViewCompositionalLayout { sectionNumber, env in
            
            switch sectionNumber {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.23), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(130)), subitems: [item])
                group.interItemSpacing = NSCollectionLayoutSpacing.flexible(2)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), elementKind: self.titleSectionHeader, alignment: .topLeading), .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20)), elementKind: self.sectionFooter, alignment: .bottomLeading)]
                return section
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(170)), subitems: [item])
                group.interItemSpacing = NSCollectionLayoutSpacing.flexible(2)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(90)), elementKind: self.titleSectionHeader, alignment: .topLeading, absoluteOffset: .init(x: 0, y: 0)), .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: self.titleSectionFooter, alignment: .bottomLeading)]
                return section
            case 2:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)), subitem: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: self.titleSectionHeader, alignment: .topLeading), .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20)), elementKind: self.sectionFooter, alignment: .bottomLeading)]
                return section
            case 4:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(90)), subitems: [item])
                group.interItemSpacing = NSCollectionLayoutSpacing.flexible(20)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), elementKind: self.titleSectionHeader, alignment: .topLeading, absoluteOffset: .init(x: 0, y: -30)), .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40)), elementKind: self.titleSectionFooter, alignment: .bottomLeading)]
                return section
            default:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(240)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: self.titleSectionHeader, alignment: .topLeading), .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40)), elementKind: self.titleSectionFooter, alignment: .bottomLeading)]
                
                return section
            }
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        let header: [NSCollectionLayoutBoundarySupplementaryItem] = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(420)), elementKind: headerID, alignment: .topLeading)]
        configuration.boundarySupplementaryItems = header
        layout.configuration = configuration
        return layout
    }
    
    fileprivate func getData() {
        let dispatchgroup = DispatchGroup()
        
        activityIndicator.startAnimating()
        dispatchgroup.enter()
        vcViewModel().getHomeData(viewCurrent: self.view) { result in
            switch result {
            case .success(let data):
                self.homeData = data
                dispatchgroup.leave()
            case .failure(let error):
                dispatchgroup.leave()
                self.showAlert(title: error.errorDescription, actionText1: "OK") { _ in
                }
            }
        }
        
        dispatchgroup.enter()
        vcViewModel().getCommunitiesData(viewCurrent: self.view) { result in
            switch result {
            case .success(let data):
                self.communityData = data
                dispatchgroup.leave()
            case .failure(let error):
                dispatchgroup.leave()
                self.showAlert(title: error.errorDescription, actionText1: "OK") { _ in
                }
            }
        }
        
        dispatchgroup.enter()
        if let userId = SigninUserHandler.shared.getUserDeytails()?.data.first?.userId {
            vcViewModel().getUserRelatedCommunitiesData(userId: userId,viewCurrent: self.view) { result in
                switch result {
                case .success(let data):
                    self.userRelatedCommunityData = data
                    dispatchgroup.leave()
                case .failure(let error):
                    dispatchgroup.leave()
                    self.showAlert(title: error.errorDescription, actionText1: "OK") { _ in
                    }
                }
            }
        } else {
            dispatchgroup.leave()
        }
        
        dispatchgroup.enter()
        vcViewModelGrow().getGrowJobs(viewCurrent: self.view) { result in
            switch result {
            case .success(let data):
                self.jobData = data
                dispatchgroup.leave()
            case .failure(let error):
                dispatchgroup.leave()
                self.showAlert(title: error.errorDescription, actionText1: "OK") { _ in
                }
            }
        }
        
        dispatchgroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func setupTitleLogoView() {
        
        titleLogoView = TitleLogoView(frame: .zero)
        view.addSubview(titleLogoView)
        
        let screenSize = UIScreen.main.bounds
        var topPadding: CGFloat = -15
        if screenSize.height < 844 {
            topPadding = -40
        }
        
        titleLogoView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topPadding, left: 0, bottom: 0, right: 0))
        titleLogoView.constrainHeight(constant: 200)
        
        
        titleLogoView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        titleLogoView.layer.cornerRadius = 16
        titleLogoView.layer.borderWidth = 1
        titleLogoView.layer.borderColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1).cgColor
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            let count = (communityData?.data?.count ?? 0)
            return count > 3 ? 3 : count
        case 2:
            let count = (homeData?.data?.todaysTop?.count ?? 0)
            return count > 3 ? count : count
        case 3:
            let count = (homeData?.data?.engageVideo?.count ?? 0)
            return count > 3 ? 3 : count
        case 4:
            let count = (jobData?.data?.count ?? 0)
            return count > 4 ? 4 : count
        case 5:
            let count = (homeData?.data?.creativeCornor?.count ?? 0)
            return count > 3 ? 3 : count
        default:
            let count = (homeData?.data?.infiniteStory?.count ?? 0)
            return count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goalsListCell, for: indexPath) as! GoalsListCell
            let trackList = GoalsTrack.getGoalsTrackList()
            let goal = trackList[indexPath.row]
            cell.populateData(imageString: goal.imageString, goalTitle: goal.goalName)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: communityCell, for: indexPath) as! CommunityCell
            let data = communityData?.data?[indexPath.row]
            cell.populateData(with: data)
            if let userRelatedCommunities = userRelatedCommunityData?.data {
                userRelatedCommunities.forEach { community in
                    if data?.communityId == community.communityId {
                        cell.joinButton.setTitle("Joined", for: .normal)
                        cell.joinButton.setTitleColor(.white, for: .normal)
                        cell.joinButton.backgroundColor = UIColor(r: 255, g: 3, b: 111)
                        cell.tickimageView.isHidden = false
                    }
                }
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topPickCell, for: indexPath) as! TopPickCell
            let data = homeData?.data?.todaysTop?[indexPath.row]
            cell.populateData(with: data)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: jobDetailsCell, for: indexPath) as! JobDetailsCell
            let data = jobData?.data?[indexPath.row]
            cell.populateData(with: data)
            cell.delegate = self
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mustWatchCell, for: indexPath) as! MustWatchCell
            let data: MediaInfo?
            if indexPath.section == 3 {
                data = homeData?.data?.engageVideo?[indexPath.row]
            } else if indexPath.section == 5 {
                data = homeData?.data?.creativeCornor?[indexPath.row]
            } else {
                data = homeData?.data?.infiniteStory?[indexPath.row]
            }
            cell.populateData(with: data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print()
        case 1:
            print()
        case 2:
            let vc = UIStoryboard.init(name: "Grow", bundle: Bundle.main).instantiateViewController(withIdentifier: "GrowVC") as? GrowVC
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
            print()
        case 4:
            print()
        default:
            print()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? TitleSectionHeader {
            if indexPath.section < 6 {
                let headerData = HeaderData.getHeaderData()
                let data = headerData[indexPath.section]
                header.populateData(title: data.title, description: data.description, titleColor: (data.titleColor.r, data.titleColor.g, data.titleColor.b))
            }
            return header
        } else if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? HeaderView {
            header.headerVC.homeMarqueeData = homeData?.data?.homeLead
            return header
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath)
        return header
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = titleLogoView.frame.height/2 - 25
        let scrollViewYoffset = scrollView.contentOffset.y
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else {
                return
            }
            if scrollViewYoffset > height, scrollViewYoffset > self.yOffset {
                self.titleLogoView.transform = CGAffineTransform(translationX: 0, y: -(height))
                self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -(height))
                self.titleLogoView.logoView.alpha = 0
                return
            }
            self.titleLogoView.logoView.alpha = 1
            self.titleLogoView.transform = .identity
            self.navigationController?.navigationBar.transform = .identity
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        yOffset = scrollView.contentOffset.y
    }
}

extension HomeVC: ApplyJobCellDelegate {
    func applyJob(jobId: Int, userId: String) {
        vcViewModelGrow().getGrowJobsApply(jobId: "\(jobId)", userId: userId, ipaddress: "", operationgSystem: "Mac", viewCurrent: self.view) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                self.showAlert(title: error.errorDescription, actionText1: "OK") { _ in
                    
                }
            }
        }
    }
    
}
