//
//  ExampleDetail.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import UIKit

class ExampleDetail: UIViewController {

    // Data object, passed in by the parent view controller in the segue method
    var detailItem: Example!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Simply display some data in the debug console
        if let att1 = self.detailItem.attribute1 {
            let att2 = self.detailItem.attribute2
            print("Detail item: \(att1), \(att2)")
        }
    }

}
