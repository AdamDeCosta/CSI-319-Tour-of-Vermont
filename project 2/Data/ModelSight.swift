//
//  ModelSight.swift
//  project 2
//
//  Created by Adam DeCosta on 3/26/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import Foundation
import MapKit

class Sight: Item, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let sightDescription: String
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(coordinate.latitude, forKey: "Latitude")
        aCoder.encode(coordinate.longitude, forKey: "Longitude")
        aCoder.encode(sightDescription, forKey: "Description")
        
        super.encode(with: aCoder)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "Title") as! String
        let uuid = aDecoder.decodeObject(forKey: "Key") as! String
        let latitude = aDecoder.decodeDouble(forKey: "Latitude")
        let longitude = aDecoder.decodeDouble(forKey: "Longitude")
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let sightDescription = aDecoder.decodeObject(forKey: "Description") as! String
        let itemType = aDecoder.decodeObject(forKey: "Type") as! String
        
        self.init(title: title, coordinate: coordinate, sightDescription: sightDescription, uuid: uuid, itemType: itemType)
    }
    
    init(title: String, coordinate: CLLocationCoordinate2D, sightDescription: String, uuid: String, itemType: String) {
        self.coordinate = coordinate
        self.sightDescription = sightDescription
        super.init(title: title, uuid: uuid, itemType: itemType)
    }
    
    init(title: String) {
        self.coordinate = CLLocationCoordinate2D()
        self.sightDescription = String()
        super.init(title: title)
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
                            let tmpKey = tmp["Key"] as! String
                            let tmpType = tmp["Type"] as! String
                            
                            let tmpSight = Sight(title: tmpName, coordinate: tmpCoordinate, sightDescription: tmpDescription, uuid: tmpKey, itemType: tmpType)
                            
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
