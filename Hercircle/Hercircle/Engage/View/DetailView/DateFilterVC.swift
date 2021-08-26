//
//  DateFilterVC.swift
//  Hercircle
//
//  Created by Rahul Patel on 22/07/21.
//

import UIKit

class DateFilterVC: UIViewController {
    @IBOutlet weak var startdate: UILabel!
    @IBOutlet weak var startdatePicker: UIDatePicker!

    @IBOutlet weak var enddate: UILabel!
    @IBOutlet weak var enddatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func startdatePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short

        let strDate = dateFormatter.string(from: startdatePicker.date)
        startdate.text = strDate
    }
    @IBAction func enddatePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short

        let strDate = dateFormatter.string(from: enddatePicker.date)
        enddate.text = strDate
    }

}
