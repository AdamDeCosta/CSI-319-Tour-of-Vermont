//
//  ModelLink.swift
//  project 2
//
//  Created by Adam DeCosta on 3/29/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class Link: Item {
    let url: URL
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(url, forKey: "URL")
        
        super.encode(with: aCoder)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "Title") as! String
        let uuid = aDecoder.decodeObject(forKey: "Key") as! String
        let url = aDecoder.decodeObject(forKey: "URL") as! URL
        
        self.init(title: title, itemType: "Link", uuid: uuid, url: url)
    }
    
    init(title: String = String(), itemType: String = "Link", uuid: String = UUID().uuidString, url: URL) {
        self.url = url
        
        super.init(title: title, uuid: uuid, itemType: itemType)
    }
}

extension Array where Element == Link {
    mutating func loadLinks(){
        if let path = Bundle.main.url(forResource: "data", withExtension: "plist", subdirectory: "") {
            let plistPath = path.path
            if let pListData = FileManager.default.contents(atPath: plistPath) {
                do {
                    if let pList = try PropertyListSerialization.propertyList(from: pListData, options: PropertyListSerialization.ReadOptions(), format: nil) as? Dictionary<String, Any> {
                        
                        let tmpArr = pList["Links"] as! Array<Dictionary<String, String>>
                        
                        for tmp in tmpArr {
                            let tmpTitle = tmp["Title"]!
                            let tmpKey = tmp["Key"]!
                            let url = tmp["URL"]!
                            
                            let tmpLink = Link(title: tmpTitle, itemType: "Link", uuid: tmpKey, url: URL(string: url)!)
                            
                            self.append(tmpLink)
                        }
                    }
                }
                catch {
                    print("Could not read property list")
                }
            }
        }
    }
}
