//
//  ModelTour.swift
//  project 2
//
//  Created by Adam DeCosta on 3/27/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import Foundation

class Tour {
    let title : String
    let type: String
    
    init() {
        self.title = String()
        self.type = String()
    }
    
    init(title: String, type: String) {
        self.title = title
        self.type = type
    }
}

extension Array where Element == Tour {
    mutating func loadTours(){
        if let path = Bundle.main.url(forResource: "data", withExtension: "plist", subdirectory: "") {
            let plistPath = path.path
            if let pListData = FileManager.default.contents(atPath: plistPath) {
                do {
                    if let pList = try PropertyListSerialization.propertyList(from: pListData, options: PropertyListSerialization.ReadOptions(), format: nil) as? Dictionary<String, Any> {
                        
                        let tmpArr = pList["Tours"] as! Array<Dictionary<String, Any>>
                        
                        for tmp in tmpArr {
                            let tmpTitle = tmp["Title"] as! String
                            let tmpType = tmp["Type"] as! String
                            
                            let tmpTour = Tour(title: tmpTitle, type: tmpType)
                            
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
