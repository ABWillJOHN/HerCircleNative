//
//  TitleHeaderView.swift
//  Hercircle
//
//  Created by vishal modem on 7/20/21.
//

import UIKit

class TitleLogoView: UIView {
    
    @IBOutlet weak var logoView: UIView!
    
    @IBOutlet weak var connectButton: StackButton!
    @IBOutlet weak var engageButton: StackButton!
    @IBOutlet weak var growButton: StackButton!
    @IBOutlet weak var goalsButton: StackButton!
    @IBOutlet weak var helpButton: StackButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        guard let view = loadViewFromNib(nibName: "TitleLogoView") else { return }
        view.frame = self.bounds
        
        self.addSubview(view)
    }
}
