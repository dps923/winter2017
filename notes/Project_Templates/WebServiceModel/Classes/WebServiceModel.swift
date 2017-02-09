//
//  Model.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import CoreData

class WebServiceModel : Model {
    // Property to hold/store the fetched collection
    var programs = [AnyObject]()

    // Method to fetch the collection
    func programsGet() -> [AnyObject] {
        let request = WebServiceRequest()
        request.sendRequestToUrlPath("/programs", forDataKeyName: "Collection", from: self, propertyNamed: "programs")

        // Return an empty array; when the request completes,
        // the WebServiceRequest object will replace the value of 'programs'
        // with the fetched results, and will send a notification
        return [AnyObject]()
    }

    // The next two properties may - or may not - survive the final version of the

    // Interim; may be changed
    lazy var networkCollection: [AnyObject] = {
        // Placeholder
        return ["hello", "world"]
    }() as [AnyObject]

    // Interim; may be changed
    lazy var networkObject: AnyObject = {
        // Placeholder
        return "hello"
    }() as AnyObject
}
