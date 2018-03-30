//
//  FavoritesTableViewController.swift
//  project 2
//
//  Created by Adam DeCosta on 3/29/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    var favorites: FavoritesStore = FavoritesStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favorites = FavoritesStore() // REALLY BAD but oh well
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)

        let favorite = favorites.favorites[indexPath.row]

        switch favorite.itemType {
        case "Sight":
            var sights : [Sight] = []
            sights.loadSights()
            
            for sight in sights {
                if sight.uuid == favorite.uuid {
                    cell.textLabel?.text = sight.title
                    cell.imageView?.image = UIImage(named: sight.title!)
                    break
                }
            }
        case "Tour":
           var tours : [Tour] = []
           tours.loadTours()
           
           for tour in tours {
                if tour.uuid == favorite.uuid {
                    cell.textLabel?.text = tour.title
                        
                    switch tour.type {
                    case .audio:
                        cell.imageView?.image = UIImage(named: "audio")
                    default:
                        cell.imageView?.image = UIImage(named: "video")
                    }
                    break
                }
            }
        case "Link":
            print("OP")
        case "Note":
            let notes : NotesStore = NotesStore()
            let images : ImageStore = ImageStore()
            for note in notes.notes {
                if note.uuid == favorite.uuid {
                    cell.textLabel?.text = note.title
                    cell.imageView?.image = images.image(forKey: note.uuid)
                    break
                }
            }
        default: // Had an odd non-repeatable case of something being none of these cases
            cell.textLabel?.text = "Unknown"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites.favorites[indexPath.row]
        
        switch favorite.itemType {
        case "Note":
            performSegue(withIdentifier: "notesSegue", sender: nil)
        case "Sight":
            performSegue(withIdentifier: "sightsSegue", sender: nil)
        default:
            performSegue(withIdentifier: "toursSegue", sender: nil)
        }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let favorite = favorites.favorites[indexPath.row]
            
            favorites.removeItem(favorite)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        favorites.moveItem(from: fromIndexPath.row, to: to.row)
        favorites.save()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let favorite = favorites.favorites[(tableView.indexPathForSelectedRow?.row)!]
        
        if let identifier = segue.identifier {
            switch identifier {
            case "notesSegue":
                if let destination = segue.destination as? NotesDetailViewController {
                    let notes : NotesStore = NotesStore()
                    for note in notes.notes {
                        if note.uuid == favorite.uuid {
                            destination.note = note
                        }
                    }
                }
            case "toursSegue":
                if let destination = segue.destination as? ToursDetailViewController {
                    var tours : [Tour] = []
                    tours.loadTours()
                    
                    for tour in tours {
                        if tour.uuid == favorite.uuid {
                            destination.tour = tour
                        }
                    }
                }
            default:
                if let destination = segue.destination as? SightsDetailViewController {
                    var sights: [Sight] = []
                    sights.loadSights()
                    
                    for sight in sights {
                        if sight.uuid == favorite.uuid {
                            destination.sight = sight
                        }
                    }
                }
            }
        }
        
    }
    

}
