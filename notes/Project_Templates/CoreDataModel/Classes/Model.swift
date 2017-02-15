//
//  Model.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import CoreData

//
// This model uses Core Data for storage.
//

class Model {
    let cdStack: CDStack
    let frc_example: NSFetchedResultsController<Example>

    // MARK: - Public methods

    // Shortcut to get the managed object context.
    // This uses a Swift 'calculated property', and is the same as writing a getter-type function:
    // `func context() -> NSManagedObjectContext { return cdStack.managedObjectContext }`
    var context: NSManagedObjectContext {
        return cdStack.managedObjectContext
    }

    init() {
        var useStoreInitializer = false
        if Model.isFirstLaunch() {
            // URL to the object store file in the app bundle
            let storeFileInBundle = Bundle.main.url(forResource: "ObjectStore", withExtension: "sqlite")

            // Check whether the app is supplied with starter data in the app bundle
            let hasStarterData = storeFileInBundle != nil

            if hasStarterData {
                // Use the supplied starter data, abort if error copying
                try! FileManager.default.copyItem(at: storeFileInBundle!, to: Model.pathToStoreFileInDocumentsDir())
            } else {
                useStoreInitializer = true // used at the end of init to load in initial data 
            }
        }

        cdStack = CDStack()

        frc_example = cdStack.frcForEntityNamed("Example", withPredicateFormat: nil, predicateObject: nil, sortDescriptors: [NSSortDescriptor(key: "attribute1", ascending: true)], andSectionNameKeyPath: nil)

        if useStoreInitializer {
            // In init(), you can only use 'self' after all properties have been initialised. Leave this function near the end.
            StoreInitializer.populateInitialData(model: self)
        }
    }

    static func pathToStoreFileInDocumentsDir() -> URL {
        let applicationDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return applicationDocumentsDirectory.appendingPathComponent("ObjectStore.sqlite")
    }

    static func isFirstLaunch() -> Bool {
        // Check whether this is the first launch of the app
        return !FileManager.default.fileExists(atPath: pathToStoreFileInDocumentsDir().path)
    }

    func saveChanges() {
        cdStack.save()
    }

    // Add more methods here for data maintenance
    // For example, get-all, get-some, get-one, add, update, delete
    // And other command-oriented operations

}
