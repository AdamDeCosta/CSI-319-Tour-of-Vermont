//
//  LinksTableViewController.swift
//  project 2
//
//  Created by Adam DeCosta on 3/29/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class LinksTableViewController: UITableViewController {

    var links : [Link] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        links.loadLinks()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return links.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath)

        let link = links[indexPath.row]
        
        cell.textLabel?.text = link.title

        return cell
    }
    
    // Source: https://stackoverflow.com/questions/39546856/how-to-open-an-url-in-swift3?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = links[indexPath.row]
        
        UIApplication.shared.open(link.url, options: [:], completionHandler: nil)
    }

}
