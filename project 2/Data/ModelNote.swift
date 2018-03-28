//
//  ModelNote.swift
//  project 2
//
//  Created by Adam DeCosta on 3/27/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class Note {
    var title: String
    var image: String
    var description: String
    
    init() {
        self.title = String()
        self.image = String()
        self.description = String()
    }
    
    init(title: String, image: String, description: String) {
        self.title = title
        self.image = image
        self.description = description
    }
}
