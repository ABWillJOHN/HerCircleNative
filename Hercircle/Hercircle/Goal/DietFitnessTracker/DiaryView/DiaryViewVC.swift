//
//  DiaryViewVC.swift
//  Hercircle
//
//  Created by Apple on 10/08/21.
//

import UIKit
import FSCalendar
protocol RedirectToViewProtocol {
    func redirectToView(sender: UIControl)
}

class DiaryViewVC: UIViewController{
    var selctedDt = ""
    @IBOutlet weak var fitnessHeader: UIView!
    @IBOutlet weak var containerView: UIView!
    let analytics = AnalyticsVC()
    let graphVC = GraphVC()
    let settingVC = SettingDietFitnessVC()
    let insightVC = InsightsViewController()
    var community = UIViewController()
    var strUserID = ""
    let session = URLSession.shared
    var arrMeals = [meal]()
    var arrExcercise = [exercise]()
    func getCommunityVC() -> CommunityVC
    {
        let storyboard = UIStoryboard(name: "Community", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CommunityVC") as! CommunityVC
        return vc
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        community = self.getCommunityVC()
        strUserID = DietFitnessData.shared.userId + "/"
        let header = FitnessHeader.instanceFromNib()
        header.delegate = self
        analytics.delegate = self
        settingVC.delegate = self
        insightVC.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CalenderDiaryViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CalenderDiaryViewTableViewCell")
        self.tableView.register(UINib(nibName: "DetailsDairyTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsDairyTableViewCell")
    }
    
    
    
    
    func moveToDietDetail(str: String,strID: String,isFood: Bool) {
        if let vc = MealWorkoutVC(nibName: "MealWorkoutVC", bundle: nil) as? MealWorkoutVC {
            vc.strTitle = str
            vc.strMealID = strID
            vc.isMeal = isFood
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getCaloriDetails() {
        let url = URL(string: BaseUrl.baseUrl.baseUrlString + endPoint.dietUserDetails.rawValue + strUserID + selctedDt)!
        // var url = URL(string: "http://10.160.137.82:8080/dt/api/diet/9827E332-459E-456A-930E-018784A97C2B/2021-07-29")
        
        self.arrMeals.removeAll()
        self.arrExcercise.removeAll()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = MethodType.get.rawValue
        
        urlRequest.addValue(ContentType.applicationJson.rawValue, forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("F5357124-AE3C-4239-90DE-79151EFF560B" , forHTTPHeaderField: "AppKey")
        urlRequest.addValue(DEVICE_ID?.description ?? "" , forHTTPHeaderField: "ClientIP")
        let sessionId =  "iOS-\(DEVICE_ID?.description ?? "")"
        urlRequest.addValue(sessionId , forHTTPHeaderField: "SessionID")
        self.session.dataTask(with: urlRequest) { data, response, error in
            if error == nil {
                
                //data check
                guard let data = data else { return }
                
                let responseData = String(data: data, encoding: String.Encoding.utf8)
                print(responseData as Any)
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    
                    if let meals = responseJSON["mealDetails"] as? [String: Any] {
                        for (key,value) in meals {
                            if let dict = value as? [String: Any]{
                                var mealsDt = ""
                                var id = ""
                                var qnt = ""
                                var cal = ""
                                for (key,value) in dict {
                                    if key == "DietName" {
                                        mealsDt = value as? String ?? ""
                                    } else if key == "DietID" {
                                        id = value as? String ?? ""
                                    } else if key == "Qunatity" {
                                        qnt = value as? String ?? ""
                                    } else {
                                        cal = value as? String ?? ""
                                    }
                                    
                                }
                                let mealDetail = meal(dietName: mealsDt, id: id, qunt: qnt, cal: cal)
                                
                                self.arrMeals.append(mealDetail)
                            }
                        }
                    }
                    
                    if let meals = responseJSON["exerciseDetails"] as? [String: Any] {
                        for (key,value) in meals {
                            if let dict = value as? [String: Any]{
                                var mealsDt = ""
                                var id = ""
                                var qnt = ""
                                var cal = ""
                                for (key,value) in dict {
                                    if key == "ExerciseName" {
                                        mealsDt = value as? String ?? ""
                                    } else if key == "ExerciseID" {
                                        id = value as? String ?? ""
                                    } else if key == "Qunatity" {
                                        qnt = value as? String ?? ""
                                    } else {
                                        cal = value as? String ?? ""
                                    }
                                }
                                let excerciseDetail = exercise(excerName: mealsDt, id: id, qunt: qnt, cal: cal)
                                self.arrExcercise.append(excerciseDetail)
                            }
                        }
                    }
                }
            } else {}
        }.resume()
    }
    func getUserCaloriDetail(){
        
        DietFitnessVM().getCaloriConsumed(name: strUserID + selctedDt) { (result) in
            switch result {
            case .success(let dietDetail):
                DispatchQueue.main.async {
                    if dietDetail?.statusCode == 200 {
                        DietFitnessData.shared.userCalories = dietDetail
                        self.tableView.reloadData()
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
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
extension DiaryViewVC: FitnessHeaderDelegate {
    func topTabOptions(strAccess: String) {
        self.containerView.isHidden = false
        
        switch strAccess {
        case "Diary":
            self.containerView.isHidden = true
            break
        case "Analytics":
            self.containerView.addSubview(analytics.view)
            break
        case "Insights":
            self.containerView.addSubview(insightVC.view)
            break
        case "Communities":
            self.containerView.addSubview(community.view)
            break
        default:
            self.containerView.addSubview(settingVC.view)
            break
        }
        
    }
    
}

extension DiaryViewVC: AnalyticsVCDelegate{
    func viewNavigate(index: Int) {
        
        var isNilFound = false
        
        switch index {
        case 0:
            if let detail = DietFitnessData.shared.userDietFitness?.analytics.weightDetails {
                isNilFound = false
            } else {
                isNilFound = true
                self.showAlert(msg: "No Data Found for Weight.")
            }
            break
        case 1:
            if let detail = DietFitnessData.shared.userDietFitness?.analytics.exerciseDetails {
                isNilFound = false
            } else {
                isNilFound = true
                self.showAlert(msg: "No Data Found for Excercise.")
            }
            break
        case 2:
            
            if let detail = DietFitnessData.shared.userDietFitness?.analytics.mealDetails {
                isNilFound = false
            } else {
                isNilFound = true
                self.showAlert(msg: "No Data Found for Meal.")
            }
            break
        default:
            if let detail = DietFitnessData.shared.userDietFitness?.analytics.waterIntake {
                isNilFound = false
            } else {
                isNilFound = true
                self.showAlert(msg: "No Data Found for Water.")
            }
            break
        }
        
        if !isNilFound {
            let graphVC = GraphVC()
            graphVC.grafType = index
            self.navigationController?.pushViewController(graphVC, animated: true)
        }
    }
    
}
extension DiaryViewVC: SettingDietFitnessVCDelegate{
    func settingViewNavigation() {
        
    }
    
}
extension DiaryViewVC: InsightsViewControllerDelegate {
    func getContentURL(strURL: String) {
        let vc = UIStoryboard.init(name: "Grow", bundle: Bundle.main).instantiateViewController(withIdentifier: "GrowWebVC") as? GrowWebVC
        vc?.strUrl = strURL
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}

struct meal {
    var dietNm : String = ""
    var dietID: String = ""
    var quantity: String = ""
    var calory: String = ""
    
    init(dietName: String, id: String, qunt: String, cal: String) {
        self.dietNm = dietName
        self.dietID = id
        self.quantity = qunt
        self.calory = cal
    }
}


struct exercise {
    var excerciseNm : String = ""
    var excerID: String = ""
    var quantity: String = ""
    var calory: String = ""
    
    init(excerName: String, id: String, qunt: String, cal: String) {
        self.excerciseNm = excerName
        self.excerID = id
        self.quantity = qunt
        self.calory = cal
    }
}
extension DiaryViewVC : RedirectToViewProtocol,ChangeDateProtocol{
    func dateChnageTo(dateString: String) {
        selctedDt = dateString
        getUserCaloriDetail()
        getCaloriDetails()
    }
    
    func redirectToView(sender: UIControl) {
        switch sender.tag {
        case 100:
            let analyticsVC = AnalyticsVC()
            self.navigationController?.pushViewController(analyticsVC, animated: true)
            break
        case 101:
            if let vc = MyWeightVC(nibName: "MyWeightVC", bundle: nil) as? MyWeightVC {
                self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 102:
            moveToDietDetail(str: "Workout", strID: "1", isFood: false)
            break
        case 103:
            if let vc = WaterTrackerVC(nibName: "WaterTrackerVC", bundle: nil) as? WaterTrackerVC {
                self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 104:
            moveToDietDetail(str: "Breakfast", strID: "1", isFood: true)
            break
        case 105:
            moveToDietDetail(str: "Lunch", strID: "2", isFood: true)
            break
        case 106:
            moveToDietDetail(str: "Dinner", strID: "3", isFood: true)
            break
        case 107:
            moveToDietDetail(str: "Snacks", strID: "4", isFood: true)
            break
        default:
            break
        }
    }
}

extension DiaryViewVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderDiaryViewTableViewCell", for: indexPath) as! CalenderDiaryViewTableViewCell
            cell.changeDateProtocol = self
            cell.selctedDt = selctedDt
            cell.userCaloriDetailChanged()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsDairyTableViewCell", for: indexPath) as! DetailsDairyTableViewCell
            cell.redirectToViewProtocol = self
            return cell
        }
    }
    
    
}
