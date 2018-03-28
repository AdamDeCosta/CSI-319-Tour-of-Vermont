//
//  ToursTableViewController.swift
//  project 2
//
//  Created by Adam DeCosta on 3/27/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class ToursTableViewController: UITableViewController {
    
    var tours : [Tour] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tours.loadTours()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tours.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tourCell", for: indexPath)

        // Configure the cell...
        
        let tour = tours[indexPath.row]
        
        cell.textLabel?.text = tour.title
        
        switch tour.type {
        case .audio:
            cell.imageView?.image = UIImage(named: "audio")
        default:
            cell.imageView?.image = UIImage(named: "video")
        }

        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.destination is ToursDetailViewController {
            let destination = segue.destination as! ToursDetailViewController
            
            destination.tour = tours[(tableView.indexPathForSelectedRow?.row)!]
        }
    }


}
