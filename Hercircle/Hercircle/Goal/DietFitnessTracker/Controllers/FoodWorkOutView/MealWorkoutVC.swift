//
//  MealWorkoutVC.swift
//  Hercircle
//
//  Created by Gaurav on 04/08/21.
//

import UIKit

class MealWorkoutVC: UIViewController {
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var lblTotalCalori: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var selectedID = 0
    var dictFoodItem = [String:String]()
    var dictQuantity = [Int:Int]()
    var arrTuples: [(Int,Double,String,Int)] = []
    var strMealID = ""
    var strTitle = ""
    var isMeal = true
    var totalCalories: Double = 0.0
    
    var searchedView = SearchedView.instanceFromNib()
    let myGroup = DispatchGroup()
    @IBOutlet weak var headerView: UIView!

   

    
//    var getDinnerView = DinnerView.instanceFromNib()
//    var customTableHeader = CustomHeader.CustomHeaderinstanceFromNib()
//    var customTableFooter = CustomFooter.CustomFooterinstanceFromNib()
//    var getNameSearchview = NameSearchView.registerNameSearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)
        self.lblTitle.text = self.strTitle
        self.tblView.register(UINib(nibName: "DinnerListTableViewCell", bundle: nil), forCellReuseIdentifier: "DinnerListTableViewCell")
        searchedView.registerCell()
        searchedView.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
    }
    
    
    func getExactValueOfTuple(Id: Int) {
        var cnt = 0
        for obj in self.arrTuples {
            if obj.0 == Id {
                arrTuples.remove(at: cnt)
                dictQuantity.removeValue(forKey: Id)
                self.tblView.reloadData()
               // retVal = false
            } else {
                cnt = cnt + 1
                
            }
            
        }
    }
    func searchValueInsideTuple(Id: Int) -> Bool{
        var retVal = true
        for obj in self.arrTuples {
            if obj.0 == Id {
                retVal = false
            } else {
                retVal = true
            }
        }
        return retVal
    }
    
    func getCalorie(Id: Int) -> Double {
        var temp:Double = 0.0
        for obj in self.arrTuples {
            if obj.0 == Id {
                temp = obj.1
            } else {
            }
        }
        return temp
    }
    
    func setCount(id: Int, isIncreased: Bool){
        for obj in self.arrTuples {
            var temp = obj
            if let value = dictQuantity[id] {
               // if value > 1 {
            if temp.0 == id{
                if isIncreased {
                     var incre = value
                    dictQuantity.updateValue(incre + 1, forKey: id)
                } else {
                    var incre = value
                   dictQuantity.updateValue(incre - 1, forKey: id)
                }
            }
            }
        }
       // }
        
    }
    
    @IBAction func incrementDecrement(sender: UIButton) {
        
        if sender.accessibilityIdentifier == "Decrement" {
            self.setCount(id: selectedID, isIncreased: false)
        } else {
            self.setCount(id: selectedID, isIncreased: true)

        }
        self.tblView.reloadData()
    }
    
    @IBAction func postMeal(sender: UIButton) {
        
        for obj in arrTuples {
            myGroup.enter()
            let quantity = String(dictQuantity[obj.0]!)
            if self.isMeal {
            DietFitnessVM().postMealWorkout(user: DietFitnessData.shared.userId, mealId: strMealID, dietID: "\(obj.0)", quantity: quantity) { (result) in
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
                self.myGroup.leave()
            }
                
            } else {
                    DietFitnessVM().postWorkout(user: DietFitnessData.shared.userId, ExceciseType_Id: "1", excercise_ID: "\(obj.0)", quantity: quantity) { (result) in
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
                        self.myGroup.leave()
                    }
                }
            }
        
        myGroup.notify(queue: .main) {
                print("Finished all requests.")
            }
        

    }
    
   
    
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
extension MealWorkoutVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.txtField.resignFirstResponder()
        searchedView.isMealWorkout = self.isMeal
        searchedView.showVideoTutorial()
        searchedView.searchedResult(str: self.txtField.text ?? "")
        
        return true
    }
    
    
    
}
extension MealWorkoutVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTuples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let questionCell = tableView.dequeueReusableCell(withIdentifier: "DinnerListTableViewCell", for: indexPath) as?  DinnerListTableViewCell{
            let tupple = self.arrTuples[indexPath.row]
            questionCell.nameLbl.text = tupple.2
            questionCell.categoriesLbl.text = String(tupple.1)
            questionCell.quantityLbl.text = String(dictQuantity[tupple.0] ?? 1)
            questionCell.btnIncrement.tag = tupple.0
            questionCell.btnDecrement.tag = tupple.0
            questionCell.delegate = self
            cell = questionCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension MealWorkoutVC: NameSearchViewDelegate {
    func selectedFoodWorkItem(strID: Int, calori: Double, name: String) {
        if self.searchValueInsideTuple(Id: strID) {
            let selectedValues: (Int, Double, String, Int) = (strID, calori, name, 1)
            self.arrTuples.append(selectedValues)
            self.lblCounter.text = "1"
            selectedID = strID
            dictQuantity.updateValue(1, forKey: strID)
            totalCalories = totalCalories + calori
            self.lblTotalCalori.text = "\(totalCalories) cal"
            self.txtField.text = ""
            self.tblView.reloadData()
        } else {}
    }
}
extension MealWorkoutVC: DinnerListTableViewCellDelegate {
    func setQuantity(btn: UIButton) {
        var value = Int(dictQuantity[btn.tag]!)
        var calori = self.getCalorie(Id: btn.tag)
        if btn.accessibilityIdentifier == "Increment" {
            value = value + 1
            dictQuantity.updateValue(value, forKey: btn.tag)
            totalCalories = totalCalories + calori
        } else {
                    //if value > 1 {
                    value = value - 1
                    totalCalories = totalCalories - calori
                    if value <= 0 {
                        self.getExactValueOfTuple(Id: btn.tag)
                    } else {
                    dictQuantity.updateValue(value - 1, forKey: btn.tag)
                    }
            if arrTuples.count == 0 {
                totalCalories = 0.0
                
            }
                }
        self.lblTotalCalori.text = "\(totalCalories) cal"
        self.tblView.reloadData()
    }
    
}

