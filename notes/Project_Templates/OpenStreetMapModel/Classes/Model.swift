//
//  Model.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import CoreData
import CoreLocation

//
// This model uses Core Data for storage
// It can also use one or more web services
// Add data management properties and methods to this class
//

struct OpenStreetMapResult {
    var coordinate: CLLocationCoordinate2D?
    var name: String?
    var tags: String?
}

class Model {
    // Property to hold/store the fetched collection
    var mapPoints = [OpenStreetMapResult]()
    
    // The delegate gets called to report that the data has changed
    weak var delegate: WebServiceRequestDelegate? = nil

    init() {
        getSomeTorontoRestaurants()
    }

    
    // Method to fetch restaurants in 5km region around center coordinate for Toronto
    func getSomeTorontoRestaurants() {
        let request = WebServiceRequest()
        request.osmSearch(lat: 43.65, long: -79.38, regionSizeInKm: 5.0)

        request.sendRequest(toUrlPath: "", dataKeyName: "elements", completion: {
            (result: [AnyObject]) in
            for item in result {
                guard let node = item as? [String:AnyObject] else {
                    continue
                }

                if let lat = node["lat"] as? Double, let long = node["lon"] as? Double {
                    var r = OpenStreetMapResult()
                    r.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

                    if let tags = node["tags"] as? [String: Any], let name = tags["name"] as? String {
                        r.name = name
                        
                        // Turns a dictionary into a string formatted as key : value, one per line
                        r.tags = tags.reduce("") { $0! + "\($1.key) : \($1.value)\n" }

                        self.mapPoints.append(r)
                    } else {
                        print("ignoring results with no name and tags")
                    }
                }
            }

            // notify the delegate
            self.delegate?.webServiceRequestDidChangeContent(model: self)
        })
    }
}
