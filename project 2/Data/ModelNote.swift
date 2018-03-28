//
//  ModelNote.swift
//  project 2
//
//  Created by Adam DeCosta on 3/27/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class Note: Item {
    var image: String
    
    override init() {
        self.image = String()
        
        super.init()
    }
    
    init(title: String, image: String, description: String) {
        self.image = image
        
        super.init(title: title, itemDescription: description)
    }
}
