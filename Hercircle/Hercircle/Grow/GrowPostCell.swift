//
//  GrowPostCell.swift
//  Hercircle
//
//  Created by vivekp on 16/07/21.
//

import UIKit
import SDWebImage

class GrowPostCell: UITableViewCell {

    @IBOutlet weak var lblPostCategory: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var lblPostTitle: UILabel!
    @IBOutlet weak var lblPostDateAndOwwnerName: UILabel!
    
    var model : InfiniteStory? {
        didSet {
            self.lblPostCategory.text = /model?.subCategoryName
            self.imgPost.sd_setImage(with: URL(string:/model?.mediaFileName), placeholderImage: UIImage(named: "left_header"), options: .delayPlaceholder, completed: nil)
            self.lblPostTitle.text = /model?.titleHeader
            
            let dateFormatter = DateFormatter()
           // dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
            let date = dateFormatter.date(from:/model?.validFrom)
            self.lblPostDateAndOwwnerName.text = /model?.author + " I " + /date?.string(withFormat: "MMM dd , yyyy")
        }
    }
    
    var creativeCornerModel : CreativeCornor? {
        didSet {
            self.lblPostCategory.text = /model?.subCategoryName
            self.imgPost.sd_setImage(with: URL(string:/model?.mediaFileName), placeholderImage: UIImage(named: "left_header"), options: .delayPlaceholder, completed: nil)
            self.lblPostTitle.text = /model?.titleHeader
            
            let dateFormatter = DateFormatter()
           // dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
            let date = dateFormatter.date(from:/model?.validFrom)
            self.lblPostDateAndOwwnerName.text = /model?.author + " I " + /date?.string(withFormat: "MMM dd , yyyy")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
