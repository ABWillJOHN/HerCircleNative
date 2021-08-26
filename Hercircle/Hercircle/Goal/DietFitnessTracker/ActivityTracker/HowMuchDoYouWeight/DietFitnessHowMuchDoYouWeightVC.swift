//
//  DietFitnessHowMuchDoYouWeightVC.swift
//  Task09082021
//
//  Created by Keyur Baravaliya on 10/08/21.
//

import UIKit

class DietFitnessHowMuchDoYouWeightVC: UIViewController {
    @IBOutlet weak var txtfWeight: UITextField!
    @IBOutlet weak var lblWhatDoYouWantValue: UILabel!
    @IBOutlet weak var lblHowMuchweightWantLoseValue: UILabel!
    @IBOutlet weak var lblWhatIsYourHeightValue: UILabel!
    @IBOutlet weak var headerView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTapWatDoYouWantEditAction(_ sender: UIControl) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DietFitnessWhatDoYouWantVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func onTapLoseWeightEditAction(_ sender: UIControl) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DietFitnessHowMuchWeightDoYouWantLoseVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func onTapWhatIsYourHeightAction(_ sender: UIControl) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DietFitnessHeightVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }

    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        if let strText = self.txtfWeight.text, strText.count > 0 {
        DietFitnessData.shared.currentWeight = self.txtfWeight.text!
        let howIsYourLifeStyleVC = HowIsYourLifeStyleVC()
        self.navigationController?.pushViewController(howIsYourLifeStyleVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please enter your weight.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
