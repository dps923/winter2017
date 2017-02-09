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
    
    var frc: NSFetchedResultsController<Example>!
    
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

        // Perform fetch
        performFetch()
    }

    func performFetch() {
        // Configure and load the fetched results controller (frc)
        frc = model.frc_example

        // This controller will be the frc delegate
        frc?.delegate = self;
        // No predicate (which means the results will NOT be filtered)
        frc?.fetchRequest.predicate = nil;

        // Perform fetch, and if there's an error, log it
        do {
            try frc?.performFetch()
        } catch let error as NSError {
            print(error.description)
        }
        let tableView = view as! UITableView
        tableView.reloadData()
    }
    

    // MARK: - Table view methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.frc.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.frc.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        let item = frc.object(at: indexPath)
        cell.textLabel!.text = item.attribute1
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toExampleDetail" {
            // Get a reference to the destination view controller
            let vc = segue.destination as! ExampleDetail
            
            // From the data source (the fetched results controller)...
            // Get a reference to the object for the tapped/selected table view row
            let item: Example = frc.object(at: self.tableView.indexPathForSelectedRow!)

            // Pass on the object
            vc.detailItem = item
            
            // Configure the view if you wish
            vc.title = item.attribute1
        }
    }

}
