//
//  CDStack.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import CoreData

class CDStack {

    // MARK: - Public property with lazy initializer

    lazy var managedObjectContext: NSManagedObjectContext? = {
       
        // Create the MOC
        var moc = NSManagedObjectContext()
        
        // Configure it
        if self.persistentStoreCoordinator != nil {
            
            moc.persistentStoreCoordinator = self.persistentStoreCoordinator
            return moc
            
        } else {
            
            // If this code block executes, there's a problem in the MOM or PSC
            return nil
        }
        
    }()
    
    // MARK: - Internal properties with lazy initializers
    
    lazy private var applicationDocumentsDirectory: NSURL = {
        
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as NSURL
        }()
    
    lazy private var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
       
        // Create the PSC
        var psc: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        // Get the NSURL to the store file
        let storeURL: NSURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("ObjectStore.sqlite")
        
        // Configure lightweight migration
        let options: NSDictionary = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        
        // Prepare an error object
        var error: NSError? = nil
        
        // Configure the PSC with the store file
        if (psc!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error: &error) == nil) {
            
            // This code block will run if there is an error
            assert(false, "Persistent store coordinator is nil")
            print("Persistent store coordinator could not be created (CDStack)")
            print("Error \(error), \(error!.userInfo)")
        }
        
        return psc
    }()
    
    lazy private var managedObjectModel: NSManagedObjectModel = {
        
        // Get the NSURL to the data model file
        let modelURL = NSBundle.mainBundle().URLForResource("ObjectModel", withExtension: "momd")!
        
        if let mom = NSManagedObjectModel(contentsOfURL: modelURL) {
            
            // Return the result
            return mom
            
        } else {
            
            // This code block will run if there is an error
            assert(false, "Managed object model is nil")
            print("Object model was not found (CDStack)")
        }
        }()

    // MARK: - Public methods
    
    // Save the managed object context
    func saveContext() {
        
        // Create an error object
        var error: NSError? = nil
        
        // If there are changes to save, attempt to save them
        if self.managedObjectContext!.hasChanges && !self.managedObjectContext!.save(&error) {
            
            // This code block will run if there is an error
            assert(false, "Unable to save the changes")
            print("Unable to save the changes (CDStack)")
            print("Error \(error), \(error!.userInfo)")
        }
    }

    // Fetched results controller factory
    func frcForEntityNamed(entityName: String, withPredicateFormat predicate: String?, predicateObject: [AnyObject]?, sortDescriptors: String?, andSectionNameKeyPath sectionName: String?) -> NSFetchedResultsController {
        
        // This method will create and return a fully-configured fetched results controller (frc)
        // Its arguments are simple strings, for entity name, predicate, and sort descriptors
        // sortDescriptors can be nil, or a comma-separated list of attribute-boolean (true or false) pairs
        // After initialization, the code can change the configuration if needed
        // Before using an frc, you must call the performFetch method

        // Create the fetch request
        //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        var fetchRequest: NSFetchRequest = NSFetchRequest()
        
        // Configure the entity name
        let entity: NSEntityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: self.managedObjectContext!)!
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
            var sdStrings: [String] = sortDescriptors!.componentsSeparatedByString(",")
            
            // Iterate through the sdStrings array, and make sort descriptor objects
            for var i = 0; i < sdStrings.count; i+=2 {
                
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
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: sectionName, cacheName: nil)
    }
    
}
