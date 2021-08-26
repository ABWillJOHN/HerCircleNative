//
//  UserViewController.swift
//  side+tab
//
//  Created by Rahul Patel on 24/06/21.
//

import UIKit

class HelpVC: SideBaseVC {
    
   @IBOutlet weak var collectionVw: UICollectionView!
    
    var help: Help?
    
    var isTileView = true
    var btnGrid: UIButton?
    var btnList: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2.2, height: view.frame.size.width/2.2)
        self.collectionVw.collectionViewLayout = layout
        var signIn = SigninUserHandler.shared.getUserDeytails()
        
        if (signIn?.data[0].userId?.count == 0 || signIn?.data[0].userId == nil ){
        let controller = UIAlertController(title: "Please first signIn to access all functionality", message: "", preferredStyle: .alert)
            controller.view.backgroundColor = UIColor.darkGray
            //controller.view.isOpaque = true
        let alertAction1  = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) { UIAlertAction in
            let sbMain = UIStoryboard(name: StoryboardID.main, bundle: nil)
            
            if let sigInVc = sbMain.instantiateViewController(identifier: "loginVC") as? LoginVC {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = sigInVc
                appDelegate.window?.makeKeyAndVisible()
            }
        }
            controller.addAction(alertAction1)
        self.present(controller, animated: false, completion: nil)
        }
            
          
        
        collectionVw.delegate = self
        collectionVw.dataSource = self
        
        collectionVw.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        collectionVw.register(UINib(nibName: "CollectionFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView")
    
        
        collectionVw.register(UINib(nibName: "TileCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tileCell")
        
        collectionVw.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listView")
        
        getHelpData()

//        view.addSubview(collectionVw ?? UICollectionView())
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func getHelpData() {
        
        HelpVM().getUser { (result) in
            switch result {
            case .success(let Expert):
                DispatchQueue.main.async {
                    if Expert?.statusCode == 200 {
                        self.help = Expert
                        self.collectionVw.reloadData()
                    } else {
                        //self?.showAlert(message: deviceInfo?.message ?? "")
                    }
                }
            case .failure(let error):
                print("the error \(error)")
                
                DispatchQueue.main.async {
                    self.showAlert(title:"Something is wrong", actionText1: "OK") { _ in }
                }
            }
        }
       
    }
    
    func redirectToAskExpertView (index: Int) {
        if let vc = HelpAskExpertVC(nibName: "HelpAskExpertVC", bundle: nil) as? HelpAskExpertVC
               {
                    vc.expert = self.help?.data[index]
                    self.navigationController?.pushViewController(vc, animated: true)
               }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HelpVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cnt = 0
        if let help = self.help?.data {
            cnt = help.count
        } else {
            cnt = 0
        }
        return cnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionCell = UICollectionViewCell()
        if isTileView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tileCell", for: indexPath)
            if let expert = self.help?.data[indexPath.item] {
                if let tileVw = cell as? TileCellCollectionViewCell {
                   // tileVw.img.downloadImageFrom(link: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", contentMode: UIView.ContentMode.scaleAspectFit)
                    tileVw.img.downloadImageFrom(link: expert.imageURL, contentMode: UIView.ContentMode.scaleAspectFit)
                    tileVw.delegate = self
                    tileVw.lblName.text = expert.firstName + expert.lastName
                    tileVw.lblDisc.text = expert.profession
                    tileVw.btnDisc.tag = indexPath.item
                }
            }
            collectionCell = cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listView", for: indexPath)
            if let expert = self.help?.data[indexPath.item] {
                if let listVw = cell as? ListCollectionViewCell {
                   // listVw.imgVw?.downloadImageFrom(link: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png", contentMode: UIView.ContentMode.scaleAspectFit)
                    listVw.imgVw?.downloadImageFrom(link: expert.imageURL, contentMode: UIView.ContentMode.scaleAspectFit)
                    listVw.delegate = self
                    listVw.lblNm?.text = expert.firstName + expert.lastName
                    listVw.lblDiscrip?.text = expert.profession
                    listVw.btnChat?.tag = indexPath.item
                }
            }
            collectionCell = cell
        }
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath)
            if let header = headerView as? CollectionHeaderView {
                self.btnGrid = header.btnTile
                self.btnList = header.btnList
                header.delegate = self
            }

        return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerView", for: indexPath)

            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = helpDoctorDetailViewController(nibName: "helpDoctorDetailViewController", bundle: nil) as? helpDoctorDetailViewController
       {
            if let exp = self.help?.data[indexPath.item] {
                vc.expert = exp
            }
            self.navigationController?.pushViewController(vc, animated: true)
       }
    }

}

extension HelpVC: CollectionHeaderViewDelegate, TileCellCollectionViewCellDelegate,ListCollectionViewCellDelegate {
    func callAskExpertView(btn: UIButton) {
        self.redirectToAskExpertView(index: btn.tag)
    }
    func callAskExpertViewFromList(btn: UIButton) {
        self.redirectToAskExpertView(index: btn.tag)
    }
    
    
    func setTileView(btn: UIButton) {
        
        self.btnGrid?.backgroundColor = UIColor.systemRed
        self.btnGrid?.setImage(UIImage(imageLiteralResourceName: "grid_Selected"), for: UIControl.State.normal)
        self.btnList?.backgroundColor = UIColor.white
        self.btnList?.setImage(UIImage(imageLiteralResourceName: "List_UnSelected"), for: UIControl.State.normal)
        self.isTileView = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width/2.2, height: view.frame.size.width/2.2)
        self.collectionVw.collectionViewLayout = layout
        self.collectionVw.reloadData()
    }
    
    func setGridView(btn: UIButton) {
        
        self.btnGrid?.backgroundColor = UIColor.white
        self.btnGrid?.setImage(UIImage(imageLiteralResourceName: "grid_UnSelected"), for: UIControl.State.normal)
        self.btnList?.backgroundColor = UIColor.systemRed
        self.btnList?.setImage(UIImage(imageLiteralResourceName: "List_Selected"), for: UIControl.State.normal)
        self.isTileView = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: view.frame.size.width, height: 65)
        self.collectionVw.collectionViewLayout = layout
        self.collectionVw.reloadData()
    }
}

class MyFooterClass: UICollectionViewCell {

 override init(frame: CGRect) {
    super.init(frame: frame)
    //self.backgroundColor = UIColor.purple

    // Customize here

 }

 required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

 }
}

class MyHeaderClass: UICollectionViewCell {

 override init(frame: CGRect) {
    super.init(frame: frame)
    //self.backgroundColor = UIColor.purple

    // Customize here

 }

 required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

 }
}

class tileCellClass: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
