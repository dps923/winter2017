//
//  Shape.swift
//  NewShapes
//
//  Created by Peter McIntyre on 2015-04-05.
//  Copyright (c) 2015 Seneca College. All rights reserved.
//

import UIKit

class Shape: UIView {
    
    // MARK: - Class members
    var shapeTypeLabel: String = ""
    var shapeColor: CGColor = UIColor.black.cgColor

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
        // This is necessary (leave it out and you'll see why)
        self.backgroundColor = UIColor.clear
    }

    // This method MUST be implemented in a UIView subclass like this
    override func draw(_ rect: CGRect) {
        
        // Get the graphics context
        let context = UIGraphicsGetCurrentContext()
        
        // Configure the drawing settings with the passed-in color
        context?.setLineWidth(1.0);
        context?.setStrokeColor(shapeColor);
        context?.setFillColor(shapeColor);
        
        // Draw the shape's word/name inside the passed-in rectangle
        
        switch self.shapeTypeLabel {
            
        case "Square", "Rectangle":
            // ...AddRect... can draw both squares and rectangles
            context?.addRect(rect);
            context?.fill(rect);
            
        case "Circle", "Ellipse":
            // ...AddEllipse... can draw both circles and ellipses
            context?.addEllipse(in: rect);
            context?.fillEllipse(in: rect);
            
        default:
            break
        }

        drawShapeLabelIn(rect: rect)
    }

    private func drawShapeLabelIn(rect: CGRect) {
        // Position the shape's word/name a little better
        // This is a hacky way to do it, but it keeps the lines of code to a minimum
        shapeTypeLabel = "\n\(shapeTypeLabel)"
        let centerTextStyle = NSMutableParagraphStyle()
        centerTextStyle.alignment = NSTextAlignment.center

        // Draw the shape's word/name on the shape
        shapeTypeLabel.draw(in: rect, withAttributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20), NSParagraphStyleAttributeName : centerTextStyle])
    }
}
