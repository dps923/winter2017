Introduction to graphics and touch.

#### Code examples for today’s topics

A series of four code examples has been published in the [sample-code](sample-code) of this course’s GitHub code repository. 
They introduce you to an app that works with graphics and touch.

#### Graphics introduction

iOS has five frameworks that can be used for graphics and animation:

> **UIKit** provides basic 2D drawing, image handling, and ways to animate user interface objects.
> 
> **Core Graphics** is a C-based API that supports vector graphics, bitmap images, and PDF content. [Core Graphics is also known as **Quartz 2D**.]
>
> **Core Animation** is part of the iOS graphics engine that adds smooth motion and dynamic feedback to the user interface. UIKit provides a simple API to animate views, this is using Core Animation. 
> 
> **OpenGL ES** is the mobile version of OpenGL for high-performance 2D and 3D drawing.
>
> **Metal** for high performance 3D graphics that arrived in iOS 8, which combines OpenGL and OpenCL concepts.

Today, you will use **UIKit** and **Core Graphics** capabilities.

**Programmatically creating a view**

Our user interfaces have included views that are defined on the storyboard.

Occasionally, we have added content views programmatically, but not often. 
You will recall adding buttons (add, save, cancel) in ‘add item’ situations.

The important idea today is that we will be programmatically creating graphics objects, 
and placing them on the apps’s visible surface.

For the explanation that follows, it will help if you think about the iOS device resting flat
 on a horizontal surface. We will then build a ‘view hierarchy’.

The window object is the first and bottom layer. An iOS app has one window object. 
Then, the iOS runtime typically adds a status bar, which you can see when viewing the home screen, or in many apps.

On top of the window object, a typical app adds another layer, which is a view. 
The size of the view typically matches the window size. In other words, full screen.

On top of the active full-screen view, your app (storyboard scene, or programmatically) 
can add more ‘view’ objects. These are placed in layers, ‘on top’ of the view and window layers.

#### Graphics context for drawing bitmap graphics

iOS, like other computer graphics platforms, uses the concept of a ‘graphics context’ for creating bitmap graphics.

The graphics context is an in-memory storage area, which gets configured with the graphical properties needed for your task. 
In iOS Core Graphics (Quartz 2D), you create a `CGContext` object. From the CGContext Reference document:

> The CGContextRef opaque type represents a Quartz 2D drawing destination. A graphics context contains drawing parameters and all device-specific information needed to render the paint on a page to the destination, whether the destination is a window in an application, a bitmap image, a PDF document, or a printer. You can obtain a graphics context by using Quartz graphics context creation functions…

Where does this graphics context live? In a subclass of UIView. When you study today’s code examples, you will see a <span class="skimlinks-unlinked">Shape.swift</span> class, 
which is a subclass of UIView. This class is the graphical object that gets created programmatically.



**Touch**

The Apple iOS Human Interface Guidelines document discusses [Gestures](https://developer.apple.com/ios/human-interface-guidelines/interaction/gestures/).

Single tap (select)

Double tap (same finger) (often used to ‘zoom in’)

Two-finger tap (often used to ‘zoom out’)

*   a view is configured for one-finger touch, so you must enable multi-touch
*   on the simulator, press and hold the Option key

Tap + drag, one finger (move)

[UITapGuestureRecognizer](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITapGestureRecognizer_Class/) class

**Views**

You should revisit the ‘view’ concept. The [UIKit User Interface Catalog](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/) is a good place to start. 
Also, skim the document [View and Window Architecture](https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/WindowsandViews/WindowsandViews.html) 
(a few years old, but still OK).

A view has a property named ‘subviews’. It holds a collection of views.

You can use the ‘tag’ property to identify a view with an integer.

The view has a method ‘viewWithTag()’ that enables you to get a reference to a subview using its integer identifier.

[This Stack Overflow answer](http://stackoverflow.com/a/1054946) lists the methods that enable you to work with the view hierarchy.

Here is a good starting point for subclassing a UIView:
```swift
class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        // put initialization code here
    }

    /* For Core Graphics work, you would override drawRect, and do some drawing, for example
    override func drawRect(rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            CGContextSetLineWidth(context, 2)
            CGContextMoveToPoint(context, 0, 0)
            CGContextAddLineToPoint(context, 100, 100)
            CGContextStrokePath(context)
        }
    }
    */
}

```

>FYI: When subclassing UIView, you must add an initializer to conform to the NSCoding protocol.
A brief explanation [is here](http://www.quora.com/Why-does-Swift-force-you-to-implement-initWithCoder-for-UIView-subclasses) 
(and in The Swift Programming Language document). [This Stack Overflow answer](http://stackoverflow.com/a/26081426) also helps.

**Drawing in UIView.drawRect()**

The pattern for this is to first access a graphics context with `UIGraphicsGetCurrentContext()`, and then to use either legacy syntax `CGContext<name of operation>` calls, or the equivalent newer syntax, `context.<name of operation>`.
Both are fine to use, just avoid mixing them so as not to confuse the reader.

```swift
    // Draw a diagonal line using old syntax
    override func drawRect(rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            CGContextSetStrokeColorWithColor(context, UIColor.red.cgColor)
            CGContextSetLineWidth(context, 2.0)
            CGContextMoveToPoint(context, 0, 0)
            CGContextAddLineToPoint(context, 100, 100)
            CGContextStrokePath(context)
        }
    }
    
    // Draw a diagonal line using new syntax
    override func drawRect(rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.red.cgColor);
            context.setLineWidth(2.0);
            context.move(to: CGPoint(x: 0, y: 0))
            context.addLine(to: CGPoint(x: 100, y: 100))
            context.strokePath()
        }
    }
```
**Graphics (with UIKit, and Quartz 2D, aka Core Craphics)**

[Here](http://www.techotopia.com/index.php/An_iOS_8_Swift_Graphics_Tutorial_using_Core_Graphics_and_Core_Image) is a decent tutorial on this topic, using Swift.

Apple does have a regularly-updated document, the [Quartz 2D Programming Guide](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/Introduction/Introduction.html).

Ray Wenderlich has [a series of tutorials](http://www.raywenderlich.com/tag/core-graphics) on this topic. Content from Ray is typically good quality.
