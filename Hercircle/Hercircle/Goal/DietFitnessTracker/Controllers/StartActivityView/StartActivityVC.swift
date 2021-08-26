//
//  StartActivityVC.swift
//  Hercircle
//
//  Created by Gaurav on 03/08/21.
//

import UIKit

class StartActivityVC: UIViewController {

    var getlifeStyleView = LifeStyleView.LifestyleNib()
    var getHeaderView = LifestyleHeader.LifestyleHeaderNib()
    var getFooterView = LifeStyleFooterView.LifestyleFooterNib()
    
    var lifestyleArray:[String] = [String]()
    var unitsArray:[String] = [String]()
    
    var getcommonDateView = CommonDatePickerView.commonDatePickerNib()
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var viewTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = FitnessHeader.instanceFromNib()
        self.viewTop.addSubview(header)
        getFooterView.delegate = self
        // Do any additional setup after loading the view.
        self.getlifeStyleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.getlifeStyleView)
        self.getlifeStyleView.topAnchor.constraint(equalTo: self.activityView.topAnchor, constant: 0).isActive = true
        self.getlifeStyleView.bottomAnchor.constraint(equalTo: self.activityView.bottomAnchor, constant: 0).isActive = true
        self.getlifeStyleView.leadingAnchor.constraint(equalTo: self.activityView.leadingAnchor, constant: 0).isActive = true
        self.getlifeStyleView.trailingAnchor.constraint(equalTo: self.activityView.trailingAnchor, constant: 0).isActive = true
        
        self.getlifeStyleView.lifestyleTblView.delegate = self
        self.getlifeStyleView.lifestyleTblView.dataSource = self
        self.getlifeStyleView.lifestyleTblView.separatorStyle = .none
        self.getlifeStyleView.lifestyleTblView.showsVerticalScrollIndicator = false
        self.registerTableviewCell()
