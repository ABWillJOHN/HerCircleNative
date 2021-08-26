//
//  ActivityVC.swift
//  Hercircle
//
//  Created by Apple on 02/08/21.
//

import UIKit

class ActivityVC: UIViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewCollection: UIView!

    var getDiaryView = DiaryView.DiaryviewinstanceFromNib()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    var sectiononeArray:[String] = [String]()
    var sectiontwoArrauy:[String] = [String]()
    var caloriesConsumedValue:Int = Int()
    var datepickerBGView:UIView = UIView()
    var datepickerview:UIView = UIView()
    var mydatepicker:UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = FitnessHeader.instanceFromNib()
        self.viewTop.addSubview(header)
        // Do any additional setup after loading the view.
        self.getDiaryView.translatesAutoresizingMaskIntoConstraints = false
        self.viewCollection.addSubview(self.getDiaryView)
        self.getDiaryView.topAnchor.constraint(equalTo: self.viewCollection.topAnchor, constant: 0).isActive = true
        self.getDiaryView.bottomAnchor.constraint(equalTo: self.viewCollection.bottomAnchor, constant: 0).isActive = true
        self.getDiaryView.leadingAnchor.constraint(equalTo: self.viewCollection.leadingAnchor, constant: 0).isActive = true
        self.getDiaryView.trailingAnchor.constraint(equalTo: self.viewCollection.trailingAnchor, constant: 0).isActive = true
        self.getDiaryView.dateButton.layer.cornerRadius = 8.0
        self.getDiaryView.diaryCollectionView.delegate = self
        self.getDiaryView.diaryCollectionView.dataSource = self
        self.getDiaryView.diaryCollectionView.showsVerticalScrollIndicator = false
        self.getDiaryView.diaryCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.getDiaryView.diaryCollectionView.register(UINib.init(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        self.getDiaryView.diaryCollectionView.register(UINib.init(nibName: "headerView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        self.sectiononeArray = ["Meal plan","weight","Exercise","water intake"]
        self.setupDatePickert()
        self.getDiaryView.dateButton.addTarget(self, action: #selector(datepickerButtonTapped), for: .touchUpInside)
    }
  // MARK:- DATE PICKER SETUP
    func setupDatePickert(){
        self.datepickerBGView.translatesAutoresizingMaskIntoConstraints = false
        self.datepickerBGView.backgroundColor = UIColor.systemGroupedBackground.withAlphaComponent(0.3)
        self.datepickerBGView.isHidden = true
        self.view.addSubview(self.datepickerBGView)
        self.datepickerBGView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.datepickerBGView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.datepickerBGView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.datepickerBGView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        
        self.datepickerview.translatesAutoresizingMaskIntoConstraints = false
        self.datepickerBGView.addSubview(self.datepickerview)
        self.datepickerview.backgroundColor = .white
        self.datepickerview.bottomAnchor.constraint(equalTo: self.datepickerBGView.bottomAnchor, constant: 0).isActive = true
        self.datepickerview.leadingAnchor.constraint(equalTo: self.datepickerBGView.leadingAnchor, constant: 0).isActive = true
        self.datepickerview.trailingAnchor.constraint(equalTo: self.datepickerBGView.trailingAnchor, constant: 0).isActive = true
        self.datepickerview.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.mydatepicker.translatesAutoresizingMaskIntoConstraints = false
        self.datepickerview.addSubview(self.mydatepicker)
        self.mydatepicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            self.mydatepicker.preferredDatePickerStyle = .wheels
        }
        self.mydatepicker.topAnchor.constraint(equalTo: self.datepickerview.topAnchor, constant: 0).isActive = true
        self.mydatepicker.bottomAnchor.constraint(equalTo: self.datepickerview.bottomAnchor, constant: 0).isActive = true
        self.mydatepicker.leadingAnchor.constraint(equalTo: self.datepickerview.leadingAnchor, constant: 0).isActive = true
        self.mydatepicker.trailingAnchor.constraint(equalTo: self.datepickerview.trailingAnchor, constant: 0).isActive = true
        self.mydatepicker.addTarget(self, action: #selector(datepickerValueChangedAction(_:)), for: .valueChanged)
    }
    
    // MARK:- DATE BUTTON ACTION
    @objc func datepickerButtonTapped(){
        self.datepickerBGView.isHidden = false
        self.view.bringSubviewToFront(self.datepickerBGView)
    }
    // MARK:- DATE PICKER ACTION
    @objc func datepickerValueChangedAction(_ sender:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        self.getDiaryView.dateValueLbl.text = formatter.string(from: self.mydatepicker.date)
        self.datepickerBGView.isHidden = true
    }
    // MARK:- Increment button tapped
    @objc func incrementButtonTapped(_ sender:UIButton) {
        caloriesConsumedValue = caloriesConsumedValue + 1
        DispatchQueue.main.async {
            self.getDiaryView.diaryCollectionView.reloadData()
        }
    }

}

extension ActivityVC: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  section == 0 ? self.sectiononeArray.count : self.sectiontwoArrauy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell

        cell.propertyNameLbl.text = indexPath.section == 0  ? self.sectiononeArray[indexPath.item] : self.sectiontwoArrauy[indexPath.item]
        cell.propertyNameLbl.font = UIFont.systemFont(ofSize: 12)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension , height: itemDimension )
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(HeaderCollectionReusableView.self)",
                    for: indexPath)
                guard let typedHeaderView = headerView as? HeaderCollectionReusableView
                else { return headerView }
                typedHeaderView.caloriesConsumedLbl.layer.borderWidth = 1.0
                typedHeaderView.caloriesConsumedLbl.layer.borderColor = UIColor.systemGreen.cgColor
                typedHeaderView.caloriesConsumedLbl.layer.cornerRadius = 8.0
                typedHeaderView.caloriesIncrementButton.layer.cornerRadius = 8.0
                typedHeaderView.caloriesConsumedLbl.text = "Calories Consumed:\(self.caloriesConsumedValue)"
                typedHeaderView.caloriesIncrementButton.addTarget(self, action: #selector(incrementButtonTapped(_:)), for: .touchUpInside)
                return typedHeaderView
            }
            else {
                let secondheaderView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(headerView.self)",
                    for: indexPath)
                guard let typedHeaderView = secondheaderView as? headerView
                else { return secondheaderView }
                return typedHeaderView
            }
        default:
            assert(false, "Invalid element type")
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: collectionView.frame.width, height: 250) : CGSize(width: collectionView.frame.width, height: self.sectiontwoArrauy.count > 0 ? 50 : 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.sectiontwoArrauy = ["Break fast","Lunch","Dinner","Snacks"]
            DispatchQueue.main.async {
                self.getDiaryView.diaryCollectionView.reloadData()
            }

        }
        else {
            
            print(indexPath.item)
            if let vc = MealWorkoutVC(nibName: "MealWorkoutVC", bundle: nil) as? MealWorkoutVC
            {
                 self.navigationController?.pushViewController(vc, animated: true)
            }
        }
       
    }
}
