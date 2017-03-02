//
//  Model.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import CoreData

class WebServiceModel : Model {
    // Property to hold/store the fetched collection
    var programs = [AnyObject]()

    // Method to fetch the collection
    func programsGet(completion: @escaping ([AnyObject])->Void) {
        let request = WebServiceRequest()
        request.sendRequest(toUrlPath: "/programs", dataKeyName: "Collection", propertyNamed: "programs", completion: {
            (result: [AnyObject]) in
            completion(result)
        })
    }

    // The next two properties may - or may not - survive the final version of the

    // Interim; may be changed
    lazy var networkCollection: [Any] = {
        // Placeholder
        return ["hello", "world"] as [Any]
    }()
    
    // Interim; may be changed
    lazy var networkObject: AnyObject = {
        // Placeholder
        return "hello"
    }() as AnyObject
}
