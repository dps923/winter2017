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


        guard let entity = NSEntityDescription.entity(forEntityName: "Province", in: cdStack.managedObjectContext) else {
            fatalError("Can't create entity named Province")
        }

        let on = Province(entity: entity, insertInto: cdStack.managedObjectContext)
        on.provinceName = "Ontario"
        on.premierName = "Kathleen Wynne"
        on.areaInKm = 1076395
        on.dateCreated = newDate(year: 1867, month: 7, day: 1)

        let bc = Province(entity: entity, insertInto: cdStack.managedObjectContext)
        bc.provinceName = "British Columbia"
        bc.premierName = "Christy Clark"
        bc.areaInKm = 944735
        bc.dateCreated = newDate(year: 1871, month: 7, day: 20)

        let nb = Province(entity: entity, insertInto: cdStack.managedObjectContext)
        nb.provinceName = "New Brunswick"
        nb.premierName = "Brian Gallant"
        nb.areaInKm = 72908
        nb.dateCreated = newDate(year: 1867, month: 7, day: 1)

        /*
         let mb = Province(entity: entity, insertInto: cdStack.managedObjectContext)
         mb.provinceName = "Manitoba"
         mb.premierName = "Gary Selinger"
         mb.areaInKm = 649950
         mb.dateCreated = newDate(year: 1870, month: 7, day: 15)

         let nl = Province(entity: entity, insertInto: cdStack.managedObjectContext)
         nl.provinceName = "Newfoundland and Labrador"
         nl.premierName = "Paul Davis"
         nl.areaInKm = 405212
         nl.dateCreated = newDate(year:1949, month: 3, day: 31)
         */
        
        cdStack.save()
    }


    // Create a new date object
    class func newDate(year: Int, month: Int, day: Int) -> NSDate {

        // Configure the objects we need to create the date
        let cal = NSCalendar(identifier: .gregorian)!
        let dc = NSDateComponents()

        // Set the values of the date components
        dc.year = year
        dc.month = month
        dc.day = day
        dc.hour = 12
        dc.minute = 0
        dc.second = 0

        return cal.date(from: dc as DateComponents)! as NSDate
    }

}
