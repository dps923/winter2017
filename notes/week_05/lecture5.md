## App initialization

You are familiar with the AppDelegate class that every app uses as its entry point.<br>
We will revisit this as it is useful for setting up data sources and preparing the first view controller.

What is the ‘app delegate’?

Read the introduction to the [UIApplicationDelegate protocol](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/index.html) 
in the reference documentation, up to the end of **Starting Up Your App**.

In the app delegate, the most important method to use during app initialization is:  
_application(didFinishLaunchingWithOptions: )_

#### Application bundle
 
This is the name of the application package that is created when building, and can contain files you can load at runtime 
such as images, sounds, and text. We will use it to store data to load in our model class.

Key concepts regarding the application bundle:
- Resource files that are included in your project will get stored in the bundle.
- Images are loaded from the bundle with <br>`UIImage(named: "myimage") // loads myimage.png (or jpeg) (note no extension)`<br> 
Interface Builder will do this automatically for you if use an image in your project in a UIImageView.
- Other types of files are loaded by first getting a path, for instance 
```swift
let path = Bundle.main.path(forResource: "Test", ofType: "txt")
let contents = String(contentsOfFile: path) // or load data in some other way
 ```


## Navigation with UINavigationController

Navigation in iOS means showing a sequence of `UIViewController`s (a.k.a `Scene`s in Interface Builder), while having a controller object that tracks this sequence and allows the user to return to previous screens.

Here is a good introduction video demonstrating navigation in iOS:<br>https://www.youtube.com/watch?v=XnJzgXgdi_w

Please read:
https://developer.apple.com/reference/uikit/uinavigationcontroller

> A navigation controller object manages the currently displayed screens using the navigation stack, which is represented by an array of view controllers.

#### UINavigationController's viewControllers array

The `UINavigationController` class has an array called `viewControllers`, containing the view controllers in the order they were navigated to.
You can think of this array as a stack of views.

The **first** view controller in the array is the **root view controller**.<br>
The **last** view controller in the array is the view controller **currently being displayed**.

Adding or removing view controllers from `UINavigationController.viewControllers`:
* using `segues` or directly calling methods of this class.
* user can also remove the topmost view controller using the back button in the navigation bar or using a left-edge swipe gesture.

#### Segue

A segue is Apple's terminology for the action of pushing/popping a view controller onto the navigation stack 
(i.e. adding/removing from the end of UINavigationController.viewControllers).

Read up to and including **Creating a Segue Between View Controllers**: <br>
https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html
> A segue defines a transition between two view controllers in your app’s storyboard file. The starting point of a segue is the button, table row, or gesture recognizer that initiates the segue. The end point of a segue is the view controller you want to display. A segue always presents a new view controller.


#### Controller initialization

The goal is to enable a controller to initialize – come to life – with all of the data it needs.
<br>How is this done?

1.  Ensure that the controller has a property (one or more) to hold the data it needs to initialize
2.  In the event handler that initializes the controller, get the data you need before the controller is initialized
3.  Initialize the controller
4.  Pass the data on to the controller, by simply setting the controller’s property

The first controller that runs is known as the “root view controller”.

From the app delegate, get a reference to this root view controller.
Then follow the steps shown above.

Note that this is a _best practice_, but some of the resources ‘out there’ do not follow this practice. 
Don’t be swayed – use the best practice. Ask your professor if you have questions.


**Navigation live code example**


#### Table view introduction

![](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/Art/types_of_table_views.jpg)
<br>“A table view presents data in a scrolling single-column list of multiple rows.”  

[Read **About Table Views in iOS Apps**](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/AboutTableViewsiPhone/AboutTableViewsiPhone.html) in Apple's documentation.

Read to the end of **Behavior of Table Views**:<br>
https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/UIKitUICatalog/UITableView.html

In our apps, we will use table views for these purposes:

1.  Presenting data, enabling hierarchical navigation
2.  Presenting workflow operations, enabling hierarchical processing
3.  Presenting data in a list format, for selection
4.  Any combination of the above

**Table view live code example**

## Model classes

This document will help you design useful _model objects_ for your iOS app. It is intended for the entry-level iOS app developer.
It provides a good object-oriented design pattern that will make your code easier to understand and maintain.

#### Model object assumptions

The following are the assumptions about the design and functionality of a model object:

There may be one or more model objects in an app.

A model object’s role is to provide a single access point to the app’s data for the other parts of the app (which are mostly controllers).

A model object may use any of the available persistence schemes, including property lists, archiving, Core Data, iCloud, and web services.

The model object (and _not_ a controller) is responsible for communicating on the network. Async (non-blocking) communication must be used.

Model objects use key-value observing (KVO) and notifications to communicate their state (to the rest of the app).

#### How to create a model object

Create a Swift class, named “Model”. It can be located in the project’s root.

Next, think about your app’s data, and how it should be made available to the app’s controllers. Typically, you will need:

*   Properties; one for each entity collection
*   Functions that accept arguments to filter or sort an entity collection as a return type
*   Functions that perform tasks, such as ‘get one by its identifier’, or ‘add new item’, etc.

Then, add these class members, and their code.

And, it’s likely that the model object will also need an initializer. You will learn about this soon (or you can read about it The Swift Programming Language book).

#### Model object design

Among other features, a model object provides the user/consumer with access to a “collection” of “items”. 
Typically, at least one of the model object’s properties will deliver an array of results, so that it can be directly used in a table view (UITableView).

The “item” can be simple, and one of Swift’s types (e.g. String, Int, Dictionary). Or, it can be a type of your own design.

The following code elements are typically part of a model object’s design:

- Variables and constants
- Properties
- Initializer(s)
- Functions (which are public/visible)

These methods will be designed to help with the model object’s maintenance; examples…

- Get all items (returns a collection)
- Get one item (by query)
- New item
- Modify an item (by query)
- Delete an item (by query)
- Persistence code (e.g. save, load)
- Communication code (e.g. notification, delegation)

#### Using a model object in your app

Initialize your model object in the app delegate. <br>
Pass on a reference to the model object, to the root view controller.

> Note: This is the pattern that you will use every time you want to get access to the app’s data (i.e. the model object) in a controller. 
Make sure that the controller has a declared property to hold a reference to the model object. 
When the controller is initialized, set (pass on) the model object to the new controller.
> 
> The philosophy is that an object should be configured with all it needs to function correctly.
