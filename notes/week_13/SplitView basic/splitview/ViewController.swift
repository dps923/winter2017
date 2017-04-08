//
//  ViewController.swift
//  SplitView
//
//  Created by Garvan Keeley on 2017-03-26.
//  Copyright © 2017 garvankeeley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    var rowNumber: Int? = nil

    override func viewDidAppear(_ animated: Bool) {
        if let rowNumber = rowNumber {
            label.text = "Row Num \(rowNumber)"
        }
    }
}

