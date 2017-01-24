//
//  CDStack.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import CoreData

extension Notification.Name {
    static let onCDStackReady = Notification.Name("cdstack-on-ready")
}

class CDStack {

    static let shared = CDStack()

    var isReady = false
    var persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "ObjectModel")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // This callback is happening on the main thread; when the db is loaded and ready for use (or an error)
            if let error = error {
                fatalError("CDStack error \(error)")
            }
            self.isReady = true
            NotificationCenter.default.post(name:.onCDStackReady, object: nil)
        })
    }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func save() {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
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
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.viewContext)!
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

        return NSFetchedResultsController<T>(fetchRequest: fetchRequest, managedObjectContext: CDStack.shared.viewContext, sectionNameKeyPath: sectionName, cacheName: nil)
    }
}
