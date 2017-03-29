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
class ExampleList: UITableViewController, NSFetchedResultsControllerDelegate, WebServiceRequestDelegate {

    // MARK: - Properties

    // Passed in by the app delegate during app initialization
    var model: Model!

    // MARK: - WebServiceRequestDelegate

    func webServiceRequestDidChangeContent(model: Model) {
        tableView.reloadData()
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Now we will get notified when data is ready to show. See webServiceRequestDidChangeContent above.
        model.delegate = self
    }

    // MARK: - Table view methods

    // You can use this code as-is, it should handle most cases
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // You can use this code as-is, it should handle most cases
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.mapPoints.count
    }

    // You can use this code as-is, it should handle most cases
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        self.configure(cell: cell, atIndexPath: indexPath)
        return cell
    }

    // Code you will customize to setup the cell
    func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        let program = model.mapPoints[indexPath.row]
        cell.textLabel!.text = program.name
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toExampleDetail" {
            // Get a reference to the destination view controller
            let vc = segue.destination as! ExampleDetail
            
            // From the data source (the fetched results controller)...
            // Get a reference to the object for the tapped/selected table view row
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = model.mapPoints[row]

                // Pass on the object
                vc.detailItem = item.tags ?? ""

                vc.title = item.name
            }
        }
    }
}
