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
class ExampleList: UITableViewController {

    // MARK: - Properties

    // Passed in by the app delegate during app initialization
    var model: Model!

    @IBAction func onEditButton(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    func doSearch(_ str: String) {
        let caseInsensitiveContains = NSPredicate(format: "attribute1 CONTAINS[c] %@", str)
        let count = model.count(withPredicate: caseInsensitiveContains)
        print("Found count: \(count)")
    }

    @IBAction func onSearchButton(_ sender: UIBarButtonItem) {

        func presentAlert() {
            let alertController = UIAlertController(title: nil, message: "Search for:", preferredStyle: .alert)

            let confirmAction = UIAlertAction(title: "Search", style: .default) { _ -> Void in
                if let value = alertController.textFields?[0].text {
                    // store your data
                    self.doSearch(value)
                }
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ -> Void in
                print("Was cancelled")
            }

            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Enter text to search for"
            })

            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }

        presentAlert()
    }

    @IBAction func reload(_ sender: Any) {
        StoreInitializer.populateInitialData(model: model)
        tableView.reloadData()
    }

// editing

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedItem: Example = frc.object(at: indexPath)
            model.delete(item: deletedItem)
        }
    }
//
    
    var frc: NSFetchedResultsController<Example>!

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frc = model.cdStack.frcForEntityNamed("Example", withPredicateFormat: "name beginswith 'Gar'", predicateObject: nil, sortDescriptors: [NSSortDescriptor(key: "attribute1", ascending: true)], andSectionNameKeyPath: nil)

        // This controller will be the frc delegate
        frc.delegate = self;

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

extension ExampleList : NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_
        controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
        default: break
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let index = newIndexPath {
                tableView.insertRows(at: [index], with: .automatic)
            }
        case .delete:
            if let index = indexPath {
                tableView.deleteRows(at: [index], with: .automatic)
            }
        case .update:
            if let index = indexPath {
                tableView.reloadRows(at: [index], with: .automatic)
            }
        case .move:
            if let deleteIndex = indexPath, let insertIndex = newIndexPath {
                tableView.deleteRows(at: [deleteIndex], with: .automatic)
                tableView.insertRows(at: [insertIndex], with: .automatic)
            }
        }
    }
}
