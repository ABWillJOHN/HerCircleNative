//
//  GraphVC.swift
//  Hercircle
//
//  Created by Apple on 13/08/21.
//

import UIKit
import FSCalendar
import Charts

class GraphVC: UIViewController,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    var selectedDate = Date()
    
    @IBOutlet weak var lblCustomNavTitle: UILabel!
    @IBOutlet weak var lblCalanderTitle: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var lblSlectedDate: UILabel!
    @IBOutlet weak var btnOpenCloseCalendar: UIButton!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var monthChangesContainView: UIView!
    @IBOutlet weak var headerView: UIView!
    var grafType = 0
    var monthSelected = 0
    var weeklbl = [Double]()
    var titletext = ""
    
    var arrStr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DietFitnessData.shared.monthWeekSelected = 0
        setGraphData(graf: grafType)

        let header = DietHeader.instanceFromNib()
        self.headerView.addSubview(header)
        // Do any additional setup after loading the view.
        self.lblCustomNavTitle.text = self.titletext
        let maxMonthValue = weeklbl.max()
        let minMonthValue = weeklbl.min()
        self.lineChart.xAxis.drawAxisLineEnabled = false
        self.lineChart.xAxis.drawGridLinesEnabled = true
        self.lineChart.xAxis.labelTextColor = .black
        self.lineChart.rightAxis.drawAxisLineEnabled = false
        self.lineChart.rightAxis.labelTextColor = .clear
        self.lineChart.leftAxis.drawAxisLineEnabled = false
        self.lineChart.leftAxis.labelTextColor = .black
        self.lineChart.leftAxis.drawGridLinesEnabled = false
        self.lineChart.rightAxis.drawGridLinesEnabled = true
        
        self.lineChart.leftAxis.axisMinimum = Double(minMonthValue ?? 0.0) - 10.0
        self.lineChart.leftAxis.axisMaximum = Double(maxMonthValue ?? 0.0) + 10.0
        self.lineChart.xAxis.labelPosition = .bottom
        self.lineChart.xAxis.valueFormatter = DateValueFormatter()
        self.lineChart.xAxis.granularity = 1
        self.lineChart.xAxis.axisMaximum = 6
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 3
        leftAxisFormatter.negativeSuffix = " kg"
        leftAxisFormatter.positiveSuffix = " kg"

        
        let obj = self.lineChart.leftAxis
        obj.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftAxisFormatter)
        
