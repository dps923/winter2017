//
//  StoreInitializer.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import CoreData

class StoreInitializer {
    
    class func create(_ cdStack: CDStack) {
        
        // Add code to create data
        
        // For each object that you want to create...
        // Initialize an object
        // Set its properties
        // Save changes
        
        // This app will work with the "Example" entity that you can see in the object model
        
        // If you have not yet run the app (in the simulator), 
        // and you want to create your own object model, you can...
        // Comment out (or delete) the 'create data' code below
        // Delete the entity in the object model
        // Edit the Model class, and its fetched results controller
        // Comment out, delete, or edit the data access statements in the '...List' and '...Detail' controllers

        // If you have did run the app (in the simulator),
        // you will have to do the above, AND delete the app from the simulator
        let object1 = Example(context: CDStack.shared.viewContext)
        object1.attribute1 = "Peter"
        object1.attribute2 = 33

        let object2 = Example(context: CDStack.shared.viewContext)
        object2.attribute1 = "Danny"
        object2.attribute2 = 29

        CDStack.shared.save()
    }
    
    // Create a new date object
    class func newDate(_ year: Int, month: Int, day: Int) -> Date {
        
        // Configure the objects we need to create the date
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(abbreviation: "GMT")!
        var dc = DateComponents()
        
        // Set the values of the date components
        dc.year = year
        dc.month = month
        dc.day = day
        dc.hour = 12
        dc.minute = 0
        dc.second = 0
        
        return cal.date(from: dc)!
    }
    
}
