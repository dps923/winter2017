//
//  ProvinceDetail.swift
//  Canada
//
//  Created by Peter McIntyre on 2015-02-04.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit

class ProvinceDetail: UIViewController {
    
    // MARK: - User interface
    
    @IBOutlet weak var provinceName: UILabel!
    @IBOutlet weak var premierName: UILabel!
    @IBOutlet weak var areaInKm: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    
    // MARK: - Public properties
    
    // Data object, passed in by the parent view controller in the segue method
    var detailItem: Province!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If an item was passed in, display it in the user interface

        if detailItem == nil {
            
            provinceName.text = "(error)"
            premierName.text = "(error)"
            areaInKm.text = "(error)"
            dateCreated.text = "(error)"
            
        } else {
            
            provinceName.text = detailItem.provinceName
            premierName.text = "Premier: " + detailItem.premierName!

            areaInKm.text = "Area in square km: \(detailItem.areaInKm)"

            // Your code, probably...
            dateCreated.text = "Confederation: \(detailItem.dateCreated)"
            
            // Nicely-formatted date...
            let date = DateFormatter.localizedString(from: detailItem.dateCreated as! Date, dateStyle: .long, timeStyle: .none)
            dateCreated.text = "Confederation: " + date
        }
    }
}