//        self.getlifeStyleView.lifestyleTblView.tableHeaderView = self.getHeaderView
//        self.getlifeStyleView.lifestyleTblView.tableFooterView = self.getFooterView
        self.getHeaderView.weightSegmentCOntrol.layer.cornerRadius = 8.0
        self.getHeaderView.weightSegmentCOntrol.layer.borderWidth = 1.0
        self.getHeaderView.weightSegmentCOntrol.layer.borderColor = UIColor.systemGreen.cgColor
        self.getHeaderView.weightSegmentCOntrol.addTarget(self, action: #selector(segmentControllerAction(_:)), for: .valueChanged)
        
        self.getFooterView.nextButton.layer.cornerRadius = 8.0
        self.getFooterView.datepickerBaseView.backgroundColor = .systemGroupedBackground
        self.getFooterView.datepickerBaseView.layer.borderWidth = 0.8
        self.getFooterView.datepickerBaseView.layer.borderColor = UIColor.systemGreen.cgColor
        self.getFooterView.datepickerBaseView.layer.cornerRadius = 8.0
        self.commondatepickerSetup()
        self.getFooterView.dateBtn.addTarget(self, action: #selector(datepickerButtonTapped), for: .touchUpInside)
        self.lifestyleArray = ["Lose Weight","Height","Weight"]
        self.unitsArray = ["kg","cm","kg"]
        NotificationCenter.default.addObserver(self, selector: #selector(StartActivityVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(StartActivityVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    override func viewDidDisappear(_ animated: Bool) {
       // NotificationCenter.removeObserver(<#T##self: NotificationCenter##NotificationCenter#>)
    }
    // MARK:- COMMON DATE PICKER SETU VIEW
    func commondatepickerSetup(){
        self.getcommonDateView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.getcommonDateView)
        self.getcommonDateView.isHidden = true
        self.getcommonDateView.backgroundColor = UIColor.systemGroupedBackground.withAlphaComponent(0.3)
        self.getcommonDateView.topAnchor.constraint(equalTo: self.activityView.topAnchor, constant: 0).isActive = true
        self.getcommonDateView.bottomAnchor.constraint(equalTo: self.activityView.bottomAnchor, constant: 0).isActive = true
        self.getcommonDateView.leadingAnchor.constraint(equalTo: self.activityView.leadingAnchor, constant: 0).isActive = true
        self.getcommonDateView.trailingAnchor.constraint(equalTo: self.activityView.trailingAnchor, constant: 0).isActive = true
        
        self.getcommonDateView.mydatepicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            self.getcommonDateView.mydatepicker.preferredDatePickerStyle = .wheels
        }
        self.getcommonDateView.doneBtn.addTarget(self, action: #selector(datepickerValueChangedAction(_:)), for: .touchUpInside)
        self.getcommonDateView.cancelBtn.addTarget(self, action: #selector(datepickerCancelAction(_:)), for: .touchUpInside)
    }
      // MARK:- DATE BUTTON ACTION
      @objc func datepickerButtonTapped(){
          self.getcommonDateView.isHidden = false
          self.view.bringSubviewToFront(self.getcommonDateView)
      }
      // MARK:- DATE PICKER DONE BUTTON ACTION
      @objc func datepickerValueChangedAction(_ sender:UIButton){
          let formatter = DateFormatter()
          formatter.dateFormat = "d MMMM yyyy"
          self.getFooterView.dateResultLbl.text = formatter.string(from: self.getcommonDateView.mydatepicker.date)
          self.getcommonDateView.isHidden = true
      }
    // MARK:- DATE PICKER CANCEL BUTTON ACTION
    @objc func datepickerCancelAction(_ sender:UIButton){
        self.getcommonDateView.isHidden = true
    }
    // MARK:- REGISTER CUSTOM CELL
    func registerTableviewCell(){
        self.getlifeStyleView.lifestyleTblView.register(UINib.init(nibName: "LifeStyleTableViewCell", bundle: nil), forCellReuseIdentifier: "LifeStyleTableViewCell")
    }
    //MARK:= SEGMENT CONTROL ACTION
    @objc func segmentControllerAction(_ sender:UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            self.lifestyleArray = ["Lose Weight","Height","Weight"]
            self.unitsArray = ["kg","cm","kg"]
            sender.selectedSegmentTintColor = UIColor.systemGreen
            sender.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
            break
        case 1:
            self.lifestyleArray = ["Gain Weight","Height","Weight"]
            self.unitsArray = ["kg","cm","kg"]
            sender.selectedSegmentTintColor = UIColor.systemGreen
            sender.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
            break
        case 2:
            self.lifestyleArray = ["Height","Weight"]
            self.unitsArray = ["cm","kg"]
            sender.selectedSegmentTintColor = UIColor.systemGreen
            break
        default:
            break
        }
        DispatchQueue.main.async {
            self.getlifeStyleView.lifestyleTblView.reloadData()
        }
    }
}
// MARK:- TABLEVIEW DELEGATE AND DATASOURCE
extension StartActivityVC:UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lifestyleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LifeStyleTableViewCell") as! LifeStyleTableViewCell
        
        cell.nameLabel.text = self.lifestyleArray[indexPath.row]
        cell.unitLabel.text = self.unitsArray[indexPath.row]
        cell.weightInputTxtFld.delegate = self
        cell.weightInputTxtFld.keyboardType = .decimalPad
       
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        cell.weightInputTxtFld.inputAccessoryView = doneToolbar
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.getHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.getFooterView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 160
    }
    // MARK:- TOOL BAR DONE BUTTON ACTION
    @objc func doneButtonAction(){
        self.getlifeStyleView.lifestyleTblView.endEditing(true)
    }
    // MARK:- TEXTFIELDS DELEGATES
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 3
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @objc func keyboardWillShow(notification: NSNotification) {
                
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
               return
            }
          self.view.frame.origin.y = 0 - keyboardSize.height
        }

        @objc func keyboardWillHide(notification: NSNotification) {
          // move back the root view origin to zero
          self.view.frame.origin.y = 0
        }
}
extension StartActivityVC:LifeStyleFooterViewDelegate {
    func tapOnNextBtn() {
        
                if let vc = ActivityVC(nibName: "ActivityVC", bundle: nil) as? ActivityVC
                {
                     self.navigationController?.pushViewController(vc, animated: true)
                }
    }
    
}
