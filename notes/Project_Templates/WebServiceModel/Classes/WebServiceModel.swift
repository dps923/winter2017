//
//  Model.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import CoreData

struct Program {
    var code = ""
    var id = -1
    var name = ""
}

protocol WebServiceModelDelegate : class {
    func webServiceModelDidChangeContent(model: WebServiceModel)
}

class WebServiceModel {
    // Property to hold/store the fetched collection
    var programs = [Program]()

    // The delegate gets called to report that the data has changed
    weak var delegate: WebServiceModelDelegate? = nil

    init() {
        programsGet()
    }

    // Method to fetch the collection
    func programsGet() {
        let request = WebServiceRequest()
        request.sendRequest(toUrlPath: "/programs", dataKeyName: nil, propertyNamed: nil, completion: {
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
            self.delegate?.webServiceModelDidChangeContent(model: self)
        })
    }
}
