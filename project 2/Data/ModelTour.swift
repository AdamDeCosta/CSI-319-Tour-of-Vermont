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
    
    override init() {
        self.type = TourType.audio
        self.url = URL.init(fileURLWithPath: String())
        
        super.init()
    }
    
    init(title: String, type: TourType, url: URL) {
        self.type = type
        self.url = url
        
        super.init(title: title)
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
                            
                            let tmpType : Tour.TourType = tmp["Type"] == "Audio" ? .audio : .video
                            
                            let contentPath = Bundle.main.url(forResource: tmpTitle, withExtension: tmpType == .audio ? "mp3" : "mp4")
                            
                            let tmpTour = Tour(title: tmpTitle, type: tmpType, url: contentPath!)
                            
                            self.append(tmpTour)
                        }
                    }
                }
                catch {
                    print("Could not read property list")
                }
            }
        }
    }}
