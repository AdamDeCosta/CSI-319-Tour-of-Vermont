//
//  ModelTour.swift
//  project 2
//
//  Created by Adam DeCosta on 3/27/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import Foundation

class Tour: Item {
    
    enum TourType {
        case audio
        case video
    }
    
    let type: TourType
    let url: URL
    
    override func encode(with aCoder: NSCoder) {
        switch type {
        case .audio:
            aCoder.encode("Audio", forKey: "Type")
        case .video:
            aCoder.encode("Video", forKey: "Type")
        }
        
        super.encode(with: aCoder)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "Title") as! String
        let uuid = aDecoder.decodeObject(forKey: "Key") as! String
        let itemType = aDecoder.decodeObject(forKey: "Type") as! String
        let type : TourType = itemType == "Audio" ? .audio : .video
        
        let url = Bundle.main.url(forResource: title, withExtension: type == .audio ? "mp3" : "mp4")!
        
        self.init(title: title, type: type, url: url, uuid: uuid, itemType: itemType)
    }
    override init() {
        self.type = TourType.audio
        self.url = URL.init(fileURLWithPath: String())
        
        super.init()
    }
    
    init(title: String, type: TourType, url: URL, uuid: String, itemType: String) {
        self.type = type
        self.url = url
        
        super.init(title: title, uuid: uuid)
    }
}

extension Array where Element == Tour {
    mutating func loadTours(){
        if let path = Bundle.main.url(forResource: "data", withExtension: "plist", subdirectory: "") {
            let plistPath = path.path
            if let pListData = FileManager.default.contents(atPath: plistPath) {
                do {
                    if let pList = try PropertyListSerialization.propertyList(from: pListData, options: PropertyListSerialization.ReadOptions(), format: nil) as? Dictionary<String, Any> {
                        
                        let tmpArr = pList["Tours"] as! Array<Dictionary<String, String>>
                        
                        for tmp in tmpArr {
                            let tmpTitle = tmp["Title"]!
                            let itemType = tmp["Type"]!
                            let tmpType : Tour.TourType = itemType == "Audio" ? .audio : .video
                            let contentPath = Bundle.main.url(forResource: tmpTitle, withExtension: tmpType == .audio ? "mp3" : "mp4")
                            let tmpKey = tmp["Key"]!
                            
                            let tmpTour = Tour(title: tmpTitle, type: tmpType, url: contentPath!, uuid: tmpKey, itemType: itemType)
                            
                            self.append(tmpTour)
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
