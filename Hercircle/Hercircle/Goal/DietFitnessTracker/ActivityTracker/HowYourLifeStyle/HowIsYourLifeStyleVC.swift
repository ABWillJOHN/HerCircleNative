//
//  HowIsYourLifeStyleVC.swift
//  Task09082021
//
//  Created by Keyur Baravaliya on 10/08/21.
//

import UIKit

class HowIsYourLifeStyleVC: UIViewController {
    
    @IBOutlet weak var lblWhatDoYouWantValue: UILabel!
    @IBOutlet weak var lblHowMuchweightWantLoseValue: UILabel!
    @IBOutlet weak var lblWhatIsYourHeightValue: UILabel!
    @IBOutlet weak var lblHowMuchDoYouWeightValue: UILabel!
    @IBOutlet weak var btnModeratelyActive: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnSedentary: UIButton!
    @IBOutlet weak var headerView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)

        // Do any additional setup after loading the view.
    }


    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        
       /* DietFitnessVM().postLiftStyleData(user: DietFitnessData.shared.userId, dob: "1994-01-02", weight: DietFitnessData.shared.currentWeight, currentWeight: DietFitnessData.shared.currentWeight, height: DietFitnessData.shared.height, goal: DietFitnessData.shared.goal, target_Weight: DietFitnessData.shared.targetWeight, target_Dt: "2021-10-15", lifeStyle: DietFitnessData.shared.lifestyle) { (result) in
            switch result {
            case .success(let dietDetail):
                DispatchQueue.main.async {
                    if dietDetail?.statusCode == 200 {
                        
                        let vc = DiaryViewVC()
                           self.navigationController?.pushViewController(vc, animated: true)
                        
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

        } */
        
        let vc = DiaryViewVC()
        
       // self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
           self.navigationController?.pushViewController(vc, animated: true)
        
      
    }
    
    @IBAction func onTapWhatDoYouWantAction(_ sender: UIControl) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DietFitnessWhatDoYouWantVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func onTapHowMuchWeightDoYouwantLoseAction(_ sender: UIControl) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DietFitnessHowMuchWeightDoYouWantLoseVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func onTapWhatisYourHeightAction(_ sender: UIControl) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DietFitnessHeightVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func onTapHowMuchDoYouWeightAction(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnModeratelyActiveAction(_ sender: UIButton) {
        DietFitnessData.shared.lifestyle = "Moderately active"
        self.updateBtnBgAndTextColor()
        self.btnModeratelyActive.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.btnModeratelyActive.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func btnActiveAction(_ sender: UIButton) {
        DietFitnessData.shared.lifestyle = "Active"
        self.updateBtnBgAndTextColor()
        self.btnActive.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.btnActive.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func btnSedentryAction(_ sender: UIButton) {
        DietFitnessData.shared.lifestyle = "Sedentary"
        self.updateBtnBgAndTextColor()
        self.btnSedentary.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.btnSedentary.setTitleColor(.white, for: .normal)
    }
    
    
    func updateBtnBgAndTextColor() {
        self.btnModeratelyActive.backgroundColor = .quaternarySystemFill
        self.btnModeratelyActive.setTitleColor(.black, for: .normal)
        self.btnActive.backgroundColor = .quaternarySystemFill
        self.btnActive.setTitleColor(.black, for: .normal)
        self.btnSedentary.backgroundColor = .quaternarySystemFill
        self.btnSedentary.setTitleColor(.black, for: .normal)
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
