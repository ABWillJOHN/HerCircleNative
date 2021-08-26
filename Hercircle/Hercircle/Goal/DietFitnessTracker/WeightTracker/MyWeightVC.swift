//
//  MyWeightVC.swift
//  Hercircle
//
//  Created by Apple on 12/08/21.
//

import UIKit
import FSCalendar


class MyWeightVC: UIViewController,UITextFieldDelegate,FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var lblCalanderTitle: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var lblSlectedDate: UILabel!
    @IBOutlet weak var monthChangesContainView: UIView!

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var myweightTitleLbl: UILabel!
    @IBOutlet weak var dateImg: UIImageView!
    @IBOutlet weak var dateDownBtn: UIButton!
    @IBOutlet weak var dateUpButton: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weightImg: UIImageView!
    @IBOutlet weak var dateLeftArrowBtn: UIButton!
    @IBOutlet weak var dateresultLbl: UILabel!
    @IBOutlet weak var dateRightArrowBtn: UIButton!
    @IBOutlet weak var weightTxtFld: UITextField!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var seperatorLbl: UILabel!
    
    @IBOutlet weak var btnOpenCloseCalendar: UIButton!
    @IBOutlet weak var headerView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)
        // Do any additional setup after loading the view.
        
        self.weightTxtFld.keyboardType = .numberPad
        self.weightTxtFld.delegate = self
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.weightTxtFld.inputAccessoryView = doneToolbar
        
        self.weightTxtFld.layer.cornerRadius = 8.0
        self.weightTxtFld.layer.borderWidth = 1.0
        self.weightTxtFld.layer.borderColor = UIColor.lightGray.cgColor
        self.submitBtn.layer.cornerRadius = 8.0
        self.createPaddingTextFiled(textField: self.weightTxtFld)
        NotificationCenter.default.addObserver(self, selector: #selector(MyWeightVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MyWeightVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //MARK:- Calendar
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView.headerHeight = 0.0
        self.calendarView.allowsMultipleSelection = false
        self.calendarView.calendarHeaderView.isHidden = true
        self.calendarView.appearance.weekdayTextColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.calendarView.appearance.titleFont = UIFont.systemFont(ofSize: 16)
        self.calendarView.appearance.weekdayFont = UIFont.systemFont(ofSize: 16)
        self.calendarView.select(Date())
        self.lblSlectedDate.text = self.dateConvertToGivenFormate(formatte: "dd MMM yyyy", date: Date())
    }
    
    @IBAction func btnOpenAndCloseCalendarAction(_ sender: UIButton) {
        self.weightImg.isHidden = true
        self.calendarView.isHidden = false
        self.monthChangesContainView.isHidden = false
        self.btnOpenCloseCalendar.isHidden = true
    }
    
    @IBAction func btnPrevoiusMonthAction(_ sender: UIButton) {
        self.previousMonth()
        
    }
    
    @IBAction func btnNextMonthAction(_ sender: UIButton) {
        self.nextMonth()
    }
    
    // MARK:- TOOL BAR DONE BUTTON ACTION
    @objc func doneButtonAction(){
        self.weightTxtFld.resignFirstResponder()
    }
    // MARK:- TEXTFIELD DELEGATE MATHOD
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.utf16.count)! + string.utf16.count - range.length
        if newLength >= 3 {
            let newstr = (textField.text ?? "") + string
            if let value = Int(newstr), value > 300 {
                return false
            }else
            {
                return true
            }
        } else {
            return true
        }
    }
    
    func createPaddingTextFiled(textField:UITextField){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    // MARK:- SHOW KEYBOARD ANIMATION
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    // MARK:- HIDE KEYBOARD ANIMATION
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    
    //MARK:- Date Convert function
    func dateConvertToGivenFormate(formatte:String, date:Date) -> String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = formatte
        print(formatter3.string(from: date))
        return formatter3.string(from: date)
    }
    
    //MARK:- Chnages start Calander Methods
    func nextMonth() {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self.calendarView.currentPage)
        self.calendarView.setCurrentPage(nextMonth!, animated: true)
    }
    
    func previousMonth() {
        let nextMonth = Calendar.current.date(byAdding: .month, value: -1, to: self.calendarView.currentPage)
        self.calendarView.setCurrentPage(nextMonth!, animated: true)
    }
    
    @IBAction func backBtnAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(sender: UIButton) {
        setWeightToServer()
    }
    
    func setWeightToServer() {
        DietFitnessVM().postLiftStyleData(user: DietFitnessData.shared.userId, dob: "", weight: "", currentWeight:self.weightTxtFld.text ?? "" , height: "", goal:"", target_Weight: "", target_Dt: "", lifeStyle:"") { (result) in
              switch result {
              case .success(let dietDetail):
                  DispatchQueue.main.async {
                      if dietDetail?.statusCode == 200 {
                        self.navigationController?.popViewController(animated: true)
                          
                        //self.tabBarController?.navigationController?.popViewController(animated: true)
                          
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
    
    //MARK:- Calendar delegate methods
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        print("calendarCurrentPageDidChange \(calendar.currentPage)")
//        let currentPageDate = calendar.currentPage
//        self.lblCalanderTitle.text = self.dateConvertToGivenFormate(formatte: "MMMM-yyyy", date: calendar.currentPage)
//        self.lblSlectedDate.text = self.dateConvertToGivenFormate(formatte: "dd-MMM-yyy", date: currentPageDate)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let newDate = date.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
        self.lblCalanderTitle.text = self.dateConvertToGivenFormate(formatte: "MMMM-yyyy", date: newDate)
        self.lblSlectedDate.text = self.dateConvertToGivenFormate(formatte: "dd-MMM-yyy", date: newDate)
//        self.selectedDate = newDate
        self.weightImg.isHidden = false
        self.calendarView.isHidden = true
        self.monthChangesContainView.isHidden = true
        self.btnOpenCloseCalendar.isHidden = false
        
    }

}
