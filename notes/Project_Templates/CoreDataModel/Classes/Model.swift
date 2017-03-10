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

    func exampleEntity() -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: "Example", in: context) else {
            fatalError("Can't create entity named Example")
        }
        return entity
    }

    // Add more methods here for data maintenance
    // For example, get-all, get-some, get-one, add, update, delete
    // And other command-oriented operations

    func get(withPredicate: NSPredicate?) -> [Example]? {
        let fetchRequest: NSFetchRequest<Example> = Example.fetchRequest()
        fetchRequest.predicate = withPredicate

        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return nil
    }

    func getAll() -> [NSManagedObject]? {
        return get(withPredicate: nil)
    }

    func count(withPredicate: NSPredicate) -> Int {
        let fetchRequest: NSFetchRequest<Example> = Example.fetchRequest()
        fetchRequest.predicate = withPredicate

        do {
            let results = try context.count(for: fetchRequest)
            return results
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return 0
    }

    func deleteAll() {
        if let result = getAll() {
            for obj in result {
                context.delete(obj)
            }
        }
    }

    func delete(item: Example) {
        context.delete(item)
    }
}
