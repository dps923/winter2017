//
//  Model.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import CoreData

class Model {

    // MARK: - Private properties

    fileprivate var cdStack: CDStack!

    lazy fileprivate var applicationDocumentsDirectory: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
    }()

    // MARK: - Public properties

    //Use this as a template to create other fetched results controllers. Replace `Example` with the entity type you are fetching
    lazy var frc_example: NSFetchedResultsController<Example> = {
        let fetchRequest: NSFetchRequest<Example> = Example.fetchRequest()
        let sortDescriptors = [NSSortDescriptor(key: "attribute1", ascending: true)]
        fetchRequest.sortDescriptors = sortDescriptors
        let frc = NSFetchedResultsController<Example>(fetchRequest: fetchRequest, managedObjectContext: CDStack.shared.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()

    // MARK: - Public methods

    init() {

        // Check whether the app is being launched for the first time
        // If yes, check if there's an object store file in the app bundle
        // If yes, copy the object store file to the Documents directory
        // If no, create some new data if you need to

        // URL to the object store file in the app bundle
        let storeFileInBundle = Bundle.main.url(forResource: "ObjectStore", withExtension: "sqlite")

        // URL to the object store file in the Documents directory
        let storeFileInDocumentsDirectory = applicationDocumentsDirectory.appendingPathComponent("ObjectStore.sqlite")

        // System file manager
        let fs = FileManager()

        // Check whether this is the first launch of the app
        let isFirstLaunch = !fs.fileExists(atPath: storeFileInDocumentsDirectory.path)

        // Check whether the app is supplied with starter data in the app bundle
        let hasStarterData = storeFileInBundle != nil

        if isFirstLaunch {
            if hasStarterData {
                // Use the supplied starter data, abort if error copying
                try! fs.copyItem(at: storeFileInBundle!, to: storeFileInDocumentsDirectory)
            } else {
                // Create some new data
                StoreInitializer.populateInitialData(CDStack.shared)
            }
        }

        // make sure CDStack is intitialized
        let _ = CDStack.shared
    }

    func saveChanges() {
        cdStack.save()
    }

    // Add more methods here for data maintenance
    // For example, get-all, get-some, get-one, add, update, delete
    // And other command-oriented operations
    
}
