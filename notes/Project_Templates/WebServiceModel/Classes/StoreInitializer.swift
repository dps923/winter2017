//
//  StoreInitializer.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import CoreData

class StoreInitializer {
    
    class func populateInitialData(cdStack: CDStack) {
        // Add code to populate the data store with initial data
        
        // For each object that you want to create...
        // Initialize an object
        // Set its properties
        // Save changes
        
        // This app will work with the "Example" entity that you can see in the object model
        
        // If you have not yet run the app (in the simulator), 
        // and you want to create your own object model, you can...
        // Comment out (or delete) the 'create data' code below
        // Delete the entity in the object model
        // Edit the Model class, and its fetched results controller (uses of 'Example' class need to change)
        // Comment out, delete, or edit the data access statements in the '...List' and '...Detail' controllers

        // If you have run the app in the simulator,
        // you will have to do the above, AND delete the app from the simulator

        let obj = Example(context: cdStack.managedObjectContext)
        obj.attribute1 = "Peter"
        obj.attribute2 = 33
        
        let object2 = Example(context: cdStack.managedObjectContext)
        object2.attribute1 = "Danny"
        object2.attribute2 = 29
        
        cdStack.save()
    }
}
