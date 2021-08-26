//
//  PopupControler.swift
//  SomeProject
//
//  Created by Abhinav.prashar on 18/08/21.
//


import UIKit
typealias SelectedOptionInParticipantDetail = (_ selectedOption: MoreOptionsModel) -> Void

class PopupControler: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var lblparticipantName: UILabel!
    @IBOutlet weak var constraintTblVwHeight: NSLayoutConstraint!
    
    // MARK: - Constants and Variables
    var participantName = String()
    var optionSelected: SelectedOptionInParticipantDetail?
    var arrOptions = [MoreOptionsModel]()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblparticipantName.text = participantName
        constraintTblVwHeight.constant = CGFloat(arrOptions.count * 39)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    func selected(option: MoreOptionsModel) {
        guard let completion = optionSelected else {return}
        self.dismiss(animated: true) {
            completion(option)
        }
    }
}

extension PopupControler: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreOptionsCell", for: indexPath) as? MoreOptionsCell {
            let model = arrOptions[indexPath.row]
            cell.lblOptionName.text = model.name
            cell.imgVwOption.image = model.image
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = arrOptions[indexPath.row]
        selected(option: model)
    }
}

class MoreOptionsCell: UITableViewCell {
    @IBOutlet weak var lblOptionName: UILabel!
    @IBOutlet weak var imgVwOption: UIImageView!
}

class MoreOptionsModel {
    var name = ""
    var image : UIImage?
    init(optionName: String , image:UIImage?) {
        name = optionName
        self.image = image
    }
}

