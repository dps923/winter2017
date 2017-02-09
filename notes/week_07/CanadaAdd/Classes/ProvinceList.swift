//
//  ProvinceList.swift
//  Canada
//
//  Created by Peter McIntyre on 2015-02-04.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit
import CoreData

// Notice the protocol conformance
class ProvinceList: UITableViewController, NSFetchedResultsControllerDelegate, EditItemDelegate {

    // MARK: - Private properties

    var frc: NSFetchedResultsController<Province>!

    // MARK: - Properties

    // Passed in by the app delegate during app initialization
    var model: Model!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure and load the fetched results controller (frc)

        frc = model.frc_province

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

    // This code you will customize
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell

        self.configure(cell: cell, atIndexPath: indexPath)

        return cell
    }

    func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        // Get the item for the selected index path
        let item: Province = frc.object(at: indexPath)
        // Configure the cell contents
        cell.textLabel!.text = item.provinceName
    }

    // This 'brute force' method will reload the table view
    // The method gets called by the Cocoa runtime,
    // when it notices that the fetched results controller's
    // 'fetchedObjects' (results) collection has changed
    // (because a new item was added)
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toProvinceDetail" {

            // Get a reference to the destination view controller
            let vc = segue.destination as! ProvinceDetail

            // From the data source (the fetched results controller)...
            // Get a reference to the object for the tapped/selected table view row
            let item: Province = frc.object(at: self.tableView.indexPathForSelectedRow!)

            // Pass on the object
            vc.detailItem = item

            // Configure the view if you wish
            vc.title = item.provinceName
        }

        if segue.identifier == "toProvinceEdit" {

            // Get a reference to the destination view controller
            let nav = segue.destination as! UINavigationController
            let vc = nav.topViewController as! ProvinceEdit

            // Configure the view
            vc.delegate = self
            vc.model = self.model
        }
    }

    // MARK: - Delegate methods

    func editItem(controller: UIViewController, didEditItem item: AnyObject?) {

        self.model.saveChanges()

        // Dismiss the modal 'add item' controller
        controller.dismiss(animated: true, completion: nil)
    }
}
