Collections. Classes that describe real-world objects. Work with text view control. Delegates in Cocoa. Picker view.

#### The delegation pattern

As described in the Cocoa Core Competencies (CCC) [“Delegation” document](https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/Delegation.html):

> Delegation is a simple and powerful pattern in which one object in a program acts on behalf of, 
or in coordination with, another object. … 
The main value of delegation is that it allows you to easily customize the behavior of several objects in one central object.

You first saw the delegation pattern in Lab 1:

*   The text field _delegated_ an event-handling task to the view controller
*   We formally specified that with an _outlet_ (for the user interface object), and a _protocol declaration_ in the view controller class declaration
*   Finally, we wrote a method – as defined in the _protocol_ – to handle the ‘text field should return’ event

Many user interface objects use the delegation pattern. Why?

We do not have access to the source code of the user interface object. 
However, we often want to specify its event-handling behaviour. Delegation enables this to happen. 
The user interface object delegates event-handling responsibilities to another class.

What is a protocol? You see this in other languages. 
In C++, it is an abstract class with pure virtual methods. 
In C#, it is an interface. As described in the CCC [“Protocol” document](https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/Protocol.html):

> A protocol declares a programmatic interface that any class may choose to implement. … 
Any other class may choose to adopt the protocol and implement one or more of its methods, 
thereby making use of the behavior. 
The class that declares a protocol is expected to call the methods in the protocol 
if they are implemented by the protocol adopter.

#### Work more with text view control

In last week's lab you learned something about the text view control.
The text view can be used as a read-only control, and as a read-write control. 
By default, it will scroll its content if necessary.
If you use it as a read-write control, the on-screen keyboard’s “Return” key will enter a line break in the text. 
In other words, it does not indicate that you’re finished editing the content.
Therefore, you must add another control – a button for example – to handle the user’s intention to finish editing.

#### Collections

From The Swift Programming Language book:
> Swift provides two collection types, known as _arrays_ and _dictionaries_, for storing collections of values.
> 
> Arrays store ordered lists of values of the same type.
> 
> Dictionaries store unordered collections of values of the same type, which can be referenced and looked up through a unique identifier (also known as a key).
> 
> Excerpt From: Apple Inc. “The Swift Programming Language.” iBooks. 
[https://itunes.apple.com/ca/book/swift-programming-language/id881256329?mt=11](https://itunes.apple.com/ca/book/swift-programming-language/id881256329?mt=11)

The rest of the chapter has good information, and code that you can practice with (in a playground or in a project). 
Plan to read, study, and practice the content in the chapter.

#### Picker view

“A picker view lets the user choose between certain options by spinning a wheel on the screen. 
Picker views are well suited for choosing things like dates and times (as the date picker does) 
that have a moderate number of discrete options. Other examples include picking which armor to wear 
in a game and picking a font for text in a word processor.” 
([Picker Views](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UIPickerView.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uipickerview_intro.png)

A picker view requires a _delegate_ object. 
For our purposes, the delegate is the controller that is managing the view on which you place the picker view.

In addition, it requires a _data source_ object. 
As above, the data source is the controller that is managing the view.

In the controller (which is the delegate and data source), 
we implement functions that will perform tasks during the user interface object’s life cycle. 
Which functions? They are defined in the _delegate_ and _data source_ protocols.

Who or what calls a function? The Cocoa runtime, in response to a user action or a system event.

**Typical “data source” methods **

The controller will handle these data source oriented messages for a picker view:

*   Number of components (i.e. spinning wheel segments) in the picker view
*   Number of rows in a specific component

**Typical “delegate” methods**

The controller will handle these delegate oriented messages for a picker view

*   Set the displayable content for a specific row in a specific component
*   The user selected a specific row in a specific component, so perform a task

**Working with a picker view**

There are a number of steps involved in getting a single-component picker view working:

1.  Create a collection that will be the picker view’s data source
2.  Add the picker view to the scene
3.  Configure its delegate and dataSource properties
4.  Write the event-handling functions in the controller

**Create a collection that will be the picker view’s data source**

Create a collection that will be the picker view’s data source. (In our first example, we will simply create the collection in the controller. In the near future, we will create and maintain it in a separate class, known as a “model” class.

**Add the picker view to the scene**

On a scene, click-drag-drop a picker view, and position it appropriately.

Notice that it will show placeholder text as a design-time aid.

**Configure its delegate and dataSource properties**

Select to highlight the picker view.

Ctrl+click-drag to the “View Controller” icon in the scene’s dock. On the popup, select the _delegate_ property.

Do this again, and select the _dataSource_ property.

**Implement functions in the controller**

Adopt the delegate and data source protocols to the controller class declaration:

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

Add the four functions to the controller. Note that Xcode’s code sense will help you write the methods, because you have adopted the protocols in the class declaration:

1.  numberOfComponentsInPickerView(pickerView: )
2.  pickerView(pickerView: numberOfRowsInComponent: )
3.  pickerView(pickerView: titleForRow: forComponent: )
4.  pickerView(pickerView: didSelectRow: inComponent: )

Study/skim the [UIPickerView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPickerView_Class/Reference/UIPickerView.html) class reference documentation, and:

*   [UIPickerViewDelegate](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPickerViewDelegate_Protocol/Reference/UIPickerViewDelegate.html) protocol reference
*   [UIPickerViewDataSource](https://developer.apple.com/library/ios/documentation/iPhone/Reference/UIPickerViewDataSource_Protocol/Reference/Reference.html) protocol reference
