//
//  Item.swift
//  project 2
//
//  Created by Adam DeCosta on 3/28/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(uuid, forKey: "Key")
        aCoder.encode(itemType, forKey: "Type")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "Title") as! String
        let uuid = aDecoder.decodeObject(forKey: "Key") as! String
        let itemType = aDecoder.decodeObject(forKey: "Type") as! String
        
        self.init(title: title, uuid: uuid, itemType: itemType)
    }
    
    var title: String?
    let uuid: String
    let itemType: String
    
    override init() {
        self.title = String()
        self.uuid = UUID().uuidString
        self.itemType = String()
        
        super.init()
    }
    
    init(title: String = String(), uuid: String = UUID().uuidString, itemType: String = String()) {
        self.title = title
        self.uuid = uuid
        self.itemType = itemType
        
        super.init()
    }
}
