//
//  DietHeader.swift
//  Hercircle
//
//  Created by Apple on 15/08/21.
//

import UIKit

class DietHeader: UIView {
    
     class func instanceFromNib() -> DietHeader {
         return UINib(nibName: "DietHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DietHeader
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
