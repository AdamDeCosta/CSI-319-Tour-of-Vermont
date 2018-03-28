//
//  Item.swift
//  project 2
//
//  Created by Adam DeCosta on 3/28/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import Foundation

class Item: NSObject {
    let title: String?
    let uuid: String
    let itemDescription: String
    
    override init() {
        self.title = String()
        self.uuid = UUID().uuidString
        self.itemDescription = String()
        
        super.init()
    }
    
    init(title: String = String(), uuid: String = UUID().uuidString, itemDescription: String = String()) {
        self.title = title
        self.uuid = uuid
        self.itemDescription = itemDescription
        
        super.init()
    }
}
