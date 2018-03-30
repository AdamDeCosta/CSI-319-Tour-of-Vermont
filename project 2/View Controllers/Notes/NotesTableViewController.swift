//
//  NotesTableViewController.swift
//  project 2
//
//  Created by Adam DeCosta on 3/27/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    var notesStore: NotesStore = NotesStore()
    let imageStore : ImageStore = ImageStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesStore.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        let note = notesStore.notes[indexPath.row]
        
        cell.textLabel?.text = note.title
        cell.imageView?.image = imageStore.image(forKey: note.uuid)

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let note = notesStore.notes[indexPath.row]
            let favoritesStore: FavoritesStore = FavoritesStore()
            
            if favoritesStore.isFavorite(note) {
                favoritesStore.removeItem(note)
            }
            notesStore.removeItem(note)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            notesStore.notes.append(Note())
            tableView.reloadData()
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        notesStore.moveItem(from: fromIndexPath.row, to: to.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.destination is NotesDetailViewController {
            let destination = segue.destination as! NotesDetailViewController
            
            destination.note = notesStore.notes[(tableView.indexPathForSelectedRow?.row)!]
            destination.imageStore = imageStore
            destination.notesStore = notesStore
        }
    }

    @IBAction func addNote(_ sender: UIButton) {
        notesStore.notes.append(Note())
        tableView.reloadData()
    }
}
