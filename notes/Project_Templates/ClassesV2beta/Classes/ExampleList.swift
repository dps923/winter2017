//
//  ExampleList.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit
import CoreData

// Notice the protocol conformance
class ExampleList: UITableViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Private properties
    
    var frc: NSFetchedResultsController!
    
    // MARK: - Properties

    // Passed in by the app delegate during app initialization
    var model: Model!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure and load the fetched results controller (frc)
        
        frc = model.frc_example

        // This controller will be the frc delegate
        frc.delegate = self;
        // No predicate (which means the results will NOT be filtered)
        frc.fetchRequest.predicate = nil;
        
        // Create an error object
        var error: NSError? = nil
        // Perform fetch, and if there's an error, log it
        if !frc.performFetch(&error) { print(error?.description) }
    }

    // MARK: - Table view methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.frc.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = self.frc.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        self.configureCell(cell, atIndexPath: indexPath)

        return cell
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let item: AnyObject = frc.objectAtIndexPath(indexPath)
        cell.textLabel!.text = item.valueForKey("attribute1")! as? String
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toExampleDetail" {

            // Get a reference to the destination view controller
            let vc = segue.destinationViewController as ExampleDetail
            
            // From the data source (the fetched results controller)...
            // Get a reference to the object for the tapped/selected table view row
            let item: AnyObject = frc.objectAtIndexPath(self.tableView.indexPathForSelectedRow()!)
            
            // Pass on the object
            vc.detailItem = item
            
            // Configure the view if you wish
            vc.title = item.valueForKey("attribute1") as? String
        }
    }

}
