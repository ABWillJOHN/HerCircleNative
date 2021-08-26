//
//  DietFitnessWhatDoYouWantVC.swift
//  Task09082021
//
//  Created by Keyur Baravaliya on 10/08/21.
//

import UIKit

class DietFitnessWhatDoYouWantVC: UIViewController {
    @IBOutlet weak var btnLoseWeight: UIButton!
    @IBOutlet weak var btnGetFit: UIButton!
    @IBOutlet weak var btnGainWeight: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)
        // Do any additional setup after loading the view.
        self.updateBtnBgTextColor()
        self.btnLoseWeight.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.btnLoseWeight.setTitleColor(.white, for: .normal)
        DietFitnessData.shared.goal = "Lose weight"
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    @IBAction func btnLoseWeightAction(_ sender: UIButton) {
        
        self.updateBtnBgTextColor()
        self.btnLoseWeight.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.btnLoseWeight.setTitleColor(.white, for: .normal)
        DietFitnessData.shared.goal = "Lose weight"
        
    }
    
    @IBAction func btnGainWeightAction(_ sender: UIButton) {
        self.updateBtnBgTextColor()
        self.btnGainWeight.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.btnGainWeight.setTitleColor(.white, for: .normal)
        DietFitnessData.shared.goal = "Gain weight"
    }
    
    @IBAction func btnGetFitAction(_ sender: UIButton) {
        self.updateBtnBgTextColor()
        self.btnGetFit.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.btnGetFit.setTitleColor(.white, for: .normal)
        DietFitnessData.shared.goal = "Get fit"
    }
    
    func updateBtnBgTextColor() {
        self.btnLoseWeight.backgroundColor = .quaternarySystemFill
        self.btnLoseWeight.setTitleColor(.black, for: .normal)
        self.btnGainWeight.backgroundColor = .quaternarySystemFill
        self.btnGainWeight.setTitleColor(.black, for: .normal)
        self.btnGetFit.backgroundColor = .quaternarySystemFill
        self.btnGetFit.setTitleColor(.black, for: .normal)
        
        
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        let dietFitnessHowMuchWeightDoYouWantLoseVC = DietFitnessHowMuchWeightDoYouWantLoseVC()
        self.navigationController?.pushViewController(dietFitnessHowMuchWeightDoYouWantLoseVC, animated: true)
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
