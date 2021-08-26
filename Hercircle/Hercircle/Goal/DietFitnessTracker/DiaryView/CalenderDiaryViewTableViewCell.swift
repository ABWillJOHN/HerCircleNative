//
//  CalenderDiaryViewTableViewCell.swift
//  Hercircle
//
//  Created by Abhinav.prashar on 22/08/21.
//

import UIKit
import FSCalendar
protocol ChangeDateProtocol {
    func dateChnageTo(dateString:String)
}
class CalenderDiaryViewTableViewCell: UITableViewCell,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance  {
    
    @IBOutlet weak var lblCalanderTitle: UILabel!
    @IBOutlet weak var monthContainView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var btnCalendarOpenCloseOutLet: UIButton!
    @IBOutlet weak var lblSlectedDate: UILabel!
    @IBOutlet weak var caloryContainView: UIView!
    @IBOutlet weak var lblCaloriesLeft: UILabel!
    @IBOutlet weak var lblCaloriesConsumed: UILabel!
    @IBOutlet weak var lblCaloriesRecomended: UILabel!
    var selctedDt = String()
    var changeDateProtocol:ChangeDateProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView.headerHeight = 0.0
        self.calendarView.allowsMultipleSelection = false
        self.calendarView.calendarHeaderView.isHidden = true
        //        self.calendarView.appearance.weekdayTextColor = .orange
        self.calendarView.appearance.titleFont = UIFont.systemFont(ofSize: 16)
        self.calendarView.appearance.weekdayFont = UIFont.systemFont(ofSize: 16)
        self.calendarView.select(Date())
        self.lblSlectedDate.text = self.dateConvertToGivenFormate(formatte: "dd MMM yyyy", date: self.calendarView.currentPage)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func dateConvertToGivenFormate(formatte:String, date:Date) -> String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = formatte
        print(formatter3.string(from: date))
        return formatter3.string(from: date)
    }
    
    @IBAction func btnCalendarOpenCloseAction(_ sender: UIButton) {
        self.btnCalendarOpenCloseOutLet.isHidden = true
        self.calendarView.isHidden = false
        self.caloryContainView.isHidden = true
        self.monthContainView.isHidden = false
        self.lblSlectedDate.text = self.dateConvertToGivenFormate(formatte: "dd MMM yyyy", date: self.calendarView.currentPage)
    }
    
    
    
    @IBAction func btnPreviousMonth(_ sender: UIButton) {
        self.previousMonth()
    }
    
    @IBAction func btnNextMonthAction(_ sender: UIButton) {
        self.nextMonth()
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
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPageDate = calendar.currentPage
        self.lblCalanderTitle.text = self.dateConvertToGivenFormate(formatte: "MMMM-yyyy", date: calendar.currentPage)
        
    }
    
    func selectDateChange(dateChnage:(Int) -> Void) {
        
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("selected date")
        let newDate = date.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
        self.lblSlectedDate.text = self.dateConvertToGivenFormate(formatte: "dd MMM yyyy", date: newDate)
        selctedDt = self.dateConvertToGivenFormate(formatte: "yyyy-MM-dd", date: newDate)
        self.calendarView.isHidden = true
        self.btnCalendarOpenCloseOutLet.isHidden = false
        self.caloryContainView.isHidden = false
        self.monthContainView.isHidden = true
        changeDateProtocol?.dateChnageTo(dateString: selctedDt)
    }
}
extension CalenderDiaryViewTableViewCell{
    func userCaloriDetailChanged() {
        let dietDetail = DietFitnessData.shared.userCalories
        self.lblCaloriesLeft.text = dietDetail?.data.RecommendCaloryExercise
        self.lblCaloriesRecomended.text = dietDetail?.data.RecommendCalory
        self.lblCaloriesConsumed.text = "Calories Consumed: " + (dietDetail?.data.TotalcalConsume ?? "")
    }    
}
