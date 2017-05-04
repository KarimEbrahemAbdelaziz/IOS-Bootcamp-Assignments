//
//  CheckListItem.swift
//  CheckListApp
//
//  Created by KARIM on 4/19/17.
//  Copyright © 2017 KARIM. All rights reserved.
//
import Foundation

class CheckListItem : NSObject, NSCoding {
    
    var text = ""
    var checked = false
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
}
