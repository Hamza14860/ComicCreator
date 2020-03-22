//
//  ComicArtDocumentTableViewController.swift
//  ComicBuilder
//
//  Created by Hamza Azam on 22/03/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class ComicArtDocumentTableViewController: UITableViewController {

    var comicArtDocuments = ["One","Two","Three"]
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comicArtDocuments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = comicArtDocuments[indexPath.row]

        return cell
    }
    
    @IBAction func newComicArt(_ sender: UIBarButtonItem) {
        comicArtDocuments += ["Untitled".madeUnique(withRespectTo: comicArtDocuments)]
        tableView.reloadData()
    }
    
    //swipe func of split view for all display modes
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //swipe to delete 
        if editingStyle == .delete {
            // Delete the row from the data source
            comicArtDocuments.remove(at: indexPath.row )
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert { //dont need this bec we have our plus button
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
