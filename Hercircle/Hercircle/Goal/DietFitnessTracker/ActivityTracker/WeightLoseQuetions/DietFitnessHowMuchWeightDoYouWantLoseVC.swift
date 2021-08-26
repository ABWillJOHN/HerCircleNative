//
//  DietFitnessHowMuchWeightDoYouWantLoseVC.swift
//  Task09082021
//
//  Created by Keyur Baravaliya on 10/08/21.
//

import UIKit

class DietFitnessHowMuchWeightDoYouWantLoseVC: UIViewController {

    @IBOutlet weak var txtfWeightLose: UITextField!
    @IBOutlet weak var lblWhatDoyouWantValue: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.btnNext.isEnabled = false
        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)
        

        // Do any additional setup after loading the view.
    }


    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapWhatDoYouWantAction(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        if let strTemp = self.txtfWeightLose.text, strTemp.count > 0 {
            DietFitnessData.shared.targetWeight = self.txtfWeightLose.text!
            let dietFitnessHeightVC = DietFitnessHeightVC()
            self.navigationController?.pushViewController(dietFitnessHeightVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please enter weight you want to loose", preferredStyle: UIAlertController.Style.alert)
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

extension DietFitnessHowMuchWeightDoYouWantLoseVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let str = textField.text,str.count > 0 {
            self.btnNext.isEnabled = true
        } else {
            self.btnNext.isEnabled = false
        }
    }
}
