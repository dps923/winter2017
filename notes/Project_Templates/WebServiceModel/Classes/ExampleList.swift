//
//  ExampleList.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import UIKit
import CoreData

// Notice the protocol conformance
class ExampleList: UITableViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Properties

    // Passed in by the app delegate during app initialization
    var model: Model!

    var frc: NSFetchedResultsController<Example>!

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frc = model.frc_example

        // This controller will be the frc delegate
        frc.delegate = self;

        // No predicate (which means the results will NOT be filtered)
        frc.fetchRequest.predicate = nil;

        // Perform fetch, and if there's an error, log it
        do {
            try frc.performFetch()
        } catch let error as NSError {
            print(error.description)
        }
    }

    // MARK: - Table view methods

    // You can use this code as-is, it should handle most cases
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.frc.sections?.count ?? 0
    }

    // You can use this code as-is, it should handle most cases
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.frc.sections?[section].numberOfObjects ?? 0
    }

    // You can use this code as-is, it should handle most cases
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell

        self.configure(cell: cell, atIndexPath: indexPath)

        return cell
    }

    // Code you will customize to setup the cell
    func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        let item: Example = frc.object(at: indexPath)
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
