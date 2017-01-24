//
//  ExampleDetail.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-01.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit

class ExampleDetail: UIViewController {

    // Data object, passed in by the parent view controller in the segue method
    var detailItem: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Simply display some data in the debug console
        let att1 = self.detailItem.valueForKey("attribute1") as String
        let att2 = self.detailItem.valueForKey("attribute2") as Int
        print("Detail item: \(att1), \(att2)")
    }

}
