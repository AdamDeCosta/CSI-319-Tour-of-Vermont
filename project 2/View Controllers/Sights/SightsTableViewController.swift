//
//  SightsTableViewController.swift
//  project 2
//
//  Created by Adam DeCosta on 3/26/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class SightsTableViewController: UITableViewController {
    
    var sights: [Sight] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sights.loadSights()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sights.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sightCell", for: indexPath)

        cell.textLabel?.text = sights[indexPath.row].name
        
        cell.imageView?.image = UIImage(named: sights[indexPath.row].name)

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.destination is SightsDetailViewController {
            let desination = segue.destination as! SightsDetailViewController
            let sightIndex = tableView.indexPathForSelectedRow?.row
            
            desination.sight = sights[sightIndex!]
        }
    }
    

}