//        self.setReportChart()
        self.updateGraph()
        
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
    
    func setGraphData(graf: Int) {

        switch graf {
        case 0:
            if let details = DietFitnessData.shared.userDietFitness?.analytics.weightDetails {
                
                if monthSelected == 0 {
                    if let arr = details.Week?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                } else if monthSelected == 1 {
                    if let arr = details.ThreeMonths?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                } else {
                    if let arr = details.SixMonths?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                }
                
            }
            break
        case 1:
            
            if let details = DietFitnessData.shared.userDietFitness?.analytics.exerciseDetails {
                
                if monthSelected == 0 {
                    if let arr = details.WeeklyExercise?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                } else if monthSelected == 1 {
                    if let arr = details.ThreeMonthsExercise?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                } else {
                    if let arr = details.SixMonthsExercise?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                }
                
                }
            
            break
        case 2:
            if let details = DietFitnessData.shared.userDietFitness?.analytics.mealDetails {
                
                
                if monthSelected == 0 {
                    if let arr = details.WeeklyMeal?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                } else if monthSelected == 1 {
                    if let arr = details.ThreeMonthsCalory?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                } else {
                    if let arr = details.SixMonthsMeal?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                }
        
            }
            
            break
        default:
            if let details = DietFitnessData.shared.userDietFitness?.analytics.waterIntake {
                
                if monthSelected == 0 {
                    if let arr = details.WeeklyWaterQnt?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                } else if monthSelected == 1 {
                    if let arr = details.ThreeMonthsWaterQnt?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
                } else {
                    if let arr = details.SixMonthsWaterQnt?.components(separatedBy: ",") {
                        let arrOfDoubles = arr.map { value -> Double in
                                                return Double(value)!
                        }
                        self.weeklbl = arrOfDoubles
                        print("Doubles arr \(arrOfDoubles)")
                    }
       
            }
            break
        }
    }
        
    }
    
    @IBAction func selectMonth(sender: UIButton) {
        self.monthSelected = sender.tag
        DietFitnessData.shared.monthWeekSelected = self.monthSelected
        setGraphData(graf: grafType)
        updateGraph()
    }
    
    @IBAction func btnOpenCloseCalendarAction(_ sender: UIButton) {
        self.lineChart.isHidden = true
        self.calendarView.isHidden = false
        self.monthChangesContainView.isHidden = false
        self.btnOpenCloseCalendar.isHidden = true
    }
    @IBAction func btnPreviousMonthAction(_ sender: UIButton) {
        self.previousMonth()
    }
    @IBAction func btnNextMonthAction(_ sender: UIButton) {
        self.nextMonth()
    }
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]()
        
        //here is the for loop
        for i in 0..<self.weeklbl.count {

            let value = ChartDataEntry(x: Double(i), y: self.weeklbl[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }

        let line1 = LineChartDataSet(entries: lineChartEntry, label: "") //Here we convert lineChartEntry to a LineChartDataSet

        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        line1.circleHoleRadius = 3
        line1.lineWidth = 2
        line1.circleRadius = 5
        line1.valueTextColor = .clear
        line1.setCircleColors(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
        line1.circleHoleColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        line1.setColor(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))

        let data = LineChartData() //This is the object that will be added to the chart

        data.addDataSet(line1) //Adds the line to the dataSet
        
        self.lineChart.data = data //finally - it adds the chart data to the chart and causes an update

        self.lineChart.chartDescription?.text = "" // Here we set the description for the graph

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
        self.selectedDate = newDate
        self.lineChart.isHidden = false
        self.calendarView.isHidden = true
        self.monthChangesContainView.isHidden = true
        self.btnOpenCloseCalendar.isHidden = false
        
    }


}

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    var dateList:[Date] = []
    override init() {
        super.init()
        dateFormatter.dateFormat = "dd MMM"
        self.dateList.append(Calendar.current.date(byAdding: .day, value: -6, to: Date())!)
        self.dateList.append(Calendar.current.date(byAdding: .day, value: -5, to: Date())!)
        self.dateList.append(Calendar.current.date(byAdding: .day, value: -4, to: Date())!)
        self.dateList.append(Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
        self.dateList.append(Calendar.current.date(byAdding: .day, value: -2, to: Date())!)
        self.dateList.append(Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        self.dateList.append(Date())
        self.dateList.append(Date())
        self.dateList.append(Date())
        self.dateList.append(Date())
        
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        var weekMonthArr = [String]()
        var weekArr = [Date]()
        var threeMonth = [Date]()
        var sixMonth = [Date]()
        
        if DietFitnessData.shared.monthWeekSelected == 0 {
            weekArr.append(Date())
            for n in 1...7 {
                let date = Calendar.current.date(byAdding: .day, value: n, to: Date())!
               
                 weekArr.append(date)
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            for temp in weekArr {
                let strDt = dateFormatter.string(from: temp)
                weekMonthArr.append(strDt)
            }
        } else if DietFitnessData.shared.monthWeekSelected == 1 {
            threeMonth.append(Date())
            for n in 1...3 {
                let date = Calendar.current.date(byAdding: .month, value: n, to: Date())!
                threeMonth.append(date)
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            for temp in threeMonth {
                let strDt = dateFormatter.string(from: temp)
                weekMonthArr.append(strDt)
            }
            
        } else {
            sixMonth.append(Date())
            for n in 1...6 {
                let date = Calendar.current.date(byAdding: .month, value: n, to: Date())!
                sixMonth.append(date)
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            for temp in sixMonth {
                let strDt = dateFormatter.string(from: temp)
                weekMonthArr.append(strDt)
            }
        }
        var str = ""
        let val = Int(value)
        
        if weekMonthArr.count > val {
            str = "\(weekMonthArr[Int(value)])"
        }
        return str //dateFormatter.string(from: self.dateList[Int(value)])
    }
}
