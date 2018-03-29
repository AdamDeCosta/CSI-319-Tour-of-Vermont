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
    let itemArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("notes.archive")
    }()
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can re-insert it
        let movedItem = notes[fromIndex]
        
        // Remove item from array
        notes.remove(at: fromIndex)
        
        // Insert item in array at new location
        notes.insert(movedItem, at: toIndex)
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Note()
        
        notes.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ note: Note) {
        if let index = notes.index(of: note) {
            notes.remove(at: index)
        }
    }
    init() {
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Note] {
            notes.append(contentsOf: archivedItems)
        }
    }
    
    func saveNotes() -> Bool {
        return NSKeyedArchiver.archiveRootObject(notes, toFile: itemArchiveURL.path)
    }
}
