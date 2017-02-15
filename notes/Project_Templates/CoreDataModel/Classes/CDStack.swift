//
//  CDStack.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import CoreData

// You can use this class without changes for your projects.
// There is one instance of CDStack in your projects and it is owned by the Model class
// for a CoreData-backed model.
//
// In order to keep this class simple, it doesn't have all the error-handling a production app should have,
// it aborts the app if there are any errors during setup.

class CDStack {

    // MARK: - Public property with lazy initializer
    lazy var managedObjectContext: NSManagedObjectContext! = {
        // Create the MOC
        var moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        // Configure it
        if self.persistentStoreCoordinator != nil {
            moc.persistentStoreCoordinator = self.persistentStoreCoordinator
            return moc
        } else {
            // If this code block executes, there's a problem in the MOM or PSC
            fatalError("Fatal error with setting up Core Data Stack NSManagedObjectContext")
        }
    }()
    
    // MARK: - Internal properties with lazy initializers
    
    lazy fileprivate var applicationDocumentsDirectory: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        }()
    
    lazy fileprivate var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // Create the PSC
        var psc: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        // Get the NSURL to the store file
        let storeURL: URL = self.applicationDocumentsDirectory.appendingPathComponent("ObjectStore.sqlite")
        
        // Configure lightweight migration
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]

        // Configure the PSC with the store file
        do {
            try psc!.addPersistentStore(
                ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        } catch {
            // This code block will run if there is an error
            fatalError("Persistent store coordinator could not be created (CDStack). Error: \(error)")
        }

        return psc
    }()
    
    lazy fileprivate var managedObjectModel: NSManagedObjectModel = {
        // Get the NSURL to the data model file
        let modelURL = Bundle.main.url(forResource: "ObjectModel", withExtension: "momd")!
        
        if let mom = NSManagedObjectModel(contentsOf: modelURL) {
            // Return the result
            return mom
        } else {
            // This code block will run if there is an error
            fatalError("Managed object model is nil")
        }
    }()

    // MARK: - Public methods

    func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                if let details = error.userInfo["NSDetailedErrors"] as? [NSError] {
                    for detail in details {
                        if let badKey = detail.userInfo["NSValidationErrorKey"], let badObject = detail.userInfo["NSValidationErrorObject"] {
                            let msg = "Error on save, check Core Data constraints on '\(badKey)'.\n" +
                                "(A non-optional attribute/relationship in core data can cause this.)\n" +
                            "Attempted to save object: \(badObject)"
                            print(msg)
                        }
                    }
                }
                // In a production app, you may not want a fatal error here. Is this something you should
                // warn the user about instead? Perhaps there is a way to recover from a problem saving.
                fatalError("CDStack save error \(error), \(error.userInfo)")
            }
        }
    }

    func frcForEntityNamed<T>(_ entityName: String, withPredicateFormat predicate: String?, predicateObject: [AnyObject]?, sortDescriptors: [NSSortDescriptor]?, andSectionNameKeyPath sectionName: String?) -> NSFetchedResultsController<T> {

        // This method will create and return a fully-configured fetched results controller (frc)
        // Its arguments are simple strings, for entity name, predicate, and sort descriptors
        // sortDescriptors can be nil, or a comma-separated list of attribute-boolean (true or false) pairs
        // After initialization, the code can change the configuration if needed
        // Before using an frc, you must call the performFetch method

        // Create the fetch request
        let fetchRequest = NSFetchRequest<T>()

        // Configure the entity name
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
        fetchRequest.entity = entity

        // Set the batch size to a reasonable number
        fetchRequest.fetchBatchSize = 20

        // Configure the predicate
        if let predicate = predicate, let predicateObject = predicateObject {
            fetchRequest.predicate = NSPredicate(format: predicate, argumentArray: predicateObject)
        }

        // Configure the sort descriptors
        if let sortDescriptors = sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        // Important note!
        
        // This factory does NOT configure a cache for the fetched results controller
        // Therefore, if your app is complex and you need the cache, 
        // replace "nil" with "entityName" in the following statement
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:managedObjectContext, sectionNameKeyPath: sectionName, cacheName: nil)
    }
    
}
