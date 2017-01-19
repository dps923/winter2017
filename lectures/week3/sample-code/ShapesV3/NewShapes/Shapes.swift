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

    @IBAction func toggleSquare(_ sender: UISwitch) {

        if sender.isOn {

            // Create a shape, first two arguments are relative to the upper-left corner
            // The last two arguments are the x-width and the y-height
            let newShape = Shape(frame: CGRect(x: 20, y: 110, width: 100, height: 100))

            // Configure the properties
            newShape.shapeTypeLabel = "Square"
            newShape.shapeColor = UIColor.orange.cgColor
            newShape.tag = 1

            // Add the new shape to the view
            self.view.addSubview(newShape)

        } else {

            // Locate the shape to be removed
            let shapeToBeRemoved = self.view.viewWithTag(1)
            // Remove the shape
            shapeToBeRemoved?.removeFromSuperview()
        }
    }

    @IBAction func toggleRectangle(_ sender: UISwitch) {

        if sender.isOn {
            let newShape = Shape(frame: CGRect(x: 60, y: 150, width: 100, height: 225))
            newShape.shapeTypeLabel = "Rectangle"
            newShape.shapeColor = UIColor.red.cgColor
            newShape.tag = 2
            self.view.addSubview(newShape)
        } else {
            let shapeToBeRemoved = self.view.viewWithTag(2)
            shapeToBeRemoved?.removeFromSuperview()
        }
    }

    @IBAction func toggleCircle(_ sender: UISwitch) {

        if sender.isOn {
            let newShape = Shape(frame: CGRect(x: 100, y: 190, width: 150, height: 150))
            newShape.shapeTypeLabel = "Circle"
            newShape.shapeColor = UIColor.magenta.cgColor
            newShape.tag = 3
            self.view.addSubview(newShape)
        } else {
            let shapeToBeRemoved = self.view.viewWithTag(3)
            shapeToBeRemoved?.removeFromSuperview()
        }
    }

    @IBAction func toggleEllipse(_ sender: UISwitch) {
        if sender.isOn {
            let newShape = Shape(frame: CGRect(x: 140, y: 230, width: 225, height: 100))
            newShape.shapeTypeLabel = "Ellipse"
            newShape.shapeColor = UIColor.blue.cgColor
            newShape.tag = 4
            self.view.addSubview(newShape)
        } else {
            let shapeToBeRemoved = self.view.viewWithTag(4)
            shapeToBeRemoved?.removeFromSuperview()
        }
    }
    
}

