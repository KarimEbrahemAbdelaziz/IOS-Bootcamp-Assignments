//
//  CategoryListItemsCell.swift
//  CheckListApp
//
//  Created by KARIM on 5/4/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit

class CategoryListItemsCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        itemTitleLabel.text = "Karim"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        categoryName.text = ""
        categoryImage.image = #imageLiteral(resourceName: "Birthdays")
    }
    
}
