//
//  EventTableViewController.swift
//  Sarafan
//
//  Created by Denis Zayakin on 4/20/19.
//  Copyright © 2019 Denis Zayakin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class EventTableViewController: UITableViewController, UIViewControllerPreviewingDelegate{
    
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath)
            else { return nil }
        previewingContext.sourceRect = cell.frame
        DataSource.shared.selectedEventName = DataSource.shared.eventList[indexPath.row]
        DataSource.shared.selectedEventInfo = DataSource.shared.EventInfo[indexPath.row]
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController
            else { preconditionFailure("Expected a EventViewController") }
        //let eventVC: EventViewController = EventViewController()
        //eventVC.eventNameLabel.text = eventVC.eventName
        //eventVC.eventTextView.text = eventVC.eventInfo

        return viewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
        
    }
    
    //var selectedEventName: String?
    //var selectedEventInfo: String?
    
    @objc func refreshArray() {
        // удаление из Firebase
        //Database.database().reference().child("postComments").child(self.postID).removeValue()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "spl.png")!)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshArray), for: .valueChanged)
        self.refreshControl = refreshControl
        
        registerForPreviewing(with: self, sourceView: tableView)
        
        /*if UIApplication.shared.keyWindow?.traitCollection.forceTouchCapability == UIForceTouchCapability.available
        {
            registerForPreviewing(with: self, sourceView: view)
            
        }
        */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataSource.shared.eventList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = EventList[indexPath.row]
        cell.textLabel?.text = DataSource.shared.eventList[indexPath.row]
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DataSource.shared.selectedEventName = DataSource.shared.eventList[indexPath.row]
        DataSource.shared.selectedEventInfo = DataSource.shared.EventInfo[indexPath.row]
        //self.selectedEventName = DataSource.shared.eventList[indexPath.row]
        //self.selectedEventInfo = DataSource.shared.EventInfo[indexPath.row]
        self.performSegue(withIdentifier: "ShowEventDetail", sender: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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


    // MARK: - Navigation

/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? EventViewController {
            nextVC.eventName = self.selectedEventName
            nextVC.eventInfo = self.selectedEventInfo
        }
    }
*/

}
