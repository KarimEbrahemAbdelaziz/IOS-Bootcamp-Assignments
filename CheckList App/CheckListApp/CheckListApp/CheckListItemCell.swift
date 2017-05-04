//
//  CheckListCell.swift
//  CheckListApp
//
//  Created by KARIM on 4/17/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit

class CheckListItemCell: UITableViewCell {
    
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var checkMarkLabel: UILabel!
    
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
        itemTitleLabel.text = ""
        checkMarkLabel.text = ""
    }
    
}
