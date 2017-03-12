//
//  StoreInitializer.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import CoreData

class StoreInitializer {
    
    class func populateInitialData(model: Model) {
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

        guard let entity = NSEntityDescription.entity(forEntityName: "Example", in: model.context) else {
            fatalError("Can't create entity named Example")
        }
        
        let obj: Example
        if #available(iOS 10.0, *) {
            // Once you switch to iOS 10-only, the API looks nicer. I just put this here for reference.
            obj = Example(context: model.context)
        } else {
            obj = Example(entity: entity, insertInto: model.context)
        }
        obj.attribute1 = "Peter"
        obj.attribute2 = 33

        let obj2 = Example(entity: entity, insertInto: model.context)
        obj2.attribute1 = "Garvan"
        obj2.attribute2 = 29
        
        model.saveChanges()
    }
}
