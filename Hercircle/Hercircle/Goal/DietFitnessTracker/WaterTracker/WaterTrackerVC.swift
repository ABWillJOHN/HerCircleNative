//
//  WaterTrackerVC.swift
//  Hercircle
//
//  Created by Apple on 10/08/21.
//

import UIKit

class WaterTrackerVC: UIViewController {
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var seperatorLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var waterTracketTitleLbl: UILabel!
    @IBOutlet weak var calenderImg: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateupButton: UIButton!
    @IBOutlet weak var dateDownBtn: UIButton!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var waterIncrementBaseView: UIView!
    @IBOutlet weak var waterIncrementBtn: UIButton!
    @IBOutlet weak var waterDecrementBtn: UIButton!
    @IBOutlet weak var glassImg: UIImageView!
    @IBOutlet weak var glassBaseView: UIView!
    @IBOutlet weak var waterLimitLbl: UILabel!
    @IBOutlet weak var waterPercentageLbl: UILabel!
    @IBOutlet weak var totalwaterLimitLbl: UILabel!
    
    var totalLimitWater:Double = Double()
    var userselectWater:Double = Double()
    var percentagecorrect :Double! = Double()
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img9: UIImageView!
    @IBOutlet weak var img10: UIImageView!
    @IBOutlet weak var stckView: UIStackView!
    var counter = 0
    @IBOutlet weak var headerView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)
        initilizeWithDefault()

        self.glassBaseView.layer.cornerRadius = 8.0
        self.glassBaseView.layer.shadowColor = UIColor.black.cgColor
        self.glassBaseView.layer.shadowOpacity = 0.8
        self.glassBaseView.layer.shadowRadius = 3.0
        self.glassBaseView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.waterIncrementBaseView.layer.cornerRadius = self.waterIncrementBaseView.frame.height / 2
        self.waterIncrementBtn.addTarget(self, action: #selector(waterIncrementButtonTapped(_:)), for: .touchUpInside)
        self.waterDecrementBtn.addTarget(self, action: #selector(waterdecrementButtontapped(_:)), for: .touchUpInside)
        self.userselectWater = 0.0
        self.totalLimitWater = 3000
        self.waterLimitLbl.text = "\(userselectWater) / \(totalLimitWater)ml"
        self.submitButton.layer.cornerRadius = 8.0
    }
    
    func imageFillFromStackView(counter: Int) {
        //let subViews = self.stckView.subviews
        initilizeWithDefault()
        
        for index in 1...10 {
            var cnt = index
            switch index {
            case 1:
                if index <= counter {
                    self.img1.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            case 2:
                if index <= counter {
                    self.img2.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            case 3:
                if index <= counter {
                    self.img3.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            case 4:
                if index <= counter {
                    self.img4.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            case 5:
                if index <= counter {
                    self.img5.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            case 6:
                if index <= counter {
                    self.img6.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            case 7:
                if index <= counter {
                    self.img7.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            case 8:
                if index <= counter {
                    self.img8.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            case 9:
                if index <= counter {
                    self.img9.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            default:
                if index <= counter {
                    self.img10.image = UIImage(imageLiteralResourceName: "fill")
                }
                break
            }
        }
        
        
    }
    
    func initilizeWithDefault() {
        self.img1.image = UIImage(imageLiteralResourceName: "blanl")
        self.img2.image = UIImage(imageLiteralResourceName: "blanl")
        self.img3.image = UIImage(imageLiteralResourceName: "blanl")
        self.img4.image = UIImage(imageLiteralResourceName: "blanl")
        self.img5.image = UIImage(imageLiteralResourceName: "blanl")
        self.img6.image = UIImage(imageLiteralResourceName: "blanl")
        self.img7.image = UIImage(imageLiteralResourceName: "blanl")
        self.img8.image = UIImage(imageLiteralResourceName: "blanl")
        self.img9.image = UIImage(imageLiteralResourceName: "blanl")
        self.img10.image = UIImage(imageLiteralResourceName: "blanl")
        
    }
    
    
    func postWaterData(){
        DietFitnessVM().postMealWorkout(user: DietFitnessData.shared.userId, mealId: "1", dietID: "9", quantity: "\(counter)") { (result) in
            switch result {
            case .success(let dietDetail):
                DispatchQueue.main.async {
                    if dietDetail?.statusCode == 200 {
                        
                        
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
    
    @IBAction func backBtnAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(sender: UIButton) {
        postWaterData()
    }
    // MARK:- WATER INCREMENT BUTTON ACTION
    
    @objc func waterIncrementButtonTapped(_ sender:UIButton){
        counter = counter + 1
        self.userselectWater = self.userselectWater + 250
        if userselectWater == self.totalLimitWater {
            self.waterIncrementBtn.isUserInteractionEnabled = false
        }
        else{
            self.waterIncrementBtn.isUserInteractionEnabled = true
            self.waterDecrementBtn.isUserInteractionEnabled = true
        }
        self.waterLimitLbl.text = "\(userselectWater) / \(totalLimitWater)ml"
        self.caluclateTotalWaterPercentage()
        imageFillFromStackView(counter: counter)
    }
    // MARK:- WATER DECREMENT BUTTON ACTION
    @objc func waterdecrementButtontapped(_ sender:UIButton){
        counter = counter - 1
        self.userselectWater = self.userselectWater - 250
        if self.userselectWater == 0.0 {
            self.waterDecrementBtn.isUserInteractionEnabled = false
            self.waterIncrementBtn.isUserInteractionEnabled = true
        }
        else{
            self.waterDecrementBtn.isUserInteractionEnabled = true
            self.waterIncrementBtn.isUserInteractionEnabled = true
        }
        self.waterLimitLbl.text = "\(userselectWater) / \(totalLimitWater)ml"
        self.caluclateTotalWaterPercentage()
        imageFillFromStackView(counter: counter)

    }
    // MARK:- CALCULATE PERCENTAGE
    func caluclateTotalWaterPercentage() -> Void {
        percentagecorrect = (userselectWater / totalLimitWater) * 100
        let left = percentagecorrect - Double(Int(percentagecorrect))
        if left >=  0.50 {
            percentagecorrect = percentagecorrect + 1.0
        }
        self.waterPercentageLbl.text = "\(round(percentagecorrect!)) %"
    }
   
}
