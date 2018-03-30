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
    
    var sight : Sight = Sight(title: "")
    
    @IBOutlet weak var imageSight: UIImageView!
    @IBOutlet weak var mapSight: MKMapView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = sight.title!
        self.imageSight.image = UIImage(named: sight.title!)
        self.labelDescription.text = sight.sightDescription
        
        let region = MKCoordinateRegionMakeWithDistance(sight.coordinate, 750, 750)
        
        mapSight.setRegion(region, animated: true)
        mapSight.addAnnotation(sight)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addFavorite(_ sender: UIButton) {
        let favorites : FavoritesStore = FavoritesStore()
        if !favorites.isFavorite(sight) {
            favorites.addFavorite(sight)
        }
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
