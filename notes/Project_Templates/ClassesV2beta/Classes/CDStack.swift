//
//  CDStack.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import CoreData

class CDStack {
    static let shared = CDStack()

    var isReady = false

    fileprivate init() {}

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
            fatalError("Fatal error with setting up Core Data Stack")
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
            print("Persistent store coordinator could not be created (CDStack)")
            print("Error \(error)")
            assert(false)
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
            assert(false, "Managed object model is nil")
            print("Object model was not found (CDStack)")
        }
    }()

    // MARK: - Public methods

    func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                fatalError("CDStack save error \(error), \(error.userInfo)")
            }
        }
    }

    func frcForEntityNamed<T>(_ entityName: String, withPredicateFormat predicate: String?, predicateObject: [AnyObject]?, sortDescriptors: String?, andSectionNameKeyPath sectionName: String?) -> NSFetchedResultsController<T> {

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
        if predicate != nil {
            fetchRequest.predicate = NSPredicate(format: predicate!, argumentArray: predicateObject!)
        }

        // Configure the sort descriptors
        if sortDescriptors != nil {

            // Create an array to accumulate the sort descriptors
            var sdArray: [NSSortDescriptor] = []

            // Make an array from the passed-in string
            // Examples include...
            // nil
            // attribute1,true
            // attribute1,true,attribute2,false
            // etc.
            var sdStrings: [String] = sortDescriptors!.components(separatedBy: ",")

            // Iterate through the sdStrings array, and make sort descriptor objects
            for i in stride(from: 0, to: sdStrings.count, by: 2) { // swift 3 uses `stride` for performing loop steps greater than 1
                let sd: NSSortDescriptor = NSSortDescriptor(key: sdStrings[i], ascending: NSString(string: sdStrings[i + 1]).boolValue)
                // Add to the sort descriptors array
                sdArray.append(sd)
            }
            
            fetchRequest.sortDescriptors = sdArray
        }
        
        // Important note!
        
        // This factory does NOT configure a cache for the fetched results controller
        // Therefore, if your app is complex and you need the cache, 
        // replace "nil" with "entityName" in the following statement
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:managedObjectContext, sectionNameKeyPath: sectionName, cacheName: nil)
    }
    
}
