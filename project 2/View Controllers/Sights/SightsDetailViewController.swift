//
//  SightsDetailViewController.swift
//  project 2
//
//  Created by Adam DeCosta on 3/26/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit
import MapKit

class SightsDetailViewController: UIViewController {
    
    var sight : Sight = Sight()
    
    @IBOutlet weak var imageSight: UIImageView!
    @IBOutlet weak var mapSight: MKMapView!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = sight.name
        self.imageSight.image = UIImage(named: sight.name)
        self.labelDescription.text = sight.description
        
        let region = MKCoordinateRegionMakeWithDistance(sight.location, 500, 500)
        
        mapSight.setRegion(region, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
