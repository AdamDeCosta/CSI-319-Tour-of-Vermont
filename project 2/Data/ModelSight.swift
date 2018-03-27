//
//  ModelSight.swift
//  project 2
//
//  Created by Adam DeCosta on 3/26/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import Foundation
import MapKit

class Sight: NSObject, MKAnnotation {
    let title : String?
    let coordinate: CLLocationCoordinate2D
    let sightDescription: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, sightDescription: String) {
        self.title = title
        self.coordinate = coordinate
        self.sightDescription = sightDescription
        
        super.init()
    }
    
    init(title: String) {
        self.title = title
        self.coordinate = CLLocationCoordinate2D()
        self.sightDescription = String()
    }
}

extension Array where Element == Sight {
    mutating func loadSights(){
        if let path = Bundle.main.url(forResource: "data", withExtension: "plist", subdirectory: "") {
            let plistPath = path.path
            if let pListData = FileManager.default.contents(atPath: plistPath) {
                do {
                    if let pList = try PropertyListSerialization.propertyList(from: pListData, options: PropertyListSerialization.ReadOptions(), format: nil) as? Dictionary<String, Any> {
                        
                        let tmpArr = pList["Sights"] as! Array<Dictionary<String, Any>>
                        
                        for tmp in tmpArr {
                            let tmpLatitude = tmp["Latitude"] as! Double
                            let tmpLongitude = tmp["Longitude"] as! Double
                            let tmpCoordinate = CLLocationCoordinate2D(latitude: tmpLatitude, longitude: tmpLongitude)
                            
                            let tmpName = tmp["Name"] as! String
                            let tmpDescription = tmp["Description"] as! String
                            
                            let tmpSight = Sight(title: tmpName, coordinate: tmpCoordinate, sightDescription: tmpDescription)
                            
                            self.append(tmpSight)
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
