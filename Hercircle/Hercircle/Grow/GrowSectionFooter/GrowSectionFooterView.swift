//
//  GrowSectionFooterView.swift
//  Hercircle
//
//  Created by vivekp on 17/07/21.
//

import UIKit



class GrowSectionFooterView: UIView {

    //MARK:- IBOutlets
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var btnLoadMore: UIButton!
    
    //MARK:- Variables
    static let reuseIdentifier = "GrowSectionFooterView"


    //MARK::- Overide Functions
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Utils.getClassName(className: GrowSectionFooterView.self), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {return UIView()}
        return view
    }
    
    func xibSetup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

