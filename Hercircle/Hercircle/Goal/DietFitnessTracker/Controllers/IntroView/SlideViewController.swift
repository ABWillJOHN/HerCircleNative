//
//  SlideViewController.swift
//  Hercircle
//
//  Created by Apple on 03/08/21.
//

import UIKit
import FSCalendar
import FSPagerView

class SlideViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    
    
    var imagesArray: [String] = ["image1","image2","image3"]
    
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var pageView: FSPagerView! {
        didSet {
            self.pageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet var pageController: FSPageControl!
    var signIn: SignIn!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let signIn = SigninUserHandler.shared.getUserDeytails() {
        if let UID = signIn.data[0].userId {
        DietFitnessData.shared.userId = UID
        }
        }
        
        DietFitnessData.shared.userId = "9B597449-E30A-42DA-94E4-C4096A6CC3F2"

        // Do any additional setup after loading the view.
        self.pageView.delegate = self
        self.pageView.dataSource = self
        self.pageView.interitemSpacing = 20
        self.pageView.automaticSlidingInterval = 5
        self.pageController.numberOfPages = 3
        self.pageController.currentPage = 1
        self.pageController.interitemSpacing = 10
        self.pageController.contentHorizontalAlignment = .center
        self.pageController.setStrokeColor(#colorLiteral(red: 0.1943970621, green: 0.5901004672, blue: 0.3455791473, alpha: 1), for: .normal)
        self.pageController.setStrokeColor(.gray, for: .selected)
        self.pageController.setFillColor(#colorLiteral(red: 0.1943970621, green: 0.5901004672, blue: 0.3455791473, alpha: 1), for: .normal)
        self.pageController.setFillColor(.gray, for: .selected)
        self.pageController.setPath(UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: 10),cornerRadius: 5), for: .normal)
        self.pageController.setPath(UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: 10),cornerRadius: 5), for: .selected)
        
        if (DietFitnessData.shared.userId.count == 0 || DietFitnessData.shared.userId == "" ){
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
        } else {
            getUserDietDetail()

        }
    }
    
    @IBAction func onTapLetGetYouStartAction(_ sender: UIButton) {
        self.moveToStepSelect()
    }
    
    func moveToStepSelect() {
         let vc = DietFitnessWhatDoYouWantVC() 
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK:- FScalendar delegate & datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imagesArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image =
            UIImage.init(named: self.imagesArray[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = false
        cell.imageView?.backgroundColor = .white
        return cell
    }

    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        print("page view index \(index)")
        self.pageController.currentPage = index
        
        if index == 0 {
            self.lblSubTitle.text = "Be fitted at your pace. \nAt any page"
            self.lblDescription.text = "With us running shoulder to swaety shoulder with you"
        }else if index == 1 {
            self.lblSubTitle.text = "Balance your plate with right \nnutrition and state"
            self.lblDescription.text = "Login your meals and know daily categories consumed at the tap of a button"
        }else if index == 2 {
            self.lblSubTitle.text = "Lose or gain wight\n for yourself"
            self.lblDescription.text = "Login your meals and know daily categories consumed at the tap of a button"
        }
    }
    
    func getUserDietDetail(){
        
        DietFitnessVM().getDietDetail(name: DietFitnessData.shared.userId) { (result) in
            switch result {
            case .success(let dietDetail):
                DispatchQueue.main.async {
                    if dietDetail?.statusCode == 200 {
                        DietFitnessData.shared.userDietFitness = dietDetail
                        
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
