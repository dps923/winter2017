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

    init() {
        if Model.isFirstLaunch() {
            // URL to the object store file in the app bundle
            let storeFileInBundle = Bundle.main.url(forResource: "ObjectStore", withExtension: "sqlite")

            // Check whether the app is supplied with starter data in the app bundle
            let hasStarterData = storeFileInBundle != nil

            if hasStarterData {
                // Use the supplied starter data, abort if error copying
                try! FileManager.default.copyItem(at: storeFileInBundle!, to: Model.pathToStoreFileInDocumentsDir())
                cdStack = CDStack()
            } else {
                // Create some new data
                cdStack = CDStack()
                StoreInitializer.populateInitialData(cdStack: cdStack)
            }
        } else {
            cdStack = CDStack()
        }

        frc_example = cdStack.frcForEntityNamed("Example", withPredicateFormat: nil, predicateObject: nil, sortDescriptors: [NSSortDescriptor(key: "attribute1", ascending: true)], andSectionNameKeyPath: nil)
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
