//
//  Shape.swift
//  NewShapes
//
//  Created by Peter McIntyre on 2015-04-05.
//  Copyright (c) 2015 Seneca College. All rights reserved.
//

import UIKit

class Shape: UIView {

    var shape: UIImage?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.red.cgColor
        // This is necessary (leave it out and you'll see why)
        self.backgroundColor = UIColor.clear

        // Handle single taps
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(Shape.tapSingleHandler))
        tapSingle.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapSingle)

        // Handle double taps
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(Shape.tapDoubleHandler))
        tapDouble.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapDouble)

        // Handle two-finger touch (tap)
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(Shape.tapTwoHandler))
        tapTwo.numberOfTouchesRequired = 2
        self.addGestureRecognizer(tapTwo)

        // Handle pinch and zoom
        let pinchZoom = UIPinchGestureRecognizer(target: self, action: #selector(Shape.pinchZoomHandler(_:)))
        self.addGestureRecognizer(pinchZoom)

        // Handle rotation
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(Shape.rotateHandler(_:)))
        self.addGestureRecognizer(rotate)

        // Enable multi-touch on this view
        self.isMultipleTouchEnabled = true
    }

    // This method MUST be implemented in a UIView subclass like this
    override func draw(_ rect: CGRect) {
        shape?.draw(in: rect)
    }

    // MARK: - Touch handlers

    // The following are the touch-handling methods (for single-touch scenarios)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        // This is the method that does the most work

        // In a single-touch scenario, the "touches" NSSet has one object in it
        // Get that object...
        // A UITouch object represents the presence or movement of a finger on the screen
        if let aTouch = touches.first {
            // Now, get the starting and end points (in our drag operation)
            let location = aTouch.location(in: self)
            let previousLocation = aTouch.previousLocation(in: self)

            // Get the frame for this view
            var shapeNewFrame = self.frame

            // Figure out where the new location is (compared to the previous location)
            let deltaX: CGFloat = location.x - previousLocation.x
            let deltaY: CGFloat = location.y - previousLocation.y

            // Set the new location
            shapeNewFrame.origin.x += deltaX
            shapeNewFrame.origin.y += deltaY;
            self.frame = shapeNewFrame
        }
    }

    func tapSingleHandler() {

        // Move this to the top of the superview's view hierarchy
        self.superview?.bringSubview(toFront: self)
    }

    func tapDoubleHandler() {

        // Grow the shape by 10%
        let shapeNewFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width * 1.1, height: self.frame.height * 1.1)
        self.frame = shapeNewFrame
    }

    func tapTwoHandler() {

        // Shrink the shape by 10%
        let shapeNewFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width / 1.1, height: self.frame.height / 1.1)
        self.frame = shapeNewFrame
    }

    func pinchZoomHandler(_ recognizer: UIPinchGestureRecognizer) {
        
        // Handle pinch or zoom
        recognizer.view!.transform = recognizer.view!.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }
    
    func rotateHandler(_ recognizer: UIRotationGestureRecognizer) {
        
        // Handle rotation
        recognizer.view!.transform = recognizer.view!.transform.rotated(by: recognizer.rotation);
        recognizer.rotation = 0;
    }
    
}
