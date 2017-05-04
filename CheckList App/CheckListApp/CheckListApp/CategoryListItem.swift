//
//  CategoryListItem.swift
//  CheckListApp
//
//  Created by KARIM on 5/4/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import Foundation
import UIKit

class CategoryListItem : NSObject, NSCoding {
    
    var text = ""
    var image = UIImageView()
    var checkList = [CheckListItem]()
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        image = aDecoder.decodeObject(forKey: "Image") as! UIImageView
        checkList = aDecoder.decodeObject(forKey: "CheckListItem") as! [CheckListItem]
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(image, forKey: "Image")
        aCoder.encode(checkList, forKey: "CheckListItem")
    }
}
