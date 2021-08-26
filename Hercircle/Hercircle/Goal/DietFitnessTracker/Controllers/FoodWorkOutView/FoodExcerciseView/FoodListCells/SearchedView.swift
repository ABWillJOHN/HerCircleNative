//
//  SearchedView.swift
//  Hercircle
//
//  Created by Apple on 08/08/21.
//

import UIKit
protocol NameSearchViewDelegate: class {
    func selectedFoodWorkItem(strID: Int, calori: Double, name: String)
}

class SearchedView: UIView {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnDone: UIButton!
    weak var delegate: NameSearchViewDelegate?
    var isMealWorkout = true
    var arr = [dietMaster]()
    var arrExcercise = [exerciseMaster]()
    
    
    class func instanceFromNib() -> SearchedView {
        return UINib(nibName: "SearchedView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SearchedView
    }
    
    func registerCell() {
        self.tblView.register(UINib(nibName: "SearchedCell", bundle: nil), forCellReuseIdentifier: "SearchedCell")
    }
    @IBAction func cancelBtnAction() {
        
        self.hideOnePagePopUp()
    }
    func searchedResult(str: String) {
        let arrToSearch = DietFitnessData.shared.userDietFitness?.dietMaster
        
        let arrToWorkOut = DietFitnessData.shared.userDietFitness?.exerciseMaster
        
        
        if isMealWorkout == true {
        let result = arrToSearch?.filter({ obj  in
            return (obj.name?.lowercased().contains(str))!
        })
         arr = result ?? [dietMaster]()

        } else {
            let result = arrToWorkOut?.filter({ obj  in
                return (obj.exercise_Name?.lowercased().contains(str))!
            })
            arrExcercise = result ?? [exerciseMaster]()
        }
        self.tblView.reloadData()

    }
    
    
    
    func hideOnePagePopUp() {

        UIView.animate(withDuration: 0.3, animations: {
            // self.dialogView.transform = scaleOfIdentity
        }) { finished in
            self.removeFromSuperview()
        }
    }
    func showVideoTutorial(){
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        self.frame = CGRect(x: 0, y: 0, width: (rootVC?.view.frame.width)!, height: (rootVC?.view.frame.height)!)
        rootVC?.view.addSubview(self)
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
extension SearchedView: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var count = 0
        if isMealWorkout {
            count = arr.count
        } else {
            count = arrExcercise.count
        }
        return count
    }

    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let questionCell = tableView.dequeueReusableCell(withIdentifier: "SearchedCell", for: indexPath) as?  SearchedCell{
        
            if isMealWorkout {
            questionCell.nameLbl.text = arr[indexPath.row].name
            } else {
                questionCell.nameLbl.text = arrExcercise[indexPath.row].exercise_Name

            }
            cell = questionCell

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isMealWorkout {
            let diet = arr[indexPath.row]
            self.delegate?.selectedFoodWorkItem(strID: diet.diet_ID, calori: diet.calories,name: diet.name ?? "")

        } else {
            let excercise = arrExcercise[indexPath.row]
            self.delegate?.selectedFoodWorkItem(strID: excercise.exercise_ID, calori: Double(excercise.calories_Burnt),name: excercise.exercise_Name ?? "")
        }
        self.hideOnePagePopUp()
    }
}

