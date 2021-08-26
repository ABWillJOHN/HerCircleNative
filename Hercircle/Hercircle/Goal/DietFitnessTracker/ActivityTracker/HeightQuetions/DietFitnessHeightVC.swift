//
//  DietFitnessHeightVC.swift
//  Task09082021
//
//  Created by Keyur Baravaliya on 10/08/21.
//

import UIKit

class DietFitnessHeightVC: UIViewController {
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var lblWhatDoYouWantValue: UILabel!
    @IBOutlet weak var lblHowMuchweightWantLoseValue: UILabel!
    @IBOutlet weak var txtHieght: UITextField!
    @IBOutlet weak var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)
        // Do any additional setup after loading the view.
        self.segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        self.segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
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
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: DietFitnessHowMuchDoYouWeightVC.self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnbackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        if let strHeight = self.txtHieght.text,strHeight.count > 0 {
        DietFitnessData.shared.height = self.txtHieght.text!
        let dietFitnessHowMuchDoYouWeightVC = DietFitnessHowMuchDoYouWeightVC()
        self.navigationController?.pushViewController(dietFitnessHowMuchDoYouWeightVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please enter your height.", preferredStyle: UIAlertController.Style.alert)
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
