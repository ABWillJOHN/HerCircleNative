//
//  ViewAllTopicsVC.swift
//  hercircle
//
//  Created by Keyur Baravaliya on 21/07/21.
//

import UIKit

class ViewAllTopicsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewAllList:[CreativeCornors]? = nil

    @IBOutlet var tableview: UITableView!{
        didSet {
            tableview.register(UINib.init(nibName: "HomeTBVCell", bundle: nil), forCellReuseIdentifier: "HomeTBVCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    
    //MARK:- Tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewAllList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "HomeTBVCell", for: indexPath) as? HomeTBVCell
        //cell.lblTitle.text = "index 1"
//        cell.lblDesc.text = "index 2"
        if let viewAllDetails = self.viewAllList?[indexPath.row] {
            cell?.lblTitle.text = viewAllDetails.categoryName ?? ""
            cell?.lblDesc.text = viewAllDetails.titleHeader ?? ""
            cell?.imageView?.pin_updateWithProgress = true
            cell?.imageView?.pin_setImage(from: URL(string: viewAllDetails.mediaFileName ?? "https://devhercircle.jio.com/Portal/Engage/M/D458F9AD-C02D-4795-A0D3-15DDA7AE1BC4.JPG")!)

        }
        return cell!
    }



}
