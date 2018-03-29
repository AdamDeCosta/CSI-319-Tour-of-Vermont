//
//  ModelNote.swift
//  project 2
//
//  Created by Adam DeCosta on 3/27/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class Note: Item {
    var text: String
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Description")
        
        super.encode(with: aCoder)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "Title") as! String
        let uuid = aDecoder.decodeObject(forKey: "Key") as! String
        let text = aDecoder.decodeObject(forKey: "Description") as! String
        
        self.init(title: title, text: text, uuid: uuid)
    }
    
    init(title: String = "Note", text: String = String(), uuid: String = UUID().uuidString) {
        self.text = text
        
        super.init(title: title, uuid: uuid)
    }
}

class NotesStore {
    var notes: [Note] = []
    
    init() {
        loadNotes()
    }
    
    func loadNotes() {
        if let tmpArr = UserDefaults.standard.array(forKey: "Notes") as? [Note] {
            notes.append(contentsOf: tmpArr)
        }
        else {
            print("No Notes!")
        }
    }
    
    func saveNotes() {
        let data : Data = NSKeyedArchiver.archivedData(withRootObject: notes)
        UserDefaults.standard.set(data, forKey: "Notes")
    }
}
