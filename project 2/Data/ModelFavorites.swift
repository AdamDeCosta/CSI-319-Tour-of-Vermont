//
//  FavoritesStore.swift
//  project 2
//
//  Created by Decosta, Adam on 3/29/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import Foundation

class Favorite: NSObject, NSCoding {
    let uuid: String
    let itemType: String
    
    init(uuid: String = UUID().uuidString, itemType: String = String()) {
        self.uuid = uuid
        self.itemType = itemType
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uuid, forKey: "Key")
        aCoder.encode(itemType, forKey: "Type")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let uuid = aDecoder.decodeObject(forKey: "Key") as! String
        let itemType = aDecoder.decodeObject(forKey: "Type") as! String
        
        self.init(uuid: uuid, itemType: itemType)
    }
}

// SOURCE: iOS Programming 6th Edition Chapter 16 - Big Nerd Ranch

class FavoritesStore {
    
    var favorites : [Favorite] = []
    
    let itemArchiveURL : URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("favorites.archive")
    }()
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can re-insert it
        let movedItem = favorites[fromIndex]
        
        // Remove item from array
        favorites.remove(at: fromIndex)
        
        // Insert item in array at new location
        favorites.insert(movedItem, at: toIndex)
    }
    
    func removeItem(_ favorite: Favorite) {
        if let index = favorites.index(of: favorite) {
            favorites.remove(at: index)
            self.save()
        }
    }
    
    func removeItem(_ item: Item) {
        
        for favorite in favorites {
            if favorite.uuid == item.uuid {
                if let index = favorites.index(of: favorite) {
                    favorites.remove(at: index)
                    self.save()
                }
            }
        }
    }
    
    func isFavorite(_ item: Item) -> Bool {
        for favorite in favorites {
            if item.uuid == favorite.uuid {
                return true
            }
        }
        return false
    }
    
    func addFavorite(_ item: Item) {
        let favorite = Favorite(uuid: item.uuid, itemType: item.itemType)
        favorites.append(favorite)
        
        self.save()
    }
    
    init() {
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Favorite] {
            favorites.append(contentsOf: archivedItems)
        }
    }
    
    func save(){
        NSKeyedArchiver.archiveRootObject(favorites, toFile: itemArchiveURL.path)
    }
}
