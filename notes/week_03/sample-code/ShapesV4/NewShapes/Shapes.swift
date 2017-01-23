//
//  ViewController.swift
//  NewShapes
//
//  Created by Peter McIntyre on 2015-04-05.
//  Copyright (c) 2015 Seneca College. All rights reserved.
//

import UIKit

class Shapes: UIViewController {
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - User interface actions

    // Create and configure instances of our custom view object

    @IBAction func toggleFred(_ sender: UISwitch) {

        if sender.isOn {
            
            // Get the image
            let image = UIImage(named: "fred-flintstone")!
            
            // Create a shape, first two arguments are relative to the upper-left corner
            // The last two arguments are the x-width and the y-height
            let newShape = Shape(frame: CGRect(x: 20, y: 100, width: image.size.width, height: image.size.height))
            // Pass the image to the new 'Shape' object
            newShape.shape = image
            newShape.tag = 1
            
            // Add the new shape to the view
            self.view.addSubview(newShape)

        } else {
            
            // Locate the shape to be removed
            let shapeToBeRemoved = self.view.viewWithTag(1)!
            // Remove the shape
            shapeToBeRemoved.removeFromSuperview()
        }
    }
    
    @IBAction func toggleWilma(_ sender: UISwitch) {

        if sender.isOn {
            let image = UIImage(named: "wilma-flintstone")!
            let newShape = Shape(frame: CGRect(x: 200, y: 80, width: image.size.width, height: image.size.height))
            newShape.shape = image
            newShape.tag = 2
            self.view.addSubview(newShape)
        } else {
            let shapeToBeRemoved = self.view.viewWithTag(2)!
            shapeToBeRemoved.removeFromSuperview()
        }
    }
    
    @IBAction func togglePebbles(_ sender: UISwitch) {

        if sender.isOn {
            let image = UIImage(named: "pebbles-flintstone")!
            let newShape = Shape(frame: CGRect(x: 320, y: 200, width: image.size.width, height: image.size.height))
            newShape.shape = image
            newShape.tag = 3
            self.view.addSubview(newShape)
        } else {
            let shapeToBeRemoved = self.view.viewWithTag(3)!
            shapeToBeRemoved.removeFromSuperview()
        }
    }
    
}

