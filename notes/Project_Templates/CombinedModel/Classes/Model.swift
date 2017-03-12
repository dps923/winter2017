//
//  Model.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import CoreData

//
// This model uses Core Data for storage
// It can also use one or more web services
// Add data management properties and methods to this class
//

class Model {

    let cdStack: CDStack
    let frc_example: NSFetchedResultsController<Example>

    // Property to hold/store the fetched collection
    var programs = [Program]()
    
    // The delegate gets called to report that the data has changed
    weak var delegate: WebServiceRequestDelegate? = nil

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
        
        // Fetch the School of ICT programs from the web service
        programsGet()
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

    func execute(fetchRequest fr: NSFetchRequest<NSFetchRequestResult>) -> [Any] {

        // Define an empty results container
        var results = [Any]()
        
        // Attempt to do the fetch
        do {
            results = try cdStack.managedObjectContext.fetch(fr)
        } catch  {
            print("Fetch error: \(error)")
        }
        
        return results
    }
    
    /*
    func execute(fetchRequest fr: NSFetchRequest<NSFetchRequestResult>) -> NSPersistentStoreResult {
        
        // Define and prepare an object to hold an error
        //var error: NSError? = nil
        
        // Execute the fetch request
        var results: NSPersistentStoreResult? = nil
    
        do {
            results = try cdStack.managedObjectContext.execute(fr)
        } catch  {
            fatalError("oops \(error)")
        }
        
        return results!
    }
    */
    
    // Method to fetch the collection of academic programs from the School of ICT web service
    func programsGet() {
        let request = WebServiceRequest()
        request.sendRequest(toUrlPath: "/programs", dataKeyName: nil, completion: {
            (result: [AnyObject]) in
            for item in result {
                guard let programDict = item as? [String:AnyObject] else {
                    continue
                }
                
                var program = Program()
                if let name = programDict["Name"] as? String {
                    program.name = name
                }
                if let code = programDict["Code"] as? String {
                    program.code = code
                }
                if let id = programDict["Id"] as? Int {
                    program.id = id
                }
                self.programs.append(program)
            }
            
            // notify the delegate
            self.delegate?.webServiceRequestDidChangeContent(model: self)
        })
    }
}

struct Program {
    var code = ""
    var id = -1
    var name = ""
}
