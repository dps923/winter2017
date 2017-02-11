//
//  Model.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import CoreData

// Needed for CoreData code generation
@objc(Province)
class Province : NSManagedObject {}


//
// This model uses Core Data for storage.
//

class Model {
    let cdStack: CDStack
    let frc_province: NSFetchedResultsController<Province>

    // MARK: - Public methods

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
                useStoreInitializer = true
            }
        }

        cdStack = CDStack()

        frc_province = cdStack.frcForEntityNamed("Province", withPredicateFormat: nil, predicateObject: nil, sortDescriptors: [NSSortDescriptor(key: "provinceName", ascending: true)], andSectionNameKeyPath: nil)

        if useStoreInitializer {
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

    func addNewProvince() -> Province {
        guard let entity = NSEntityDescription.entity(forEntityName: "Province", in: cdStack.managedObjectContext) else {
            fatalError("Can't create entity named Province")
        }
        return Province(entity: entity, insertInto: cdStack.managedObjectContext)
    }


    // Even more specific 'add new province' method
    func addNewProvince(provinceName: String, premierName: String, areaInKm: Int32, dateCreated: NSDate) -> Province {
        let newProvince = addNewProvince()
        newProvince.provinceName = provinceName
        newProvince.premierName = premierName
        newProvince.areaInKm = areaInKm
        newProvince.dateCreated = dateCreated
        return newProvince
    }

}
