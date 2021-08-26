//
//  EngageVC.swift
//  Hercircle
//
//  Created by Rahul Patel on 21/07/21.
//

import UIKit

class EngageVC: SideBaseVC, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    var filterArrayCellBgColor = [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
    var homeData:DataClass? = nil
    var filterEngage: [CreativeCornors] = []
    var filterInfinite: [CreativeCornors] = []

    @IBOutlet weak var filterCollectionview: UICollectionView! {
        didSet {
            filterCollectionview.register(UINib.init(nibName: "FilterCVCell", bundle: nil), forCellWithReuseIdentifier: "FilterCVCell")
        }
    }

    @IBOutlet weak var homeTableView: UITableView! {
        didSet {
            //MARK:- footer uiview
            homeTableView.register(UINib.init(nibName: "HomeTBVFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeTBVFooter")
            homeTableView.register(UINib.init(nibName: "HomeTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeTableViewHeader")

            //MARK: Tableview cell register
            homeTableView.register(UINib.init(nibName: "HomeTBVCell", bundle: nil), forCellReuseIdentifier: "HomeTBVCell")
            homeTableView.register(UINib.init(nibName: "TodaysTopPicTBVCell", bundle: nil), forCellReuseIdentifier: "TodaysTopPicTBVCell")
            homeTableView.register(UINib.init(nibName: "HomeVideoTBVCell", bundle: nil), forCellReuseIdentifier: "HomeVideoTBVCell")
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.filterCollectionview.delegate = self
        self.filterCollectionview.dataSource = self

        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self

        self.homeTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: CGFloat.leastNormalMagnitude))
        //self.convertJsonToObject()
        callApi()

    }

    func callApi() {
        EngageViewModel().getStory(name: "") { (result) in
            switch result {
            case .success(let stories):
                DispatchQueue.main.async {
                    if stories?.statusCode == 200
                    {
                        self.homeData = stories?.data
                        self.homeTableView.reloadData()
                        self.filterCollectionview.reloadData()
                    }else{
                        self.showAlert(title:stories?.systemMsg ?? "", actionText1: "OK") { _ in }
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                self.showAlert(title:error.errorDescription, actionText1: "OK") { _ in }


            }
        }
    }
    @IBAction func onTapFilterAction(_ sender: UIControl) {

        let dateviewVC = DateFilterVC()
        self.navigationController?.pushViewController(dateviewVC, animated: true)
    }

    //MARK:- Tableview delegate and datasource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            if filterEngage.count != 0{
                return self.filterEngage.count
            }else{
                return 2//self.homeData?.engageLead?.count ?? 0
            }
        }else if section == 1 {
            return 1//self.homeData?.todaysTop?.count ?? 0
        }else if section == 2 {
            return 2//self.homeData?.editorChoice?.count ?? 0
        }else if section == 3 {
            return 1//self.homeData?.engageVideo?.count ?? 0
        }else if section == 4 {
            if filterEngage.count != 0{
                return self.filterInfinite.count
            }else{
                return self.homeData?.infiniteStory?.count ?? 0
            }

        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeTBVcell = self.homeTableView.dequeueReusableCell(withIdentifier: "HomeTBVCell", for: indexPath) as! HomeTBVCell

        if indexPath.section == 0 {
            if filterEngage.count != 0 {
                let homeDetails = self.filterEngage[indexPath.row]
                homeTBVcell.lblTitle.text = homeDetails.categoryName ?? ""
                homeTBVcell.lblDesc.text = homeDetails.titleHeader ?? ""
               // homeTBVcell.imgeView.image = #imageLiteral(resourceName: "img_videos")
                homeTBVcell.imgeView.pin_updateWithProgress = true
                homeTBVcell.imgeView.pin_setImage(from: URL(string: homeDetails.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)

            }else{
                let homeDetails = self.homeData?.engageLead?[indexPath.row]
                homeTBVcell.lblTitle.text = homeDetails?.categoryName ?? ""
                homeTBVcell.lblDesc.text = homeDetails?.titleHeader ?? ""
               // homeTBVcell.imgeView.image = #imageLiteral(resourceName: "img_videos")
                homeTBVcell.imgeView.pin_updateWithProgress = true
                homeTBVcell.imgeView.pin_setImage(from: URL(string: homeDetails?.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)
            }

            return homeTBVcell
        }else if indexPath.section == 1 {
            let todaysTopicCell = self.homeTableView.dequeueReusableCell(withIdentifier: "TodaysTopPicTBVCell", for: indexPath) as! TodaysTopPicTBVCell
            todaysTopicCell.todayTopicsList = self.homeData?.todaysTop
            todaysTopicCell.collectionview.reloadData()
            todaysTopicCell.onTapTodayTopic = { selectedTodayTopic in
                print(selectedTodayTopic.categoryName as Any)
                let webviewVC = WebviewVC()
                webviewVC.webUrlString = selectedTodayTopic.contentURL ?? "www.apple.com"
                self.navigationController?.pushViewController(webviewVC, animated: true)
            }
            return todaysTopicCell
        }else if indexPath.section == 2 {
            let editorChoiceDetails = self.homeData?.editorChoice?[indexPath.row]
            homeTBVcell.lblTitle.text = editorChoiceDetails?.categoryName ?? ""
            homeTBVcell.lblDesc.text = editorChoiceDetails?.titleHeader ?? ""
            //homeTBVcell.imgeView.image = #imageLiteral(resourceName: "img_videos")
            homeTBVcell.imgeView.pin_updateWithProgress = true
            homeTBVcell.imgeView.pin_setImage(from: URL(string: editorChoiceDetails?.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)
            return homeTBVcell
        }else if indexPath.section == 3 {
            let videosCell = self.homeTableView.dequeueReusableCell(withIdentifier: "HomeVideoTBVCell", for: indexPath) as! HomeVideoTBVCell
            videosCell.videoList = self.homeData?.engageVideo
            videosCell.onTapPlayAction = { selectedVideoDetails in
                print("\(String(describing: selectedVideoDetails.categoryName))")
                let webviewVC = WebviewVC()
                webviewVC.webUrlString = selectedVideoDetails.contentURL ?? "www.apple.com"
                self.navigationController?.pushViewController(webviewVC, animated: true)

            }
            videosCell.onTapMoreAction = { selectedVideoDetails in
                print(selectedVideoDetails.categoryName)
            }
            videosCell.collectionview.reloadData()
            return videosCell
        }
        else {
//            let cell = self.homeTableView.dequeueReusableCell(withIdentifier: "HomeTBVCell", for: indexPath) as! HomeTBVCell
//
//            return cell
            if filterInfinite.count != 0 {
                let infiniteDetails = self.filterInfinite[indexPath.row]
                homeTBVcell.lblTitle.text = infiniteDetails.categoryName ?? ""
                homeTBVcell.lblDesc.text = infiniteDetails.titleHeader ?? ""
                homeTBVcell.imgeView.pin_updateWithProgress = true
                homeTBVcell.imgeView.pin_setImage(from: URL(string: infiniteDetails.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)
                return homeTBVcell
            }else{
                let infiniteDetails = self.homeData?.infiniteStory?[indexPath.row]
                homeTBVcell.lblTitle.text = infiniteDetails?.categoryName ?? ""
                homeTBVcell.lblDesc.text = infiniteDetails?.titleHeader ?? ""
                homeTBVcell.imgeView.pin_updateWithProgress = true
                homeTBVcell.imgeView.pin_setImage(from: URL(string: infiniteDetails?.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)
                return homeTBVcell
            }

        }

    }


    //MARK:- Tableview header View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.homeTableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableViewHeader") as! HomeTableViewHeader
        if section == 1 {
            headerView.lblTitle.text = "today's top picks"
            return headerView
        }else if section == 2 {
            headerView.lblTitle.text = "editor's choice"
            return headerView
        }else if section == 3 {
            headerView.lblTitle.text = "must-watch video's"
            return headerView
        }
        return  UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 || section == 3 {
            return 30.0
        }
        return 0.0
    }


    //MARk:- Tableview footer view
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0.0
        }
        return 50.0
    }


    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return UIView()
        }else {
            let footerView = self.homeTableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTBVFooter") as! HomeTBVFooter
            footerView.onTapDownArrrow = {
                print("footer down arrow click section \(section)")
            }

            footerView.onTapViewAll = {
                if section == 3 {
                    let viewAllvideoVc = ViewAllVideosVC()
                    viewAllvideoVc.videosTopList = self.homeData?.engageVideo
                    self.navigationController?.pushViewController(viewAllvideoVc, animated: true)
                }else {
                    let viewAllVc = ViewAllTopicsVC()
                    switch section {
                    case 0:
                        viewAllVc.viewAllList = self.homeData?.engageLead
                    case 2:
                        viewAllVc.viewAllList = self.homeData?.editorChoice
                    case 4:
                        viewAllVc.viewAllList = self.homeData?.infiniteStory
                    default:
                        viewAllVc.viewAllList = self.homeData?.infiniteStory
                    }
                    self.navigationController?.pushViewController(viewAllVc, animated: true)
                }
                print("footer click on view all section is \(section)")
            }

            return footerView
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row--%@ \(indexPath.row)")
        print("select section--%@ \(indexPath.section)")
        let webviewVC = WebviewVC()
        switch indexPath.section {
        case 0:
            let engageRow = self.homeData?.engageLead?[indexPath.row]
            webviewVC.webUrlString = engageRow?.contentURL ?? "www.apple.com"
        case 1:
            let todaysTopRow = self.homeData?.todaysTop?[indexPath.row]
            webviewVC.webUrlString = todaysTopRow?.contentURL ?? "www.apple.com"
        case 2:
            let editorChoiceRow = self.homeData?.editorChoice?[indexPath.row]
            webviewVC.webUrlString = editorChoiceRow?.contentURL ?? "www.apple.com"
        case 3:
            let engageVideoRow = self.homeData?.engageVideo?[indexPath.row]
            webviewVC.webUrlString = engageVideoRow?.contentURL ?? "www.apple.com"
        case 4:
            let infiniteStoryRow = self.homeData?.infiniteStory?[indexPath.row]
            webviewVC.webUrlString = infiniteStoryRow?.contentURL ?? "www.apple.com"
        default:
            break
        }
        self.navigationController?.pushViewController(webviewVC, animated: true)
    }


    //TOP horizontal Menu
    //MARK:- Collectionview delegate and datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeData?.categories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.filterCollectionview.dequeueReusableCell(withReuseIdentifier: "FilterCVCell", for: indexPath) as! FilterCVCell
        if let getCatDetails = self.homeData?.categories?[indexPath.row] {
            cell.lblTitle.text = getCatDetails.categoryName 
        }
        cell.mainContainView.backgroundColor = self.filterArrayCellBgColor.randomElement()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select filter index is ====>%@ \(indexPath.row)")
        filterEngage = []
        filterInfinite = []
        if let cateId = homeData?.categories?[indexPath.row].categoryId {
            //let cateId = 1//homeData?.categories?[indexPath.row].categoryId
            let engageEntries = homeData?.engageLead?.filter({ cateId == $0.categoryId })
            //print("engageEntries--\(String(describing: engageEntries))")
            for engage in engageEntries! {
                self.filterEngage.append(engage)
                //self.homeTableView.reloadData()
            }
            let infiniteEntries = homeData?.infiniteStory?.filter({ cateId == $0.categoryId })
            print("infiniteEntries--\(String(describing: infiniteEntries?.count))")
            for infinite in infiniteEntries! {
                self.filterInfinite.append(infinite)
                //self.homeTableView.reloadData()
            }
            self.homeTableView.reloadData()
        }
    }


    //MARK:- JSON Convert to model
   /* func convertJsonToObject() {
        let jsonString = """
        {
            "data": {
                "categories": [
                    {
                        "categoryId": 27,
                        "categoryName": "Playroll",
                        "createdBy": "Avnish",
                        "createdOn": "1/4/2021 2:14:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "1/4/2021 2:14:52 PM",
                        "subCategories": []
                    },
                    {
                        "categoryId": 17,
                        "categoryName": "Food",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 40,
                                "categoryName": "How-Tos",
                                "createdBy": "Avnish",
                                "createdOn": "4/30/2021 5:51:06 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/30/2021 5:51:06 PM"
                            },
                            {
                                "categoryId": 39,
                                "categoryName": "Food-trends",
                                "createdBy": "Avnish",
                                "createdOn": "4/30/2021 5:51:06 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/30/2021 5:51:06 PM"
                            },
                            {
                                "categoryId": 38,
                                "categoryName": "Recipes",
                                "createdBy": "Avnish",
                                "createdOn": "4/30/2021 5:51:06 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/30/2021 5:51:06 PM"
                            }
                        ]
                    },
                    {
                        "categoryId": 8,
                        "categoryName": "Culture",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 26,
                                "categoryName": "Horoscope",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 25,
                                "categoryName": "Celebs",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 24,
                                "categoryName": "Pop-Culture",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 23,
                                "categoryName": "Books",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 22,
                                "categoryName": "Events",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            }
                        ]
                    },
                    {
                        "categoryId": 7,
                        "categoryName": "Work",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 21,
                                "categoryName": "Finance",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 20,
                                "categoryName": "Career",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            }
                        ]
                    },
                    {
                        "categoryId": 6,
                        "categoryName": "Living",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 19,
                                "categoryName": "Decor",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 18,
                                "categoryName": "Travel",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            }
                        ]
                    },
                    {
                        "categoryId": 5,
                        "categoryName": "Get-Inspired",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 30,
                                "categoryName": "Women-in-Sports",
                                "createdBy": "Avnish",
                                "createdOn": "3/31/2021 2:13:32 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "3/31/2021 2:13:32 PM"
                            },
                            {
                                "categoryId": 16,
                                "categoryName": "Trending",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 15,
                                "categoryName": "Achievers",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            }
                        ]
                    },
                    {
                        "categoryId": 4,
                        "categoryName": "Relationships",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 29,
                                "categoryName": "Pets",
                                "createdBy": "Avnish",
                                "createdOn": "3/31/2021 2:12:06 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "3/31/2021 2:12:06 PM"
                            },
                            {
                                "categoryId": 14,
                                "categoryName": "Family-and-Friends",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 13,
                                "categoryName": "Love",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 12,
                                "categoryName": "Parenting",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            }
                        ]
                    },
                    {
                        "categoryId": 3,
                        "categoryName": "Beauty-and-Health",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 37,
                                "categoryName": "Health",
                                "createdBy": "Avnish",
                                "createdOn": "4/22/2021 8:21:23 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/22/2021 8:21:23 PM"
                            },
                            {
                                "categoryId": 36,
                                "categoryName": "DIY",
                                "createdBy": "Avnish",
                                "createdOn": "4/22/2021 8:21:23 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/22/2021 8:21:23 PM"
                            },
                            {
                                "categoryId": 35,
                                "categoryName": "Skincare",
                                "createdBy": "Avnish",
                                "createdOn": "4/22/2021 8:21:23 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/22/2021 8:21:23 PM"
                            },
                            {
                                "categoryId": 34,
                                "categoryName": "Makeup",
                                "createdBy": "Avnish",
                                "createdOn": "4/22/2021 8:21:23 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/22/2021 8:21:23 PM"
                            }
                        ]
                    },
                    {
                        "categoryId": 2,
                        "categoryName": "Fashion-and-Sustainability",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 33,
                                "categoryName": "DIY",
                                "createdBy": "Avnish",
                                "createdOn": "4/22/2021 8:21:17 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/22/2021 8:21:17 PM"
                            },
                            {
                                "categoryId": 32,
                                "categoryName": "News",
                                "createdBy": "Avnish",
                                "createdOn": "4/22/2021 8:21:17 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/22/2021 8:21:17 PM"
                            },
                            {
                                "categoryId": 31,
                                "categoryName": "Trends",
                                "createdBy": "Avnish",
                                "createdOn": "4/22/2021 8:21:17 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "4/22/2021 8:21:17 PM"
                            }
                        ]
                    },
                    {
                        "categoryId": 1,
                        "categoryName": "Wellness",
                        "createdBy": "Avnish",
                        "createdOn": "8/22/2020 6:59:52 PM",
                        "updatedBy": "Avnish",
                        "updatedon": "8/22/2020 6:59:52 PM",
                        "subCategories": [
                            {
                                "categoryId": 28,
                                "categoryName": "Reproductive-Health",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 11,
                                "categoryName": "Nutrition",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 10,
                                "categoryName": "Fitness",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            },
                            {
                                "categoryId": 9,
                                "categoryName": "Mental-Wellbeing",
                                "createdBy": "Avnish",
                                "createdOn": "8/22/2020 6:59:52 PM",
                                "updatedBy": "Avnish",
                                "updatedon": "8/22/2020 6:59:52 PM"
                            }
                        ]
                    }
                ],
                "homeLead": [
                    {
                        "contentId": 132,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "The Birds And The Bees: An Age-Wise Guide For Parents",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 7:50:00 AM",
                        "validUpTo": "11/4/2120 7:50:00 AM",
                        "contentSummary": "<p>We bring you expert advice on appropriate topics to cover when you talk to your child about sex. Here&rsquo;s our age-wise guide.&nbsp; &nbsp;&nbsp;</p>",
                        "tags": "today's top picks,editor's choice,home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/14C7A4B7-DB54-4668-814B-4EFB69DD186C.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/The-Birds-And-The-Bees-An-AgeWise-Guide-For-Parents-132.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 168,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "6 Naturally Detoxifying Foods You Can Find In Your Kitchen",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/18/2020 1:13:38 PM",
                        "validUpTo": "11/18/2120 1:13:38 PM",
                        "contentSummary": "<p>Detox made easy with six naturally detoxifying foods that you can find in your kitchen.</p>",
                        "tags": "Diet,EatHeathy,EatRight,home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/708FEEA1-932A-48B9-99AF-18D266A6082D.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/6-Naturally-Detoxifying-Foods-You-Can-Find-In-Your-Kitchen-168.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 189,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "Roti Making",
                        "author": "Sushil Bhat",
                        "validFrom": "1/14/2021 4:00:59 PM",
                        "validUpTo": "1/14/2121 4:00:59 PM",
                        "contentSummary": "<p>The efficient way of making Roti.</p>",
                        "tags": "home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CFAC76FC-CB78-411D-A05D-F94BBEBF72DE.JPG",
                        "mediaURL": "https://media.hercircle.in/media/newRotiMaking20201111115824/newRotiMaking20201111115824masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Roti-Making-189.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 160,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "The Best Self-Care Practice For You, As Per Your Zodiac",
                        "author": "Avnish Kumar",
                        "validFrom": "11/13/2020 10:00:58 PM",
                        "validUpTo": "11/13/2120 10:00:58 PM",
                        "contentSummary": "<p><span lang=\"EN-IN\" style=\"font-size: 11.0pt; line-height: 107%; font-family: 'Calibri',sans-serif; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-IN; mso-fareast-language: EN-US; mso-bidi-language: AR-SA;\">Undoubtedly, self-care is for everyone, but what de-stresses each individual is different</span></p>",
                        "tags": "editor's choice,home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C9311463-49E2-4C2A-B6A3-BD37957C1208.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/The-Best-SelfCare-Practice-For-You-As-Per-Your-Zodiac-160.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 156,
                        "contentTypeId": 1,
                        "categoryId": 5,
                        "titleHeader": "the natural beauty",
                        "author": "VG",
                        "validFrom": "11/13/2020 3:41:11 PM",
                        "validUpTo": "11/13/2120 3:41:11 PM",
                        "contentSummary": "<p>the natural beauty</p>",
                        "tags": "home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C55AB8E1-3B8E-4E3D-9BB1-7B4D2AD28044.PNG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/get-inspired/fitness/the-natural-beauty-156.html",
                        "categoryName": "Get-Inspired",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 147,
                        "contentTypeId": 1,
                        "categoryId": 5,
                        "titleHeader": "Checking for Mobile",
                        "author": "Jhumur Ganguly",
                        "validFrom": "11/12/2020 4:40:46 PM",
                        "validUpTo": "11/12/2120 4:40:46 PM",
                        "contentSummary": "<p>Checking for Mobile</p>",
                        "tags": "home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/E8549B2F-F79A-4139-B90B-3AA7E37C75A4.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/get-inspired/fitness/Checking-for-Mobile-147.html",
                        "categoryName": "Get-Inspired",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 146,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "Is Women Empowerment a Reality in India",
                        "author": "Jhumur Ganguly",
                        "validFrom": "11/12/2020 4:12:30 PM",
                        "validUpTo": "11/12/2120 4:12:30 PM",
                        "contentSummary": "<p>Is the lead image appearing properly?</p>",
                        "tags": "covid 19,home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/402CC18C-302C-4CE7-B25E-9872D245A302.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/Is-Women-Empowerment-a-Reality-in-India-146.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 134,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "The Benefits Of Cycling And Choosing The Right Bike For You",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/4/2020 2:09:27 PM",
                        "validUpTo": "11/4/2120 2:09:27 PM",
                        "contentSummary": "<p>There&rsquo;s no denying that cycling has many health benefits, and has recently gained popularity during the lockdown. Here&rsquo;s everything you need to know about the benefits cycling has on your health and well-being, and how to choose the right bike for your needs.</p>",
                        "tags": "home lead story,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/D226CF03-571D-423C-A18B-F40A93CDA0F6.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/The-Benefits-Of-Cycling-And-Choosing-The-Right-Bike-For-You-134.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 133,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "Money Matters: How To Manage Your Finances Effectively In Your 40s",
                        "author": "Nikshubha Garg",
                        "validFrom": "11/4/2020 1:37:47 PM",
                        "validUpTo": "11/4/2120 1:37:47 PM",
                        "contentSummary": "<p class=\"MsoNormal\"><span lang=\"EN-US\" style=\"font-size: 11.0pt; mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-US;\">You have made your mistakes and learnt from them. Here&rsquo;s how you can plan your money in 40s</span></p>",
                        "tags": "FinanceGoals,home lead story,PersonalFinance",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/D5C6AB64-40A6-4AB7-9BE1-34428E56DFCD.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/Money-Matters-How-To-Manage-Your-Finances-Effectively-In-Your-40s-133.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 131,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "How To Talk To Your Child About The Birds And The Bees",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 1:12:56 PM",
                        "validUpTo": "11/4/2120 1:12:56 PM",
                        "contentSummary": "<p>It&rsquo;s been well documented that sex education makes for a powerful tool when it comes to awareness and sexual health. The question remains, when should the education begin, and how to go about it.&nbsp;</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/9651BF51-581F-45E5-B8EA-3CB428B720B5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/How-To-Talk-To-Your-Child-About-The-Birds-And-The-Bees-131.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 130,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "Here&#39;s Why You Should Talk To Your Child About The Birds And The Bees",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 12:46:58 PM",
                        "validUpTo": "11/4/2120 12:46:58 PM",
                        "contentSummary": "<p>Children should be able, and more importantly, feel comfortable enough to talk to their parents about anything, particularly sex. Besides, you want then to learn the right way, don&rsquo;t you? Which is why it&rsquo;s important that sex education begins at home. We tell you why.&nbsp;</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/29A03DEC-F8D8-43DB-8E13-51A08094F8C6.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/Heres-Why-You-Should-Talk-To-Your-Child-About-The-Birds-And-The-Bees-130.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 126,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "Money Matters: How To Manage Your Finances In Your 60s",
                        "author": "Nikshubha Garg",
                        "validFrom": "11/3/2020 1:25:54 PM",
                        "validUpTo": "11/3/2120 1:25:54 PM",
                        "contentSummary": "<p class=\"MsoNormal\"><span lang=\"EN-US\" style=\"font-size: 11.0pt; mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-US;\">Retired or closing in on it, here is everything about money in your 60s.</span></p>",
                        "tags": "FinanceGoals,home lead story,PersonalFinance,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/65BCC89E-DB0E-4BEF-AD3F-E99C44822620.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/Money-Matters-How-To-Manage-Your-Finances-In-Your-60s-126.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 124,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "5 Activities To Do During A Major Power Outage",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/3/2020 11:34:09 AM",
                        "validUpTo": "11/3/2120 11:34:09 AM",
                        "contentSummary": "<p>Are you so reliant on technology and your devices that you don&rsquo;t know what to do if there&rsquo;s a power outage, and you&rsquo;ve lost that essential WiFi? Here are some fun ways to keep your mind occupied if there&rsquo;s a major power cut in your neighbourhood, or city.</p>",
                        "tags": "editor's choice,home lead story,today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/83BD5CA6-516A-4B91-99B5-9DA323BFA8B2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-Activities-To-Do-During-A-Major-Power-Outage-124.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 119,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "5 Signs Your Child Is Being Bullied",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/2/2020 4:51:14 PM",
                        "validUpTo": "11/2/2120 4:51:14 PM",
                        "contentSummary": "<p>Sometimes, they may not know how to express themselves, but when you notice subtle changes in your child, you might want to investigate. Here are signs your child is being bullied.</p>",
                        "tags": "editor's choice,home lead story,today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/3E5D6340-12E6-442E-801D-BD9D35D0BBB0.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/5-Signs-Your-Child-Is-Being-Bullied-119.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 118,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Cool article",
                        "author": "Avnish",
                        "validFrom": "11/2/2020 4:15:24 PM",
                        "validUpTo": "11/2/2120 4:15:24 PM",
                        "contentSummary": "<p>Wow what a story</p>",
                        "tags": "home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/4318DC09-94F9-42DC-8E84-DBC29D745543.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Cool-article-118.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 111,
                        "contentTypeId": 5,
                        "categoryId": 2,
                        "titleHeader": "Wow what a visual story",
                        "author": "Avnish Kumar",
                        "validFrom": "10/30/2020 3:54:50 PM",
                        "validUpTo": "10/30/2120 3:54:50 PM",
                        "contentSummary": "<p>wow what a story</p>",
                        "tags": "home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/5C5FAD67-3951-4E36-A032-058E6EAFF4FD.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/fashion-and-sustainability/fitness/Wow-what-a-visual-story-111.html",
                        "categoryName": "Fashion-and-Sustainability",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 95,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Our first story together",
                        "author": "Avnish Kumar",
                        "validFrom": "10/28/2020 9:23:51 PM",
                        "validUpTo": "10/28/2120 9:23:51 PM",
                        "contentSummary": "<p>This is wonderful.</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0776FC06-2480-42BF-A618-7D58C16C0033.PNG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-korean-dramas-that-are-all-the-rage-2.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    }
                ],
                "engageLead": [
                    {
                        "contentId": 238,
                        "contentTypeId": 1,
                        "categoryId": 17,
                        "titleHeader": "Great story of a human being",
                        "author": "Avnish",
                        "validFrom": "4/26/2021 9:34:03 AM",
                        "validUpTo": "4/26/2121 9:34:03 AM",
                        "contentSummary": "<p>Great sumary for a human being!!!</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CB8080E3-C1AC-4B4F-B4AA-F60CC812D480.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/food/diy/Great-story-of-a-human-being-238.html",
                        "categoryName": "Food",
                        "subCategoryName": "DIY"
                    },
                    {
                        "contentId": 236,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "The benefits of Surya Namaskar",
                        "author": "Avnish Kumar",
                        "validFrom": "4/8/2021 1:45:00 PM",
                        "validUpTo": "4/8/2121 2:30:53 AM",
                        "contentSummary": "<p>The benefits of Surya Namaskar.</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/57E3F9B0-A57B-47E2-B9EA-A6B73A82CD02.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Benefits-of-Surya-Namaskar.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 220,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "I want rain",
                        "author": "Shrutika",
                        "validFrom": "3/15/2021 2:24:00 AM",
                        "validUpTo": "3/15/2121 2:24:00 AM",
                        "contentSummary": "<p>Great summary for frogs</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/E32BA78E-AEEC-4493-B823-CC2E2216F4CA.GIF",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/I-want-rain-220.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 218,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Cool Story!!!",
                        "author": "Avnish Kumar",
                        "validFrom": "3/1/2021 7:55:16 AM",
                        "validUpTo": "3/1/2121 7:55:16 AM",
                        "contentSummary": "<p>Cool summary!!!</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/45301F1E-208A-4188-9004-3F2450C589AB.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Cool-Story-218.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 217,
                        "contentTypeId": 1,
                        "categoryId": 2,
                        "titleHeader": "Wow inspirational",
                        "author": "Avnish",
                        "validFrom": "2/26/2021 9:56:39 AM",
                        "validUpTo": "2/26/2121 9:56:39 AM",
                        "contentSummary": "<p>Inspirational summary</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/E9B92483-4907-45BA-B5EB-0B75925F2153.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/fashion-and-sustainability/fitness/Wow-inspirational-217.html",
                        "categoryName": "Fashion-and-Sustainability",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 167,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "What a wonderful story again",
                        "author": "Avnish Kumar",
                        "validFrom": "11/18/2020 1:02:12 PM",
                        "validUpTo": "11/18/2120 1:02:12 PM",
                        "contentSummary": "<p>Wow just amazing</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/06C5B2CA-0E54-4F55-936F-F4B9EAA2C75E.JPEG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/What-a-wonderful-story-again-167.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 134,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "The Benefits Of Cycling And Choosing The Right Bike For You",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/4/2020 2:09:27 PM",
                        "validUpTo": "11/4/2120 2:09:27 PM",
                        "contentSummary": "<p>There&rsquo;s no denying that cycling has many health benefits, and has recently gained popularity during the lockdown. Here&rsquo;s everything you need to know about the benefits cycling has on your health and well-being, and how to choose the right bike for your needs.</p>",
                        "tags": "home lead story,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/D226CF03-571D-423C-A18B-F40A93CDA0F6.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/The-Benefits-Of-Cycling-And-Choosing-The-Right-Bike-For-You-134.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 126,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "Money Matters: How To Manage Your Finances In Your 60s",
                        "author": "Nikshubha Garg",
                        "validFrom": "11/3/2020 1:25:54 PM",
                        "validUpTo": "11/3/2120 1:25:54 PM",
                        "contentSummary": "<p class=\"MsoNormal\"><span lang=\"EN-US\" style=\"font-size: 11.0pt; mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-US;\">Retired or closing in on it, here is everything about money in your 60s.</span></p>",
                        "tags": "FinanceGoals,home lead story,PersonalFinance,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/65BCC89E-DB0E-4BEF-AD3F-E99C44822620.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/Money-Matters-How-To-Manage-Your-Finances-In-Your-60s-126.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 124,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "5 Activities To Do During A Major Power Outage",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/3/2020 11:34:09 AM",
                        "validUpTo": "11/3/2120 11:34:09 AM",
                        "contentSummary": "<p>Are you so reliant on technology and your devices that you don&rsquo;t know what to do if there&rsquo;s a power outage, and you&rsquo;ve lost that essential WiFi? Here are some fun ways to keep your mind occupied if there&rsquo;s a major power cut in your neighbourhood, or city.</p>",
                        "tags": "editor's choice,home lead story,today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/83BD5CA6-516A-4B91-99B5-9DA323BFA8B2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-Activities-To-Do-During-A-Major-Power-Outage-124.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 119,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "5 Signs Your Child Is Being Bullied",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/2/2020 4:51:14 PM",
                        "validUpTo": "11/2/2120 4:51:14 PM",
                        "contentSummary": "<p>Sometimes, they may not know how to express themselves, but when you notice subtle changes in your child, you might want to investigate. Here are signs your child is being bullied.</p>",
                        "tags": "editor's choice,home lead story,today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/3E5D6340-12E6-442E-801D-BD9D35D0BBB0.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/5-Signs-Your-Child-Is-Being-Bullied-119.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 103,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "15 Important Investment Terms You Should Know About",
                        "author": "Nikshubha Garg",
                        "validFrom": "10/29/2020 7:51:10 PM",
                        "validUpTo": "10/29/2120 7:51:10 PM",
                        "contentSummary": "<p>Familiarise yourself with important investment terms before your dive in&nbsp;</p>",
                        "tags": "today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8304417A-2406-44A3-A4D6-CAD83C46A412.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/15-Important-Investment-Terms-You-Should-Know-About-103.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 96,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Movie Review: Enola Holmes",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/29/2020 6:09:56 PM",
                        "validUpTo": "10/29/2120 6:09:56 PM",
                        "contentSummary": "<p>Nothing says &lsquo;Family Film&rsquo; quite like an adaption of a young adult novel. And if you&rsquo;re looking for action, adventure, and a whole lot of spunk, Enola Holmes is just what you need to watch.</p>",
                        "tags": "editor's choice,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/2B0859DD-2C6A-4731-A9DD-840ED71F0E03.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Movie-Review-Enola-Holmes-96.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    }
                ],
                "editorChoice": [
                    {
                        "contentId": 132,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "The Birds And The Bees: An Age-Wise Guide For Parents",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 7:50:00 AM",
                        "validUpTo": "11/4/2120 7:50:00 AM",
                        "contentSummary": "<p>We bring you expert advice on appropriate topics to cover when you talk to your child about sex. Here&rsquo;s our age-wise guide.&nbsp; &nbsp;&nbsp;</p>",
                        "tags": "today's top picks,editor's choice,home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/14C7A4B7-DB54-4668-814B-4EFB69DD186C.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/The-Birds-And-The-Bees-An-AgeWise-Guide-For-Parents-132.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 180,
                        "contentTypeId": 5,
                        "categoryId": 8,
                        "titleHeader": "Feminism is for all",
                        "author": "Saumya",
                        "validFrom": "11/26/2020 7:05:57 AM",
                        "validUpTo": "11/26/2120 7:05:57 AM",
                        "contentSummary": "<p>This is a test.&nbsp;</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0B284858-4FD2-4ACE-8976-516106EA8F7D.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Feminism-is-for-all-180.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 179,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Feminist books",
                        "author": "Saumya",
                        "validFrom": "11/26/2020 12:31:42 PM",
                        "validUpTo": "11/26/2120 12:31:42 PM",
                        "contentSummary": "<h1>Test Test TEst&nbsp;</h1>\r\n<p>bdjsbdj</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0DFAACB4-1F01-4EAE-9742-5DA89E532C3D.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Feminist-books-179.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 177,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "Mirror Styling Tips To Amplify Your Home D&eacute;cor",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/26/2020 12:15:30 PM",
                        "validUpTo": "11/26/2120 12:15:30 PM",
                        "contentSummary": "<p>Here are some mirror styling tips to amplify your home d&eacute;cor across different spaces</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C043336D-A36E-4873-8CC4-55C9A1492E5A.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/Mirror-Styling-Tips-To-Amplify-Your-Home-Dcor-177.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 174,
                        "contentTypeId": 5,
                        "categoryId": 6,
                        "titleHeader": "test",
                        "author": "Karishma",
                        "validFrom": "11/26/2020 11:47:53 AM",
                        "validUpTo": "11/26/2120 11:47:53 AM",
                        "contentSummary": "<p>test</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/A6AD62E6-689C-42A5-93ED-1E285E3B16D8.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/test-174.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 173,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "test",
                        "author": "Karishma",
                        "validFrom": "11/26/2020 11:43:33 AM",
                        "validUpTo": "11/26/2120 11:43:33 AM",
                        "contentSummary": "<p>Test test</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/EECD5186-B60D-41F6-B6CC-C323C5C80412.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/test-173.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 170,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Check Out These Shows For Your Weekend Binge Watch",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/25/2020 10:46:10 AM",
                        "validUpTo": "11/25/2120 10:46:10 AM",
                        "contentSummary": "<p>Here&rsquo;s a complied list of our recommendations you can binge watch this weekend.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C4A30473-0DB2-4582-8EFC-931EE6E0FB83.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Check-Out-These-Shows-For-Your-Weekend-Binge-Watch-170.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 160,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "The Best Self-Care Practice For You, As Per Your Zodiac",
                        "author": "Avnish Kumar",
                        "validFrom": "11/13/2020 10:00:58 PM",
                        "validUpTo": "11/13/2120 10:00:58 PM",
                        "contentSummary": "<p><span lang=\"EN-IN\" style=\"font-size: 11.0pt; line-height: 107%; font-family: 'Calibri',sans-serif; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-IN; mso-fareast-language: EN-US; mso-bidi-language: AR-SA;\">Undoubtedly, self-care is for everyone, but what de-stresses each individual is different</span></p>",
                        "tags": "editor's choice,home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C9311463-49E2-4C2A-B6A3-BD37957C1208.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/The-Best-SelfCare-Practice-For-You-As-Per-Your-Zodiac-160.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 137,
                        "contentTypeId": 2,
                        "categoryId": 3,
                        "titleHeader": "Masterclass with Celebrity Makeup Artist Shaan Mu",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 7:38:09 PM",
                        "validUpTo": "11/4/2120 7:38:09 PM",
                        "contentSummary": "<p>mental wellbeing, beauty, makeup, celebrity makeup, step by step mental wellbeing, beauty, makeup, celebrity makeup, step by stepmental wellbeing, beauty, makeup, celebrity makeup, step by stepmental wellbeing, beauty, makeup, celebrity makeup, step by step</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CF043E79-0C69-41B6-B8FB-4D94E5FA908A.JPG",
                        "mediaURL": "http://10.161.47.136:9090/media/MasterClassFinalShaan20201111121414/MasterClassFinalShaan20201111121414masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Masterclass-with-Celebrity-Makeup-Artist-Shaan-Mu-137.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 135,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "6 delicious protein smoothies to try RN!",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/4/2020 2:18:29 PM",
                        "validUpTo": "11/4/2120 2:18:29 PM",
                        "contentSummary": "<p>They not only are delicious but help a great deal in providing the right nourishment to your body on a daily basis.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/94B92162-F9EB-43C9-B9B5-7FD305A09802.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/6-delicious-protein-smoothies-to-try-RN-135.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 131,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "How To Talk To Your Child About The Birds And The Bees",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 1:12:56 PM",
                        "validUpTo": "11/4/2120 1:12:56 PM",
                        "contentSummary": "<p>It&rsquo;s been well documented that sex education makes for a powerful tool when it comes to awareness and sexual health. The question remains, when should the education begin, and how to go about it.&nbsp;</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/9651BF51-581F-45E5-B8EA-3CB428B720B5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/How-To-Talk-To-Your-Child-About-The-Birds-And-The-Bees-131.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 130,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "Here&#39;s Why You Should Talk To Your Child About The Birds And The Bees",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 12:46:58 PM",
                        "validUpTo": "11/4/2120 12:46:58 PM",
                        "contentSummary": "<p>Children should be able, and more importantly, feel comfortable enough to talk to their parents about anything, particularly sex. Besides, you want then to learn the right way, don&rsquo;t you? Which is why it&rsquo;s important that sex education begins at home. We tell you why.&nbsp;</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/29A03DEC-F8D8-43DB-8E13-51A08094F8C6.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/Heres-Why-You-Should-Talk-To-Your-Child-About-The-Birds-And-The-Bees-130.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 128,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "How To Reduce Anxiety Attacks -1",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/3/2020 2:09:55 PM",
                        "validUpTo": "11/3/2120 2:09:55 PM",
                        "contentSummary": "<p>Anxiety attacks can be unpredictable. Here are few ways to tackle them.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/23C6D635-902C-486B-A520-254C2099750A.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/How-To-Reduce-Anxiety-Attacks-1-128.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 127,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "test article",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/3/2020 2:03:41 PM",
                        "validUpTo": "11/3/2120 2:03:41 PM",
                        "contentSummary": "<p>Anxiety attacks can be unpredictable. Here are few ways to tackle them.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/29A1C5D5-D3A9-4F3B-B583-B5EC0C7486D5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/test-article-127.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 125,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "How To Reduce Anxiety Attacks",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/3/2020 1:19:32 PM",
                        "validUpTo": "11/3/2120 1:19:32 PM",
                        "contentSummary": "<p>Anxiety attacks can be unpredictable. Here are few ways to tackle them.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CC0B2628-0FC7-4872-BE8D-90854ED58D84.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/How-To-Reduce-Anxiety-Attacks-125.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 124,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "5 Activities To Do During A Major Power Outage",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/3/2020 11:34:09 AM",
                        "validUpTo": "11/3/2120 11:34:09 AM",
                        "contentSummary": "<p>Are you so reliant on technology and your devices that you don&rsquo;t know what to do if there&rsquo;s a power outage, and you&rsquo;ve lost that essential WiFi? Here are some fun ways to keep your mind occupied if there&rsquo;s a major power cut in your neighbourhood, or city.</p>",
                        "tags": "editor's choice,home lead story,today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/83BD5CA6-516A-4B91-99B5-9DA323BFA8B2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-Activities-To-Do-During-A-Major-Power-Outage-124.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 119,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "5 Signs Your Child Is Being Bullied",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/2/2020 4:51:14 PM",
                        "validUpTo": "11/2/2120 4:51:14 PM",
                        "contentSummary": "<p>Sometimes, they may not know how to express themselves, but when you notice subtle changes in your child, you might want to investigate. Here are signs your child is being bullied.</p>",
                        "tags": "editor's choice,home lead story,today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/3E5D6340-12E6-442E-801D-BD9D35D0BBB0.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/5-Signs-Your-Child-Is-Being-Bullied-119.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 115,
                        "contentTypeId": 5,
                        "categoryId": 2,
                        "titleHeader": "Trendy Fabrics That Dominated 2020",
                        "author": "Swathi Mohandas",
                        "validFrom": "10/30/2020 4:36:24 PM",
                        "validUpTo": "10/30/2120 4:36:24 PM",
                        "contentSummary": "<p>A fabric can make or break the outfit. Let&rsquo;s look at the catch up with the most loved fabrics of 2020!</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/1A61E2FB-CBED-4DD7-B2D0-18F99A996EC5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/fashion-and-sustainability/fitness/Trendy-Fabrics-That-Dominated-2020-115.html",
                        "categoryName": "Fashion-and-Sustainability",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 114,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "5 Effective Home Remedies For Grey Hair",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/30/2020 4:20:21 PM",
                        "validUpTo": "10/30/2120 4:20:21 PM",
                        "contentSummary": "<p>Are you looking for some natural, but effective ways to deal with those greys? Here are five home remedies you can try.</p>",
                        "tags": "editor's choice,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/EBED2A73-0A96-4843-AAD9-520CA5B4C8D2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/5-Effective-Home-Remedies-For-Grey-Hair-114.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 113,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Home Remedies For Morning Sickness",
                        "author": "Nikshubha Garg",
                        "validFrom": "10/30/2020 4:14:44 PM",
                        "validUpTo": "10/30/2120 4:14:44 PM",
                        "contentSummary": "<p class=\"MsoNormal\"><span lang=\"EN-US\" style=\"font-size: 11.0pt; mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-US;\">Here are ways through which you can alleviate symptoms of morning sickness</span></p>",
                        "tags": "editor's choice,MorningSickness",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/A9758A98-E8A2-4AE8-86EA-3E31FA80B310.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Home-Remedies-For-Morning-Sickness-113.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 106,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "We Recommend: Add These 5 Must-Read Thrillers To Your Book Shelf",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/30/2020 1:14:52 PM",
                        "validUpTo": "10/30/2120 1:14:52 PM",
                        "contentSummary": "<p>If you&rsquo;re looking for a whole new way to keep your mind engaged, we recommend some great reading material. And if you&rsquo;re a fan of mysteries and thrillers, here&rsquo;s five of our must-read titles to add to your book shelf.</p>",
                        "tags": "editor's choice,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/4F66C2A0-90FB-40FE-AC2D-F89DCBF54C84.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/We-Recommend-Add-These-5-MustRead-Thrillers-To-Your-Book-Shelf-106.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 104,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Be More",
                        "author": "sushil",
                        "validFrom": "10/29/2020 8:38:12 PM",
                        "validUpTo": "10/29/2120 8:38:12 PM",
                        "contentSummary": "<p>collect small,Make it large</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8BB78C2C-B351-4786-A237-133E55A4409E.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Be-More-104.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 102,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "15 Important Investment Terms You Should Know About",
                        "author": "sushil",
                        "validFrom": "10/29/2020 7:37:56 PM",
                        "validUpTo": "10/29/2120 7:37:56 PM",
                        "contentSummary": "<p><span style=\"font-size: 11.0pt; font-family: 'Calibri',sans-serif; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA;\">Familiarise yourself with important investment terms before your dive in&nbsp;</span></p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8036690D-4F2C-40D1-B286-D80EE5B4033C.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/15-Important-Investment-Terms-You-Should-Know-About-102.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 96,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Movie Review: Enola Holmes",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/29/2020 6:09:56 PM",
                        "validUpTo": "10/29/2120 6:09:56 PM",
                        "contentSummary": "<p>Nothing says &lsquo;Family Film&rsquo; quite like an adaption of a young adult novel. And if you&rsquo;re looking for action, adventure, and a whole lot of spunk, Enola Holmes is just what you need to watch.</p>",
                        "tags": "editor's choice,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/2B0859DD-2C6A-4731-A9DD-840ED71F0E03.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Movie-Review-Enola-Holmes-96.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 95,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Our first story together",
                        "author": "Avnish Kumar",
                        "validFrom": "10/28/2020 9:23:51 PM",
                        "validUpTo": "10/28/2120 9:23:51 PM",
                        "contentSummary": "<p>This is wonderful.</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0776FC06-2480-42BF-A618-7D58C16C0033.PNG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-korean-dramas-that-are-all-the-rage-2.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    }
                ],
                "todaysTop": [
                    {
                        "contentId": 132,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "The Birds And The Bees: An Age-Wise Guide For Parents",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 7:50:00 AM",
                        "validUpTo": "11/4/2120 7:50:00 AM",
                        "contentSummary": "<p>We bring you expert advice on appropriate topics to cover when you talk to your child about sex. Here&rsquo;s our age-wise guide.&nbsp; &nbsp;&nbsp;</p>",
                        "tags": "today's top picks,editor's choice,home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/14C7A4B7-DB54-4668-814B-4EFB69DD186C.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/The-Birds-And-The-Bees-An-AgeWise-Guide-For-Parents-132.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 149,
                        "contentTypeId": 1,
                        "categoryId": 5,
                        "titleHeader": "&quot;Sometimes, an achievement is all it takes for you to take opportunities seriously.&quot; - Aruna Reddy Dummy",
                        "author": "Jhumur &quot;Ganguly&quot;",
                        "validFrom": "11/12/2020 8:02:07 PM",
                        "validUpTo": "11/12/2120 8:02:07 PM",
                        "contentSummary": "<p>When eight-year-old Aruna Reddy and her father B Narayana Reddy made their way to Lal Bahadur Stadium, Hyderabad</p>",
                        "tags": "today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/get-inspired/fitness/Sometimes-an-achievement-is-all-it-takes-for-you-to-take-opportunities-seriously-Aruna-Reddy-Dummy-149.html",
                        "categoryName": "Get-Inspired",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 131,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "How To Talk To Your Child About The Birds And The Bees",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 1:12:56 PM",
                        "validUpTo": "11/4/2120 1:12:56 PM",
                        "contentSummary": "<p>It&rsquo;s been well documented that sex education makes for a powerful tool when it comes to awareness and sexual health. The question remains, when should the education begin, and how to go about it.&nbsp;</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/9651BF51-581F-45E5-B8EA-3CB428B720B5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/How-To-Talk-To-Your-Child-About-The-Birds-And-The-Bees-131.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 130,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "Here&#39;s Why You Should Talk To Your Child About The Birds And The Bees",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 12:46:58 PM",
                        "validUpTo": "11/4/2120 12:46:58 PM",
                        "contentSummary": "<p>Children should be able, and more importantly, feel comfortable enough to talk to their parents about anything, particularly sex. Besides, you want then to learn the right way, don&rsquo;t you? Which is why it&rsquo;s important that sex education begins at home. We tell you why.&nbsp;</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/29A03DEC-F8D8-43DB-8E13-51A08094F8C6.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/Heres-Why-You-Should-Talk-To-Your-Child-About-The-Birds-And-The-Bees-130.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 124,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "5 Activities To Do During A Major Power Outage",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/3/2020 11:34:09 AM",
                        "validUpTo": "11/3/2120 11:34:09 AM",
                        "contentSummary": "<p>Are you so reliant on technology and your devices that you don&rsquo;t know what to do if there&rsquo;s a power outage, and you&rsquo;ve lost that essential WiFi? Here are some fun ways to keep your mind occupied if there&rsquo;s a major power cut in your neighbourhood, or city.</p>",
                        "tags": "editor's choice,home lead story,today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/83BD5CA6-516A-4B91-99B5-9DA323BFA8B2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-Activities-To-Do-During-A-Major-Power-Outage-124.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 119,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "5 Signs Your Child Is Being Bullied",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/2/2020 4:51:14 PM",
                        "validUpTo": "11/2/2120 4:51:14 PM",
                        "contentSummary": "<p>Sometimes, they may not know how to express themselves, but when you notice subtle changes in your child, you might want to investigate. Here are signs your child is being bullied.</p>",
                        "tags": "editor's choice,home lead story,today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/3E5D6340-12E6-442E-801D-BD9D35D0BBB0.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/5-Signs-Your-Child-Is-Being-Bullied-119.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 116,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Check Out These Shows For Your Weekend Binge Watch",
                        "author": "Sunetra Ghose",
                        "validFrom": "10/30/2020 4:49:16 PM",
                        "validUpTo": "10/30/2120 4:49:16 PM",
                        "contentSummary": "<p>Here&rsquo;s a complied list of our recommendations you can binge watch this weekend</p>",
                        "tags": "today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/11F577BF-34BA-4BF0-8E41-2174DA8AF77F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Check-Out-These-Shows-For-Your-Weekend-Binge-Watch-116.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 114,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "5 Effective Home Remedies For Grey Hair",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/30/2020 4:20:21 PM",
                        "validUpTo": "10/30/2120 4:20:21 PM",
                        "contentSummary": "<p>Are you looking for some natural, but effective ways to deal with those greys? Here are five home remedies you can try.</p>",
                        "tags": "editor's choice,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/EBED2A73-0A96-4843-AAD9-520CA5B4C8D2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/5-Effective-Home-Remedies-For-Grey-Hair-114.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 112,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "5 Ideas To Upcycle Home D&eacute;cor And Transform Your Space",
                        "author": "Sunetra Ghose",
                        "validFrom": "10/30/2020 4:10:55 PM",
                        "validUpTo": "10/30/2120 4:10:55 PM",
                        "contentSummary": "<p>What if you could give your home a makeover with a few tweaks to d&eacute;cor you already have around your home? Here are five ways to upcycle and transform your space</p>",
                        "tags": "today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0EA621D1-77F9-4AB8-8E0C-D45F5A62649A.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/5-Ideas-To-Upcycle-Home-Dcor-And-Transform-Your-Space-112.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 106,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "We Recommend: Add These 5 Must-Read Thrillers To Your Book Shelf",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/30/2020 1:14:52 PM",
                        "validUpTo": "10/30/2120 1:14:52 PM",
                        "contentSummary": "<p>If you&rsquo;re looking for a whole new way to keep your mind engaged, we recommend some great reading material. And if you&rsquo;re a fan of mysteries and thrillers, here&rsquo;s five of our must-read titles to add to your book shelf.</p>",
                        "tags": "editor's choice,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/4F66C2A0-90FB-40FE-AC2D-F89DCBF54C84.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/We-Recommend-Add-These-5-MustRead-Thrillers-To-Your-Book-Shelf-106.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 103,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "15 Important Investment Terms You Should Know About",
                        "author": "Nikshubha Garg",
                        "validFrom": "10/29/2020 7:51:10 PM",
                        "validUpTo": "10/29/2120 7:51:10 PM",
                        "contentSummary": "<p>Familiarise yourself with important investment terms before your dive in&nbsp;</p>",
                        "tags": "today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8304417A-2406-44A3-A4D6-CAD83C46A412.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/15-Important-Investment-Terms-You-Should-Know-About-103.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 95,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Our first story together",
                        "author": "Avnish Kumar",
                        "validFrom": "10/28/2020 9:23:51 PM",
                        "validUpTo": "10/28/2120 9:23:51 PM",
                        "contentSummary": "<p>This is wonderful.</p>",
                        "tags": "editor's choice,home lead story,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0776FC06-2480-42BF-A618-7D58C16C0033.PNG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-korean-dramas-that-are-all-the-rage-2.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    }
                ],
                "creativeCornor": [
                    {
                        "contentId": 190,
                        "contentTypeId": 7,
                        "categoryId": 1,
                        "titleHeader": "The right way of doing Yoga",
                        "author": "Shrutika Parab",
                        "validFrom": "1/14/2021 4:07:22 PM",
                        "validUpTo": "1/14/2121 4:07:22 PM",
                        "contentSummary": "<p>This is the actual and right way of doing SuryaNamaskar.</p>",
                        "tags": "",
                        "publishedFor": "Grow",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/3326BACE-0847-4026-A82F-7B57FCB7BC01.JPG",
                        "mediaURL": "https://media.hercircle.in/media/SuryaNamaskar 620201104184200/SuryaNamaskar 620201104184200masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/The-right-way-of-doing-Yoga-190.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    }
                ],
                "engageVideo": [
                    {
                        "contentId": 142,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "Is this video working",
                        "author": "Jhumur Ganguly",
                        "validFrom": "4/30/2021 10:45:19 PM",
                        "validUpTo": "11/9/2120 10:54:18 AM",
                        "contentSummary": "<p>Please Work</p>",
                        "tags": "Exercise,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/2DD06F0D-4F3B-4F5B-87F4-DA9661159581.PNG",
                        "mediaURL": "https://media-sit.jio.com/media/TestVideo100/TestVideo100masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Is-this-video-working-142.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 189,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "Roti Making",
                        "author": "Sushil Bhat",
                        "validFrom": "1/14/2021 4:00:59 PM",
                        "validUpTo": "1/14/2121 4:00:59 PM",
                        "contentSummary": "<p>The efficient way of making Roti.</p>",
                        "tags": "home lead story",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CFAC76FC-CB78-411D-A05D-F94BBEBF72DE.JPG",
                        "mediaURL": "https://media.hercircle.in/media/newRotiMaking20201111115824/newRotiMaking20201111115824masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Roti-Making-189.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 163,
                        "contentTypeId": 2,
                        "categoryId": 6,
                        "titleHeader": "Second Attempt Series Dummy Riya : Making A Roti For The Second Time",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/17/2020 5:31:19 PM",
                        "validUpTo": "11/17/2120 5:31:19 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C600AA2F-7C49-4C5D-A72E-E80954F195F9.JPG",
                        "mediaURL": "https://media-sit.jio.com/media/newRotiMaking20201110220831/newRotiMaking20201110220831masterplaylist.m3u8&#9;https://media-sit.jio.com/media/newRotiMaking20201110220831/images/newRotiMaking20201110220831_thumbnail.jpg",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/Second-Attempt-Series-Dummy-Riya-Making-A-Roti-For-The-Second-Time-163.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 162,
                        "contentTypeId": 2,
                        "categoryId": 6,
                        "titleHeader": "First Attempt Series Dummy Riya : Making A Roti For The Very First Time",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/17/2020 5:25:01 PM",
                        "validUpTo": "11/17/2120 5:25:01 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F2731D80-32DD-4E16-992C-A04F4052349A.JPG",
                        "mediaURL": "https://devhercircle.jio.com/admin/cms_loginform.aspx",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/First-Attempt-Series-Dummy-Riya-Making-A-Roti-For-The-Very-First-Time-162.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 157,
                        "contentTypeId": 2,
                        "categoryId": 5,
                        "titleHeader": "nature video",
                        "author": "VG",
                        "validFrom": "11/13/2020 3:44:14 PM",
                        "validUpTo": "11/13/2120 3:44:14 PM",
                        "contentSummary": "<p>natrue video</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F559D944-6D0A-4752-94A8-7199B932F989.PNG",
                        "mediaURL": "https://media.hercircle.in/media/SuryaNamaskar 620201104184200/SuryaNamaskar 620201104184200masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/get-inspired/fitness/nature-video-157.html",
                        "categoryName": "Get-Inspired",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 145,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "Bulb second attempt - dummy",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/10/2020 9:43:39 PM",
                        "validUpTo": "11/10/2120 9:43:39 PM",
                        "contentSummary": "<p>Bulb second attempt dummy Bulb second attempt dummy Bulb second attempt dummy</p>",
                        "tags": "Exercise",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/B4F7AEA7-864A-4F10-AD64-EC9902A87206.JPG",
                        "mediaURL": "https://media.hercircle.in/media/newRotiMaking20201111115824/newRotiMaking20201111115824masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Bulb-second-attempt-dummy-145.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 144,
                        "contentTypeId": 2,
                        "categoryId": 3,
                        "titleHeader": "Video Story",
                        "author": "Jhumur Ganguly",
                        "validFrom": "11/10/2020 8:55:49 PM",
                        "validUpTo": "11/10/2120 8:55:49 PM",
                        "contentSummary": "<p>Test Video</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/98E718F1-08B9-411A-BB6B-4DAB522C94B2.JPG",
                        "mediaURL": "https://media-sit.jio.com/media/BeginnersMakeup_HerCircle20200902180829/BeginnersMakeup_HerCircle20200902180829masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Video-Story-144.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 143,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "Changing bulb - first attempt",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/10/2020 5:46:20 PM",
                        "validUpTo": "11/10/2120 5:46:20 PM",
                        "contentSummary": "<p>This is dummy copy please dont read</p>",
                        "tags": "Exercise",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F7623A71-8908-433E-9119-ED73A55A1AAD.JPG",
                        "mediaURL": "https://media-sit.jio.com/media/LightBulb 20201110172056/LightBulb 20201110172056masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Changing-bulb-first-attempt-143.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 141,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "First ever roti making",
                        "author": "Riya Sabbarwal",
                        "validFrom": "11/6/2020 2:23:49 PM",
                        "validUpTo": "11/6/2120 2:23:49 PM",
                        "contentSummary": "<p>First ever roti making exoerience this is dummy copy First ever roti making exoerience this is dummy copy First ever roti making exoerience this is dummy copy</p>",
                        "tags": "EatHeathy",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/A086D086-F1D0-4894-9C12-5789D1428EE8.JPG",
                        "mediaURL": "http://10.161.47.136:9090/media/newRotiMaking20201110220831/newRotiMaking20201110220831masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/First-ever-roti-making-141.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 137,
                        "contentTypeId": 2,
                        "categoryId": 3,
                        "titleHeader": "Masterclass with Celebrity Makeup Artist Shaan Mu",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 7:38:09 PM",
                        "validUpTo": "11/4/2120 7:38:09 PM",
                        "contentSummary": "<p>mental wellbeing, beauty, makeup, celebrity makeup, step by step mental wellbeing, beauty, makeup, celebrity makeup, step by stepmental wellbeing, beauty, makeup, celebrity makeup, step by stepmental wellbeing, beauty, makeup, celebrity makeup, step by step</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CF043E79-0C69-41B6-B8FB-4D94E5FA908A.JPG",
                        "mediaURL": "http://10.161.47.136:9090/media/MasterClassFinalShaan20201111121414/MasterClassFinalShaan20201111121414masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Masterclass-with-Celebrity-Makeup-Artist-Shaan-Mu-137.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 136,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "First attempt at doing a surya namaskar",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/4/2020 7:16:57 PM",
                        "validUpTo": "11/4/2120 7:16:57 PM",
                        "contentSummary": "<p>This is dummy copy please do not read this. This is dummy copy please do not read this. This is dummy copy please do not read this.&nbsp;</p>",
                        "tags": "Exercise",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F7E74441-CCC9-4918-8364-C9E606523418.JPG",
                        "mediaURL": "http://10.161.47.136:9090/media/SuryaNamaskar 620201106140310/SuryaNamaskar 620201106140310masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/First-attempt-at-doing-a-surya-namaskar-136.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 120,
                        "contentTypeId": 2,
                        "categoryId": 7,
                        "titleHeader": "Microservices in a fun way",
                        "author": "Avnish Kumar",
                        "validFrom": "11/2/2020 9:12:21 PM",
                        "validUpTo": "11/2/2120 9:12:21 PM",
                        "contentSummary": "<p>Learn microservices in a fun and entertaining way</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/D94CA64B-D7F7-4A80-9AB3-396C6340BE57.JPEG",
                        "mediaURL": "https://media-sit.jio.com/media/TestVideo100/TestVideo100masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/Microservices-in-a-fun-way-120.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    }
                ],
                "infiniteStory": [
                    {
                        "contentId": 142,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "Is this video working",
                        "author": "Jhumur Ganguly",
                        "validFrom": "4/30/2021 10:45:19 PM",
                        "validUpTo": "11/9/2120 10:54:18 AM",
                        "contentSummary": "<p>Please Work</p>",
                        "tags": "Exercise,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/2DD06F0D-4F3B-4F5B-87F4-DA9661159581.PNG",
                        "mediaURL": "https://media-sit.jio.com/media/TestVideo100/TestVideo100masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Is-this-video-working-142.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 149,
                        "contentTypeId": 1,
                        "categoryId": 5,
                        "titleHeader": "&quot;Sometimes, an achievement is all it takes for you to take opportunities seriously.&quot; - Aruna Reddy Dummy",
                        "author": "Jhumur &quot;Ganguly&quot;",
                        "validFrom": "11/12/2020 8:02:07 PM",
                        "validUpTo": "11/12/2120 8:02:07 PM",
                        "contentSummary": "<p>When eight-year-old Aruna Reddy and her father B Narayana Reddy made their way to Lal Bahadur Stadium, Hyderabad</p>",
                        "tags": "today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/get-inspired/fitness/Sometimes-an-achievement-is-all-it-takes-for-you-to-take-opportunities-seriously-Aruna-Reddy-Dummy-149.html",
                        "categoryName": "Get-Inspired",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 240,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "study",
                        "author": "pandurang chopade",
                        "validFrom": "6/25/2021 4:35:07 PM",
                        "validUpTo": "7/21/2021 4:35:00 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/37C75377-A09B-4D44-83B6-7F93DADFB17F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/career/study-240.html",
                        "categoryName": "Work",
                        "subCategoryName": "Career"
                    },
                    {
                        "contentId": 239,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Just a story",
                        "author": "Avnish",
                        "validFrom": "5/4/2021 5:58:09 PM",
                        "validUpTo": "5/4/2121 5:58:09 PM",
                        "contentSummary": "<p>Just a story summary</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/BE9468E8-EC82-4845-A905-3AE952FCC692.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/mental-wellbeing/Just-a-storyy-239.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Mental-Wellbeing"
                    },
                    {
                        "contentId": 238,
                        "contentTypeId": 1,
                        "categoryId": 17,
                        "titleHeader": "Great story of a human being",
                        "author": "Avnish",
                        "validFrom": "4/26/2021 9:34:03 AM",
                        "validUpTo": "4/26/2121 9:34:03 AM",
                        "contentSummary": "<p>Great sumary for a human being!!!</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CB8080E3-C1AC-4B4F-B4AA-F60CC812D480.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/food/diy/Great-story-of-a-human-being-238.html",
                        "categoryName": "Food",
                        "subCategoryName": "DIY"
                    },
                    {
                        "contentId": 237,
                        "contentTypeId": 1,
                        "categoryId": 17,
                        "titleHeader": "Benefits of WFH Now",
                        "author": "Avnish Kumar",
                        "validFrom": "5/3/2021 2:30:00 AM",
                        "validUpTo": "4/13/2121 12:33:50 PM",
                        "contentSummary": "<p>Cool summary!!!</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F8576231-BD4D-4D69-A4A1-2F729A9A6144.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/food/how-tos/Benefits-of-WFH-Now-237.html",
                        "categoryName": "Food",
                        "subCategoryName": "How-Tos"
                    },
                    {
                        "contentId": 236,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "The benefits of Surya Namaskar",
                        "author": "Avnish Kumar",
                        "validFrom": "4/8/2021 1:45:00 PM",
                        "validUpTo": "4/8/2121 2:30:53 AM",
                        "contentSummary": "<p>The benefits of Surya Namaskar.</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/57E3F9B0-A57B-47E2-B9EA-A6B73A82CD02.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Benefits-of-Surya-Namaskar.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 235,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Inspirational",
                        "author": "Avnish",
                        "validFrom": "4/7/2021 10:54:09 PM",
                        "validUpTo": "4/7/2121 10:54:09 PM",
                        "contentSummary": "<p>Cool summary.Cool summary.Cool summary.Cool summary.</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/815CD28D-4251-4B2D-BD91-FF041D7FF12F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/inspirational-article-lovely-article-235.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 234,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Beauty",
                        "author": "Sudhir",
                        "validFrom": "4/8/2021 1:40:50 AM",
                        "validUpTo": "4/8/2121 1:40:50 AM",
                        "contentSummary": "<p>this is summary for url test</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/93EE1551-D38A-4948-8C57-ACCE25CC1E3B.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Beauty-234.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 233,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Strengthening Women To Empower      Themselves Through Mission Shakti",
                        "author": "Sudhir Kumar",
                        "validFrom": "4/7/2021 7:41:48 AM",
                        "validUpTo": "4/7/2121 7:41:48 AM",
                        "contentSummary": "<p><span style=\"box-sizing: border-box; font-weight: bold; color: #111111; font-family: proxima-regular1; font-size: 17px; text-align: justify;\"><em style=\"box-sizing: border-box;\">Every strong woman can help make another stronger, especially with the support of the state government</em></span></p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/806C819A-B543-499C-8F8E-122E6CE7021B.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Strengthening-Women-To-Empower-Themselves-Through-Mission-Shakti-233.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 232,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "Nice articles",
                        "author": "Trisha Bharti",
                        "validFrom": "4/6/2021 11:13:27 AM",
                        "validUpTo": "4/6/2121 11:13:27 AM",
                        "contentSummary": "<p>Nice summary&nbsp;</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/FB195204-1911-4C31-84B8-ADE04B038AAC.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Nice-articles-232.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 231,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "this is nice articles",
                        "author": "Veena Bharti",
                        "validFrom": "4/6/2021 10:49:46 AM",
                        "validUpTo": "4/6/2121 10:49:46 AM",
                        "contentSummary": "<p>this is nice summary&nbsp;</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/5904FE36-ADED-4C63-851E-177D43303A48.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/this-is-nice-articles-231.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 230,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "Wonderfull Title",
                        "author": "Sudhir Roy",
                        "validFrom": "4/6/2021 5:38:35 AM",
                        "validUpTo": "4/6/2121 5:38:35 AM",
                        "contentSummary": "<p>Wonderfull summary</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C6527817-9A82-4642-8E63-9750495D056C.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Wonderfull-Title-230.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 229,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Wonderful City",
                        "author": "Avnish",
                        "validFrom": "4/5/2021 11:58:14 AM",
                        "validUpTo": "4/5/2121 11:58:14 AM",
                        "contentSummary": "<p>Beautiful summary</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0C80C185-11CD-4867-A6F6-AB67E375264D.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Wonderful-City-229.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 228,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "title test",
                        "author": "Yogesh",
                        "validFrom": "4/2/2021 1:12:28 PM",
                        "validUpTo": "4/2/2121 1:12:28 PM",
                        "contentSummary": "<p>Create summary by Yogesh</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/49F52123-4625-446A-AC36-E28F2FA2C390.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/title-test-228.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 227,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Beauty",
                        "author": "Gourge",
                        "validFrom": "4/2/2021 12:54:54 PM",
                        "validUpTo": "4/2/2121 12:54:54 PM",
                        "contentSummary": "<p>this is summey for engage</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/82A76B26-41DA-4804-98FE-D15A3830E5CF.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Beauty-227.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 226,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "Beauty &amp; Health",
                        "author": "Trisha Bharti",
                        "validFrom": "4/2/2021 5:36:33 AM",
                        "validUpTo": "4/2/2121 5:36:33 AM",
                        "contentSummary": "<p>Health is important for everyone</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8F61B388-B1A0-4B5E-B821-803EE80A959E.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Beauty-Health-226.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 225,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "this is engage articles",
                        "author": "Veena Bharti",
                        "validFrom": "4/1/2021 3:22:27 PM",
                        "validUpTo": "4/1/2121 3:22:27 PM",
                        "contentSummary": "<p>this is engage summary&nbsp;</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F990AAC0-6DCE-4A78-8E7A-F3F504790DA9.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/this-is-engage-articles-225.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 224,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "Test Title",
                        "author": "sudhir",
                        "validFrom": "4/1/2021 9:53:03 AM",
                        "validUpTo": "4/1/2121 9:53:03 AM",
                        "contentSummary": "<p>Hi summary</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/823CB2B0-4158-413D-87D1-F117CFAC20D5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Test-Title-224.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 223,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "This is title",
                        "author": "Sudhir Raj",
                        "validFrom": "4/1/2021 4:30:39 AM",
                        "validUpTo": "4/1/2121 4:30:39 AM",
                        "contentSummary": "<p>this is summary</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/E5D454D7-4A90-49AD-ACA0-4636CECED86D.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/This-is-title-223.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 222,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Beauty",
                        "author": "SK",
                        "validFrom": "3/26/2021 6:27:32 AM",
                        "validUpTo": "3/26/2121 6:27:32 AM",
                        "contentSummary": "<p>summary11</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/78BEC7CB-8F87-4202-9950-9E8277F30267.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Beauty-222.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 221,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "helth",
                        "author": "sudhir",
                        "validFrom": "3/25/2021 2:45:03 PM",
                        "validUpTo": "3/25/2121 2:45:03 PM",
                        "contentSummary": "<p>this is summary</p>",
                        "tags": "Fertility",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/1D613442-DF1C-479E-B509-F290602B4A6E.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/helth-221.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 220,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "I want rain",
                        "author": "Shrutika",
                        "validFrom": "3/15/2021 2:24:00 AM",
                        "validUpTo": "3/15/2121 2:24:00 AM",
                        "contentSummary": "<p>Great summary for frogs</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/E32BA78E-AEEC-4493-B823-CC2E2216F4CA.GIF",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/I-want-rain-220.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 219,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "Cool VIsual Story",
                        "author": "Avnish Kumar",
                        "validFrom": "3/2/2021 3:51:19 AM",
                        "validUpTo": "3/2/2121 3:51:19 AM",
                        "contentSummary": "<p>cool summary!!!!!!!!!</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/A619D277-8F41-4AB7-9CBF-C234EDD9D436.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Cool-VIsual-Story-219.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 218,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Cool Story!!!",
                        "author": "Avnish Kumar",
                        "validFrom": "3/1/2021 7:55:16 AM",
                        "validUpTo": "3/1/2121 7:55:16 AM",
                        "contentSummary": "<p>Cool summary!!!</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/45301F1E-208A-4188-9004-3F2450C589AB.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Cool-Story-218.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 217,
                        "contentTypeId": 1,
                        "categoryId": 2,
                        "titleHeader": "Wow inspirational",
                        "author": "Avnish",
                        "validFrom": "2/26/2021 9:56:39 AM",
                        "validUpTo": "2/26/2121 9:56:39 AM",
                        "contentSummary": "<p>Inspirational summary</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/E9B92483-4907-45BA-B5EB-0B75925F2153.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/fashion-and-sustainability/fitness/Wow-inspirational-217.html",
                        "categoryName": "Fashion-and-Sustainability",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 216,
                        "contentTypeId": 5,
                        "categoryId": 5,
                        "titleHeader": "love story",
                        "author": "Raj",
                        "validFrom": "2/26/2021 12:58:48 AM",
                        "validUpTo": "2/26/2121 12:58:48 AM",
                        "contentSummary": "<p>gru discription</p>",
                        "tags": "Periodgoals",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8ABBA215-1B7B-4BDB-A1BB-3E1360526BB7.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/get-inspired/fitness/love-story-216.html",
                        "categoryName": "Get-Inspired",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 215,
                        "contentTypeId": 5,
                        "categoryId": 8,
                        "titleHeader": "Nice Story !",
                        "author": "Avnish Kumar",
                        "validFrom": "2/24/2021 7:43:35 PM",
                        "validUpTo": "2/24/2121 7:43:35 PM",
                        "contentSummary": "<p>summery details</p>",
                        "tags": "Fertility",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/2E2157A8-58CA-424F-90D0-52DD79556C9F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Nice-Story-215.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 214,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "Developer",
                        "author": "sudhir",
                        "validFrom": "2/23/2021 2:01:05 PM",
                        "validUpTo": "2/23/2121 2:01:05 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Developer-214.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 213,
                        "contentTypeId": 1,
                        "categoryId": 4,
                        "titleHeader": "teacher",
                        "author": "sudhir",
                        "validFrom": "2/23/2021 7:16:28 PM",
                        "validUpTo": "2/23/2121 7:16:28 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/relationships/fitness/teacher-213.html",
                        "categoryName": "Relationships",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 212,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "teacher",
                        "author": "sudhir kumar",
                        "validFrom": "2/23/2021 7:12:22 PM",
                        "validUpTo": "2/23/2121 7:12:22 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/teacher-212.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 211,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "Developer",
                        "author": "sudhir",
                        "validFrom": "2/23/2021 5:54:57 PM",
                        "validUpTo": "2/23/2121 5:54:57 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Developer-211.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 205,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "Lovely Visual Story",
                        "author": "Avnish",
                        "validFrom": "2/15/2021 3:14:13 PM",
                        "validUpTo": "2/15/2121 3:14:13 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/6B5BC9B4-376F-4C5C-B46B-308DF6B997C3.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Lovely-Visual-Story-205.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 203,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "Lovely Visual Story",
                        "author": "Avnish",
                        "validFrom": "2/15/2021 3:04:32 PM",
                        "validUpTo": "2/15/2121 3:04:32 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0B3840D9-93BD-4438-B00F-7F5CE6D835EF.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Lovely-Visual-Story-203.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 202,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Lovely",
                        "author": "Avnish",
                        "validFrom": "2/15/2021 2:55:22 PM",
                        "validUpTo": "2/15/2121 2:55:22 PM",
                        "contentSummary": "<p>Lovely</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C64C36A3-CF07-4BDE-9E62-818AC53D9778.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Lovely-202.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 195,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Wow hot",
                        "author": "Sushil",
                        "validFrom": "1/25/2021 8:25:39 PM",
                        "validUpTo": "1/25/2121 8:25:39 PM",
                        "contentSummary": "<p>Wow hot summary</p>",
                        "tags": "Banking",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/598A546D-9D2E-4082-AFEE-7C10B396D12F.PNG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Wow-hot-195.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 194,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Wow cool",
                        "author": "Avnish",
                        "validFrom": "1/25/2021 8:24:29 PM",
                        "validUpTo": "1/25/2121 8:24:29 PM",
                        "contentSummary": "<p>Wow cool summary</p>",
                        "tags": "Bonds",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/9541C19B-9747-4C23-B74E-2AAA65EB67D5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Wow-cool-194.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 193,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Wow amazing",
                        "author": "Avnish",
                        "validFrom": "1/25/2021 8:23:26 PM",
                        "validUpTo": "1/25/2121 8:23:26 PM",
                        "contentSummary": "<p>Wow Amazing</p>",
                        "tags": "Contraception",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8EA2DE52-E8F2-4DE3-BECD-1AF30F108FDB.JPEG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Wow-amazing-193.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 188,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "For Sequence of Articles",
                        "author": "Avnish",
                        "validFrom": "1/6/2021 11:26:11 AM",
                        "validUpTo": "1/6/2121 11:26:11 AM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/4D6C71AB-40C3-497E-BCF3-02C67D6BB332.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/For-Sequence-of-Articles-188.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 187,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Just for testing",
                        "author": "Avnish",
                        "validFrom": "1/5/2021 9:17:36 PM",
                        "validUpTo": "1/5/2121 9:17:36 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/B8DBE6EA-3381-40BE-B6FC-0C36658817B9.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Just-for-testing-187.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 185,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "Pre-Launch Article Testing",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/26/2020 1:22:17 PM",
                        "validUpTo": "11/26/2120 1:22:17 PM",
                        "contentSummary": "<p>Pre-Launch Article Testing&nbsp;Pre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article TestingPre-Launch Article&nbsp;</p>",
                        "tags": "EatHeathy,EatRight",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/805D55FF-C7CD-4BB1-B884-EF5827A2EF54.JPEG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/PreLaunch-Article-Testing-185.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 180,
                        "contentTypeId": 5,
                        "categoryId": 8,
                        "titleHeader": "Feminism is for all",
                        "author": "Saumya",
                        "validFrom": "11/26/2020 7:05:57 AM",
                        "validUpTo": "11/26/2120 7:05:57 AM",
                        "contentSummary": "<p>This is a test.&nbsp;</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0B284858-4FD2-4ACE-8976-516106EA8F7D.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Feminism-is-for-all-180.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 179,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Feminist books",
                        "author": "Saumya",
                        "validFrom": "11/26/2020 12:31:42 PM",
                        "validUpTo": "11/26/2120 12:31:42 PM",
                        "contentSummary": "<h1>Test Test TEst&nbsp;</h1>\r\n<p>bdjsbdj</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0DFAACB4-1F01-4EAE-9742-5DA89E532C3D.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Feminist-books-179.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 177,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "Mirror Styling Tips To Amplify Your Home D&eacute;cor",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/26/2020 12:15:30 PM",
                        "validUpTo": "11/26/2120 12:15:30 PM",
                        "contentSummary": "<p>Here are some mirror styling tips to amplify your home d&eacute;cor across different spaces</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C043336D-A36E-4873-8CC4-55C9A1492E5A.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/Mirror-Styling-Tips-To-Amplify-Your-Home-Dcor-177.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 176,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "Mirror Styling Tips To Amplify Your Home D&eacute;cor",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/26/2020 12:15:12 PM",
                        "validUpTo": "11/26/2120 12:15:12 PM",
                        "contentSummary": "<p>Here are some mirror styling tips to amplify your home d&eacute;cor across different spaces</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/4391E199-C2F4-4D0E-AC00-BE17356F51C0.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/Mirror-Styling-Tips-To-Amplify-Your-Home-Dcor-176.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 174,
                        "contentTypeId": 5,
                        "categoryId": 6,
                        "titleHeader": "test",
                        "author": "Karishma",
                        "validFrom": "11/26/2020 11:47:53 AM",
                        "validUpTo": "11/26/2120 11:47:53 AM",
                        "contentSummary": "<p>test</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/A6AD62E6-689C-42A5-93ED-1E285E3B16D8.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/test-174.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 173,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "test",
                        "author": "Karishma",
                        "validFrom": "11/26/2020 11:43:33 AM",
                        "validUpTo": "11/26/2120 11:43:33 AM",
                        "contentSummary": "<p>Test test</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/EECD5186-B60D-41F6-B6CC-C323C5C80412.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/test-173.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 171,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "This is dummy article of Charlene",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/26/2020 11:09:25 AM",
                        "validUpTo": "11/26/2120 11:09:25 AM",
                        "contentSummary": "<p>This is dummy title for Charlene story&nbsp;</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/A524D63F-1B5A-4782-B092-C6E9210BFFF3.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/This-is-dummy-article-of-Charlene-171.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 170,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Check Out These Shows For Your Weekend Binge Watch",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/25/2020 10:46:10 AM",
                        "validUpTo": "11/25/2120 10:46:10 AM",
                        "contentSummary": "<p>Here&rsquo;s a complied list of our recommendations you can binge watch this weekend.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C4A30473-0DB2-4582-8EFC-931EE6E0FB83.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Check-Out-These-Shows-For-Your-Weekend-Binge-Watch-170.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 169,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "7 Types Of Meditation For A Healthy Body And Mind",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/18/2020 1:21:41 PM",
                        "validUpTo": "11/18/2120 1:21:41 PM",
                        "contentSummary": "<p>Meditation is a great way to align your mind and body. Here are seven types of meditation you should know about.</p>",
                        "tags": "Fitness",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/17928F36-34FE-422F-B7CE-EFA3813EDDA2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/7-Types-Of-Meditation-For-A-Healthy-Body-And-Mind-169.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 167,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "What a wonderful story again",
                        "author": "Avnish Kumar",
                        "validFrom": "11/18/2020 1:02:12 PM",
                        "validUpTo": "11/18/2120 1:02:12 PM",
                        "contentSummary": "<p>Wow just amazing</p>",
                        "tags": "top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/06C5B2CA-0E54-4F55-936F-F4B9EAA2C75E.JPEG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/What-a-wonderful-story-again-167.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 166,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "5 Healthy Snacks To Beat Those PMS Cravings",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/18/2020 12:57:51 PM",
                        "validUpTo": "11/18/2120 12:57:51 PM",
                        "contentSummary": "<p>Here are five healthy snacks to help you beat those PMS cravings, and satiate your hunger pangs.</p>",
                        "tags": "EatRight",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/EF9B97DB-78A0-4E1F-9F82-1DCA3B467124.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-Healthy-Snacks-To-Beat-Those-PMS-Cravings-166.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 165,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "5 Feminine Hygiene Products You Should Know About",
                        "author": "Sunetra Ghose",
                        "validFrom": "11/18/2020 12:46:58 PM",
                        "validUpTo": "11/18/2120 12:46:58 PM",
                        "contentSummary": "<p>We recommend five feminine hygiene products you can try for a hassle-free period.</p>",
                        "tags": "Periodgoals",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/DB1DD308-F79D-4C90-B5D7-BE56C4EF234D.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-Feminine-Hygiene-Products-You-Should-Know-About-165.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 164,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "&quot;WoW&quot; HTML Bird&#39;s &amp; Arial View",
                        "author": "Avnish",
                        "validFrom": "11/17/2020 11:03:31 PM",
                        "validUpTo": "11/17/2120 11:03:31 PM",
                        "contentSummary": "<p>Wow wonderful</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/3EAC6680-FCFE-4DB5-8F03-D276EE9F7DFB.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/WoW-HTML-Birds-Arial-View-164.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 163,
                        "contentTypeId": 2,
                        "categoryId": 6,
                        "titleHeader": "Second Attempt Series Dummy Riya : Making A Roti For The Second Time",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/17/2020 5:31:19 PM",
                        "validUpTo": "11/17/2120 5:31:19 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/C600AA2F-7C49-4C5D-A72E-E80954F195F9.JPG",
                        "mediaURL": "https://media-sit.jio.com/media/newRotiMaking20201110220831/newRotiMaking20201110220831masterplaylist.m3u8&#9;https://media-sit.jio.com/media/newRotiMaking20201110220831/images/newRotiMaking20201110220831_thumbnail.jpg",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/Second-Attempt-Series-Dummy-Riya-Making-A-Roti-For-The-Second-Time-163.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 162,
                        "contentTypeId": 2,
                        "categoryId": 6,
                        "titleHeader": "First Attempt Series Dummy Riya : Making A Roti For The Very First Time",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/17/2020 5:25:01 PM",
                        "validUpTo": "11/17/2120 5:25:01 PM",
                        "contentSummary": "",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F2731D80-32DD-4E16-992C-A04F4052349A.JPG",
                        "mediaURL": "https://devhercircle.jio.com/admin/cms_loginform.aspx",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/First-Attempt-Series-Dummy-Riya-Making-A-Roti-For-The-Very-First-Time-162.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 161,
                        "contentTypeId": 5,
                        "categoryId": 2,
                        "titleHeader": "5 Must-Have Makeup Tools",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/15/2020 2:15:01 AM",
                        "validUpTo": "11/15/2120 2:15:01 AM",
                        "contentSummary": "<p>Ready to step up your makeup game? Here are a few tools that will do the trick.&nbsp;</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/ED107976-D652-452A-B769-5FC87DFCAE3F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/fashion-and-sustainability/fitness/5-MustHave-Makeup-Tools-161.html",
                        "categoryName": "Fashion-and-Sustainability",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 159,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "Stay fit with Yoga",
                        "author": "VG",
                        "validFrom": "11/13/2020 6:45:15 PM",
                        "validUpTo": "11/13/2120 6:45:15 PM",
                        "contentSummary": "<p>Stay fit with Yoga</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/FC1E19D0-B2CE-446A-9F39-EAF9416E9E4F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/Stay-fit-with-Yoga-159.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 157,
                        "contentTypeId": 2,
                        "categoryId": 5,
                        "titleHeader": "nature video",
                        "author": "VG",
                        "validFrom": "11/13/2020 3:44:14 PM",
                        "validUpTo": "11/13/2120 3:44:14 PM",
                        "contentSummary": "<p>natrue video</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F559D944-6D0A-4752-94A8-7199B932F989.PNG",
                        "mediaURL": "https://media.hercircle.in/media/SuryaNamaskar 620201104184200/SuryaNamaskar 620201104184200masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/get-inspired/fitness/nature-video-157.html",
                        "categoryName": "Get-Inspired",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 155,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Yoga makes you fit and healthy - How to do it.",
                        "author": "VG",
                        "validFrom": "11/13/2020 2:13:35 PM",
                        "validUpTo": "11/13/2120 2:13:35 PM",
                        "contentSummary": "<p>Yoga makes you fit and healthy - How to do it.</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/6FA56B01-EE6D-4A1D-9869-D2552D454C15.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Yoga-makes-you-fit-and-healthy-How-to-do-it-155.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 154,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Yoga makes you fit and healthy - How to do it.",
                        "author": "VG",
                        "validFrom": "11/13/2020 2:13:32 PM",
                        "validUpTo": "11/13/2120 2:13:32 PM",
                        "contentSummary": "<p>Yoga makes you fit and healthy - How to do it.</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/AD2544BE-1393-45D6-B882-5C59301DE81F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Yoga-makes-you-fit-and-healthy-How-to-do-it-154.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 153,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Yoga makes you fit and healthy - How to do it.",
                        "author": "VG",
                        "validFrom": "11/13/2020 2:13:32 PM",
                        "validUpTo": "11/13/2120 2:13:32 PM",
                        "contentSummary": "<p>Yoga makes you fit and healthy - How to do it.</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F1C216C6-CD3C-4D67-97FB-7F2BC1499B23.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Yoga-makes-you-fit-and-healthy-How-to-do-it-153.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 152,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Yoga makes you fit and healthy - How to do it.",
                        "author": "VG",
                        "validFrom": "11/13/2020 2:13:30 PM",
                        "validUpTo": "11/13/2120 2:13:30 PM",
                        "contentSummary": "<p>Yoga makes you fit and healthy - How to do it.</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/2DE88323-AB0C-4EFC-BAB4-B4A373C56753.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Yoga-makes-you-fit-and-healthy-How-to-do-it-152.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 151,
                        "contentTypeId": 5,
                        "categoryId": 2,
                        "titleHeader": "Trendy Fabrics That Dominated 2020",
                        "author": "Jhumur Ganguly",
                        "validFrom": "11/12/2020 8:09:55 PM",
                        "validUpTo": "11/12/2120 8:09:55 PM",
                        "contentSummary": "<p>A fabric can make or break the outfit. Let&rsquo;s look at the catch up with the most loved fabrics of 2020!</p>\r\n<p>2020 will be synonyms with all things sustainable. Thus, this year, most fabrics which dominated runways and trends were the ones which kept this sentiment alive. Here are our picks.&nbsp; &nbsp;</p>\r\n<p>Organic Cotton</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/D7A93384-DB73-4F48-996B-62A30D17D0D2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/fashion-and-sustainability/fitness/Trendy-Fabrics-That-Dominated-2020-151.html",
                        "categoryName": "Fashion-and-Sustainability",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 150,
                        "contentTypeId": 5,
                        "categoryId": 2,
                        "titleHeader": "Trendy Fabrics That Dominated 2020",
                        "author": "Jhumur Ganguly",
                        "validFrom": "11/12/2020 8:09:50 PM",
                        "validUpTo": "11/12/2120 8:09:50 PM",
                        "contentSummary": "<p>A fabric can make or break the outfit. Let&rsquo;s look at the catch up with the most loved fabrics of 2020!</p>\r\n<p>2020 will be synonyms with all things sustainable. Thus, this year, most fabrics which dominated runways and trends were the ones which kept this sentiment alive. Here are our picks.&nbsp; &nbsp;</p>\r\n<p>Organic Cotton</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8254B30D-4984-4564-9441-E64BBA4E5237.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/fashion-and-sustainability/fitness/Trendy-Fabrics-That-Dominated-2020-150.html",
                        "categoryName": "Fashion-and-Sustainability",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 148,
                        "contentTypeId": 1,
                        "categoryId": 5,
                        "titleHeader": "&ldquo;Sometimes, an achievement is all it takes for you to take opportunities seriously.&rdquo; &ndash; Aruna Reddy",
                        "author": "Jhumur Ganguly",
                        "validFrom": "11/12/2020 7:39:25 PM",
                        "validUpTo": "11/12/2120 7:39:25 PM",
                        "contentSummary": "<p>&ldquo;Sometimes, an achievement is all it takes for you to take opportunities seriously.&rdquo; &ndash; Aruna Reddy</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/EFD302FA-30C2-4700-B985-3C07FC44FE56.JPEG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/get-inspired/fitness/Sometimes-an-achievement-is-all-it-takes-for-you-to-take-opportunities-seriously-Aruna-Reddy-148.html",
                        "categoryName": "Get-Inspired",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 145,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "Bulb second attempt - dummy",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/10/2020 9:43:39 PM",
                        "validUpTo": "11/10/2120 9:43:39 PM",
                        "contentSummary": "<p>Bulb second attempt dummy Bulb second attempt dummy Bulb second attempt dummy</p>",
                        "tags": "Exercise",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/B4F7AEA7-864A-4F10-AD64-EC9902A87206.JPG",
                        "mediaURL": "https://media.hercircle.in/media/newRotiMaking20201111115824/newRotiMaking20201111115824masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Bulb-second-attempt-dummy-145.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 144,
                        "contentTypeId": 2,
                        "categoryId": 3,
                        "titleHeader": "Video Story",
                        "author": "Jhumur Ganguly",
                        "validFrom": "11/10/2020 8:55:49 PM",
                        "validUpTo": "11/10/2120 8:55:49 PM",
                        "contentSummary": "<p>Test Video</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/98E718F1-08B9-411A-BB6B-4DAB522C94B2.JPG",
                        "mediaURL": "https://media-sit.jio.com/media/BeginnersMakeup_HerCircle20200902180829/BeginnersMakeup_HerCircle20200902180829masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Video-Story-144.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 143,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "Changing bulb - first attempt",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/10/2020 5:46:20 PM",
                        "validUpTo": "11/10/2120 5:46:20 PM",
                        "contentSummary": "<p>This is dummy copy please dont read</p>",
                        "tags": "Exercise",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F7623A71-8908-433E-9119-ED73A55A1AAD.JPG",
                        "mediaURL": "https://media-sit.jio.com/media/LightBulb 20201110172056/LightBulb 20201110172056masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Changing-bulb-first-attempt-143.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 141,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "First ever roti making",
                        "author": "Riya Sabbarwal",
                        "validFrom": "11/6/2020 2:23:49 PM",
                        "validUpTo": "11/6/2120 2:23:49 PM",
                        "contentSummary": "<p>First ever roti making exoerience this is dummy copy First ever roti making exoerience this is dummy copy First ever roti making exoerience this is dummy copy</p>",
                        "tags": "EatHeathy",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/A086D086-F1D0-4894-9C12-5789D1428EE8.JPG",
                        "mediaURL": "http://10.161.47.136:9090/media/newRotiMaking20201110220831/newRotiMaking20201110220831masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/First-ever-roti-making-141.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 137,
                        "contentTypeId": 2,
                        "categoryId": 3,
                        "titleHeader": "Masterclass with Celebrity Makeup Artist Shaan Mu",
                        "author": "Charlene Flanagan",
                        "validFrom": "11/4/2020 7:38:09 PM",
                        "validUpTo": "11/4/2120 7:38:09 PM",
                        "contentSummary": "<p>mental wellbeing, beauty, makeup, celebrity makeup, step by step mental wellbeing, beauty, makeup, celebrity makeup, step by stepmental wellbeing, beauty, makeup, celebrity makeup, step by stepmental wellbeing, beauty, makeup, celebrity makeup, step by step</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CF043E79-0C69-41B6-B8FB-4D94E5FA908A.JPG",
                        "mediaURL": "http://10.161.47.136:9090/media/MasterClassFinalShaan20201111121414/MasterClassFinalShaan20201111121414masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/Masterclass-with-Celebrity-Makeup-Artist-Shaan-Mu-137.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 136,
                        "contentTypeId": 2,
                        "categoryId": 1,
                        "titleHeader": "First attempt at doing a surya namaskar",
                        "author": "Riya Sabharwal",
                        "validFrom": "11/4/2020 7:16:57 PM",
                        "validUpTo": "11/4/2120 7:16:57 PM",
                        "contentSummary": "<p>This is dummy copy please do not read this. This is dummy copy please do not read this. This is dummy copy please do not read this.&nbsp;</p>",
                        "tags": "Exercise",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/F7E74441-CCC9-4918-8364-C9E606523418.JPG",
                        "mediaURL": "http://10.161.47.136:9090/media/SuryaNamaskar 620201106140310/SuryaNamaskar 620201106140310masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/First-attempt-at-doing-a-surya-namaskar-136.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 135,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "6 delicious protein smoothies to try RN!",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/4/2020 2:18:29 PM",
                        "validUpTo": "11/4/2120 2:18:29 PM",
                        "contentSummary": "<p>They not only are delicious but help a great deal in providing the right nourishment to your body on a daily basis.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/94B92162-F9EB-43C9-B9B5-7FD305A09802.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/6-delicious-protein-smoothies-to-try-RN-135.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 129,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "Dummy article on anxiety sam",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/3/2020 2:51:06 PM",
                        "validUpTo": "11/3/2120 2:51:06 PM",
                        "contentSummary": "<p>Dummy title visual story sam Dummy title visual story sam Dummy title visual story sam Dummy title visual story sam</p>",
                        "tags": "EatHeathy",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/5029CA28-66E7-43C8-92D0-33B004969B97.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Dummy-article-on-anxiety-sam-129.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 128,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "How To Reduce Anxiety Attacks -1",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/3/2020 2:09:55 PM",
                        "validUpTo": "11/3/2120 2:09:55 PM",
                        "contentSummary": "<p>Anxiety attacks can be unpredictable. Here are few ways to tackle them.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/23C6D635-902C-486B-A520-254C2099750A.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/How-To-Reduce-Anxiety-Attacks-1-128.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 127,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "test article",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/3/2020 2:03:41 PM",
                        "validUpTo": "11/3/2120 2:03:41 PM",
                        "contentSummary": "<p>Anxiety attacks can be unpredictable. Here are few ways to tackle them.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/29A1C5D5-D3A9-4F3B-B583-B5EC0C7486D5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/test-article-127.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 125,
                        "contentTypeId": 5,
                        "categoryId": 1,
                        "titleHeader": "How To Reduce Anxiety Attacks",
                        "author": "Swathi Mohandas",
                        "validFrom": "11/3/2020 1:19:32 PM",
                        "validUpTo": "11/3/2120 1:19:32 PM",
                        "contentSummary": "<p>Anxiety attacks can be unpredictable. Here are few ways to tackle them.</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CC0B2628-0FC7-4872-BE8D-90854ED58D84.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/How-To-Reduce-Anxiety-Attacks-125.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 120,
                        "contentTypeId": 2,
                        "categoryId": 7,
                        "titleHeader": "Microservices in a fun way",
                        "author": "Avnish Kumar",
                        "validFrom": "11/2/2020 9:12:21 PM",
                        "validUpTo": "11/2/2120 9:12:21 PM",
                        "contentSummary": "<p>Learn microservices in a fun and entertaining way</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/D94CA64B-D7F7-4A80-9AB3-396C6340BE57.JPEG",
                        "mediaURL": "https://media-sit.jio.com/media/TestVideo100/TestVideo100masterplaylist.m3u8",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/Microservices-in-a-fun-way-120.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 116,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Check Out These Shows For Your Weekend Binge Watch",
                        "author": "Sunetra Ghose",
                        "validFrom": "10/30/2020 4:49:16 PM",
                        "validUpTo": "10/30/2120 4:49:16 PM",
                        "contentSummary": "<p>Here&rsquo;s a complied list of our recommendations you can binge watch this weekend</p>",
                        "tags": "today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/11F577BF-34BA-4BF0-8E41-2174DA8AF77F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Check-Out-These-Shows-For-Your-Weekend-Binge-Watch-116.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 115,
                        "contentTypeId": 5,
                        "categoryId": 2,
                        "titleHeader": "Trendy Fabrics That Dominated 2020",
                        "author": "Swathi Mohandas",
                        "validFrom": "10/30/2020 4:36:24 PM",
                        "validUpTo": "10/30/2120 4:36:24 PM",
                        "contentSummary": "<p>A fabric can make or break the outfit. Let&rsquo;s look at the catch up with the most loved fabrics of 2020!</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/1A61E2FB-CBED-4DD7-B2D0-18F99A996EC5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/fashion-and-sustainability/fitness/Trendy-Fabrics-That-Dominated-2020-115.html",
                        "categoryName": "Fashion-and-Sustainability",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 114,
                        "contentTypeId": 1,
                        "categoryId": 3,
                        "titleHeader": "5 Effective Home Remedies For Grey Hair",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/30/2020 4:20:21 PM",
                        "validUpTo": "10/30/2120 4:20:21 PM",
                        "contentSummary": "<p>Are you looking for some natural, but effective ways to deal with those greys? Here are five home remedies you can try.</p>",
                        "tags": "editor's choice,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/EBED2A73-0A96-4843-AAD9-520CA5B4C8D2.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/beauty-and-health/fitness/5-Effective-Home-Remedies-For-Grey-Hair-114.html",
                        "categoryName": "Beauty-and-Health",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 113,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Home Remedies For Morning Sickness",
                        "author": "Nikshubha Garg",
                        "validFrom": "10/30/2020 4:14:44 PM",
                        "validUpTo": "10/30/2120 4:14:44 PM",
                        "contentSummary": "<p class=\"MsoNormal\"><span lang=\"EN-US\" style=\"font-size: 11.0pt; mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-US;\">Here are ways through which you can alleviate symptoms of morning sickness</span></p>",
                        "tags": "editor's choice,MorningSickness",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/A9758A98-E8A2-4AE8-86EA-3E31FA80B310.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Home-Remedies-For-Morning-Sickness-113.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 112,
                        "contentTypeId": 1,
                        "categoryId": 6,
                        "titleHeader": "5 Ideas To Upcycle Home D&eacute;cor And Transform Your Space",
                        "author": "Sunetra Ghose",
                        "validFrom": "10/30/2020 4:10:55 PM",
                        "validUpTo": "10/30/2120 4:10:55 PM",
                        "contentSummary": "<p>What if you could give your home a makeover with a few tweaks to d&eacute;cor you already have around your home? Here are five ways to upcycle and transform your space</p>",
                        "tags": "today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0EA621D1-77F9-4AB8-8E0C-D45F5A62649A.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/living/fitness/5-Ideas-To-Upcycle-Home-Dcor-And-Transform-Your-Space-112.html",
                        "categoryName": "Living",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 110,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "wow what a story",
                        "author": "Avnish",
                        "validFrom": "10/30/2020 3:51:54 PM",
                        "validUpTo": "10/30/2120 3:51:54 PM",
                        "contentSummary": "<p>wow what a story</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/6FBB3203-560D-4797-ADE3-8CF4C59A1218.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/wow-what-a-story-110.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 109,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "Money Matters: How To Effectively Manage Your Finances In Your 30s",
                        "author": "Nikshubha Garg",
                        "validFrom": "10/30/2020 3:51:38 PM",
                        "validUpTo": "10/30/2120 3:51:38 PM",
                        "contentSummary": "<p><span lang=\"EN-US\" style=\"font-size: 11.0pt; font-family: 'Calibri',sans-serif; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA;\">In your 30s, it&rsquo;s time to build on the lessons you learnt in your 20s</span></p>",
                        "tags": "Finance,FinanceGoals,FinanceTracking,PersonalFinance",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/CE522838-F05A-45FC-B825-240D6B744966.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/Money-Matters-How-To-Effectively-Manage-Your-Finances-In-Your-30s-109.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 108,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Wow what a story",
                        "author": "Avnish Kumar",
                        "validFrom": "10/30/2020 3:46:06 PM",
                        "validUpTo": "10/30/2120 3:46:06 PM",
                        "contentSummary": "<p>wow what a story</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/7A49BAF6-7155-40B1-A2D7-ED4028841F9F.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Wow-what-a-story-108.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 106,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "We Recommend: Add These 5 Must-Read Thrillers To Your Book Shelf",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/30/2020 1:14:52 PM",
                        "validUpTo": "10/30/2120 1:14:52 PM",
                        "contentSummary": "<p>If you&rsquo;re looking for a whole new way to keep your mind engaged, we recommend some great reading material. And if you&rsquo;re a fan of mysteries and thrillers, here&rsquo;s five of our must-read titles to add to your book shelf.</p>",
                        "tags": "editor's choice,today's top picks",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/4F66C2A0-90FB-40FE-AC2D-F89DCBF54C84.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/We-Recommend-Add-These-5-MustRead-Thrillers-To-Your-Book-Shelf-106.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 105,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "5 Superfoods You Should Include In Your Daily Diet",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/30/2020 1:01:04 PM",
                        "validUpTo": "10/30/2120 1:01:04 PM",
                        "contentSummary": "<p>Wondering what can take your seemingly healthy eating habits up a notch? All you have to do is add these five superfoods to your daily diet and be your best self.</p>",
                        "tags": "Diet,DietGoals,EatHeathy,Nutrition",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/ABEB93F0-2964-4F6F-951C-9B639FAA9BEB.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/5-Superfoods-You-Should-Include-In-Your-Daily-Diet-105.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 104,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "Be More",
                        "author": "sushil",
                        "validFrom": "10/29/2020 8:38:12 PM",
                        "validUpTo": "10/29/2120 8:38:12 PM",
                        "contentSummary": "<p>collect small,Make it large</p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8BB78C2C-B351-4786-A237-133E55A4409E.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/Be-More-104.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 103,
                        "contentTypeId": 1,
                        "categoryId": 7,
                        "titleHeader": "15 Important Investment Terms You Should Know About",
                        "author": "Nikshubha Garg",
                        "validFrom": "10/29/2020 7:51:10 PM",
                        "validUpTo": "10/29/2120 7:51:10 PM",
                        "contentSummary": "<p>Familiarise yourself with important investment terms before your dive in&nbsp;</p>",
                        "tags": "today's top picks,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8304417A-2406-44A3-A4D6-CAD83C46A412.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/work/fitness/15-Important-Investment-Terms-You-Should-Know-About-103.html",
                        "categoryName": "Work",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 102,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "15 Important Investment Terms You Should Know About",
                        "author": "sushil",
                        "validFrom": "10/29/2020 7:37:56 PM",
                        "validUpTo": "10/29/2120 7:37:56 PM",
                        "contentSummary": "<p><span style=\"font-size: 11.0pt; font-family: 'Calibri',sans-serif; mso-ascii-theme-font: minor-latin; mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor-latin; mso-ansi-language: EN-US; mso-fareast-language: EN-US; mso-bidi-language: AR-SA;\">Familiarise yourself with important investment terms before your dive in&nbsp;</span></p>",
                        "tags": "editor's choice",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/8036690D-4F2C-40D1-B286-D80EE5B4033C.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/15-Important-Investment-Terms-You-Should-Know-About-102.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 101,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "6 delicious protein smoothies to try RN!",
                        "author": "Swathi Mohandas",
                        "validFrom": "10/29/2020 6:50:33 PM",
                        "validUpTo": "10/29/2120 6:50:33 PM",
                        "contentSummary": "<p>They not only are delicious but help a great deal in providing the right nourishment to your body on a daily basis.</p>\r\n<p>&nbsp;</p>\r\n<p>First things first, everything nutritious can be tasty, provided you find the right combination of foods. In this article, we shall focus on protein smoothies which are ideal for t</p>\r\n<p>&nbsp;</p>",
                        "tags": "Diet,DietGoals",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/609E2D71-DE36-4450-ABC6-CE6925AF4CF5.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/6-delicious-protein-smoothies-to-try-RN-101.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 100,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "6 delicious protein smoothies to try RN!",
                        "author": "Swathi Mohandas",
                        "validFrom": "10/29/2020 6:50:07 PM",
                        "validUpTo": "10/29/2120 6:50:07 PM",
                        "contentSummary": "<p>They not only are delicious but help a great deal in providing the right nourishment to your body on a daily basis.</p>\r\n<p>&nbsp;</p>\r\n<p>First things first, everything nutritious can be tasty, provided you find the right combination of foods. In this article, we shall focus on protein smoothies which are ideal for t</p>\r\n<p>&nbsp;</p>",
                        "tags": "Diet,DietGoals",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/62E779E8-1E02-4854-9986-87392944BF39.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/6-delicious-protein-smoothies-to-try-RN-100.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 99,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "6 delicious protein smoothies to try RN!",
                        "author": "Swathi Mohandas",
                        "validFrom": "10/29/2020 6:49:40 PM",
                        "validUpTo": "10/29/2120 6:49:40 PM",
                        "contentSummary": "<p>They not only are delicious but help a great deal in providing the right nourishment to your body on a daily basis.</p>\r\n<p>&nbsp;</p>\r\n<p>First things first, everything nutritious can be tasty, provided you find the right combination of foods. In this article, we shall focus on protein smoothies which are ideal for t</p>\r\n<p>&nbsp;</p>",
                        "tags": "Diet,DietGoals",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/43E4A767-B883-462D-BDBF-F2E0B9CCFDCA.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/6-delicious-protein-smoothies-to-try-RN-99.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 98,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "6 delicious protein smoothies to try RN!",
                        "author": "Swathi Mohandas",
                        "validFrom": "10/29/2020 6:49:13 PM",
                        "validUpTo": "10/29/2120 6:49:13 PM",
                        "contentSummary": "<p>They not only are delicious but help a great deal in providing the right nourishment to your body on a daily basis.</p>\r\n<p>&nbsp;</p>\r\n<p>First things first, everything nutritious can be tasty, provided you find the right combination of foods. In this article, we shall focus on protein smoothies which are ideal for t</p>\r\n<p>&nbsp;</p>",
                        "tags": "Diet,DietGoals",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/59321862-BA58-4992-8660-CF05B1BF8B7C.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/6-delicious-protein-smoothies-to-try-RN-98.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 97,
                        "contentTypeId": 1,
                        "categoryId": 1,
                        "titleHeader": "6 delicious protein smoothies to try RN!",
                        "author": "Swathi Mohandas",
                        "validFrom": "10/29/2020 6:48:48 PM",
                        "validUpTo": "10/29/2120 6:48:48 PM",
                        "contentSummary": "<p>They not only are delicious but help a great deal in providing the right nourishment to your body on a daily basis.</p>\r\n<p>&nbsp;</p>\r\n<p>First things first, everything nutritious can be tasty, provided you find the right combination of foods. In this article, we shall focus on protein smoothies which are ideal for t</p>\r\n<p>&nbsp;</p>",
                        "tags": "",
                        "publishedFor": "Engage",
                        "isLeadStory": "False",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/0FE8EB4B-64AD-4DDF-BE64-73F83962B1FE.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/wellness/fitness/6-delicious-protein-smoothies-to-try-RN-97.html",
                        "categoryName": "Wellness",
                        "subCategoryName": "Fitness"
                    },
                    {
                        "contentId": 96,
                        "contentTypeId": 1,
                        "categoryId": 8,
                        "titleHeader": "Movie Review: Enola Holmes",
                        "author": "Charlene Flanagan",
                        "validFrom": "10/29/2020 6:09:56 PM",
                        "validUpTo": "10/29/2120 6:09:56 PM",
                        "contentSummary": "<p>Nothing says &lsquo;Family Film&rsquo; quite like an adaption of a young adult novel. And if you&rsquo;re looking for action, adventure, and a whole lot of spunk, Enola Holmes is just what you need to watch.</p>",
                        "tags": "editor's choice,top stories",
                        "publishedFor": "Engage",
                        "isLeadStory": "True",
                        "mediaFileName": "https://devhercircle.jio.com/Portal/Engage/M/2B0859DD-2C6A-4731-A9DD-840ED71F0E03.JPG",
                        "mediaURL": "",
                        "contentURL": "https://devhercircle.jio.com/Engage/culture/fitness/Movie-Review-Enola-Holmes-96.html",
                        "categoryName": "Culture",
                        "subCategoryName": "Fitness"
                    }
                ]
            },
            "statusCode": 200,
            "success": true,
            "userMsg": "",
            "systemMsg": ""
        }
        """



        let jsonData = Data(jsonString.utf8)

        let decoder = JSONDecoder()

        do {
            let getHomeData = try decoder.decode(EngageModel.self, from: jsonData)
            self.homeData = getHomeData.data
            self.homeTableView.reloadData()
            self.filterCollectionview.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }*/



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
