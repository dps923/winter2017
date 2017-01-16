## DPS923 notes – Thu Jan 12

<div class="content">

Welcome. Mac overview (or review). iOS development with Swift and Cocoa.

#### Today’s topic sequence

* Overview, or review, of the Mac. Login, using Finder, and using a browser.
* Introduction to Xcode, the developer tool. Start Xcode, and create a project.
* Hands-on with Swift (the language) and a little bit of Cocoa (the class library and runtime).
* In Xcode we will use a feature, known as a “playground”.
* We’ll look at Optionals, a topic that we didn’t get to on Monday.
* Then, we will create a simple iOS application, a single-view app.

<span style="text-decoration:underline;">Handouts:</span>

* Course info sheet
* Getting started with Swift
* Getting started with Xcode

<span style="text-decoration:underline;">Resources:</span>

* Swift Programming Language (Apple, [HTML](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html), or for [iBooks](https://itunes.apple.com/us/book/the-swift-programming-language/id881256329?mt=11))
* Swift Standard Library Reference (Apple, [HTML](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html), [PDF](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/SwiftStandardLibraryReference.pdf))
* Xcode Basics (Apple, [HTML](https://developer.apple.com/library/ios/recipes/xcode_help-general/_index.html))
* Xcode Application Help (Apple, [HTML](https://developer.apple.com/library/ios/documentation/IDEs/Reference/xcode_help-collection/index.html)) (also available on the Xcode ‘Help’ menu)
* Xcode Gestures and Keyboard Shortcuts (Apple, [HTML](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/xcode_help-command_shortcuts/Introduction/Introduction.html))
* Xcode Keyboard Shortcuts (McIntyre, [PDF](https://petermcintyre.files.wordpress.com/2013/09/xcode-keyboard-shortcuts.pdf))

#### School of ICT computer-lab T3078 with Mac mini systems

The School of ICT has a lab that’s dedicated to iOS programming and web programming, in room T3078.

[Read this document](https://petermcintyre.com/topics/computer-lab-t3078-ios-dev/) for an introduction to the physical environment.

#### Hands-on with macOS

* Finder, file system, work drive, navigation

* Browser(s), downloads (to desktop)

* Cmd+space to use “Spotlight” to find and open any program or document

* Cmd+Tab to switch between running apps

* Cmd+` (back quote) to switch between windows in a specific app

* Using the dock

#### Get familiar with Xcode, the developer tool

From this course’s ‘Resources’ page…

* Xcode Overview – [HTML](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/About_Xcode/about.html) – [PDF](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/Xcode_Overview.pdf)
* Xcode Basics Help – [HTML](https://developer.apple.com/library/ios/recipes/xcode_help-general/_index.html)
* Xcode Application Help (Apple, [HTML](https://developer.apple.com/library/ios/documentation/IDEs/Reference/xcode_help-collection/index.html)) (also available on the Xcode ‘Help’ menu)
* Xcode Gestures and Keyboard Shortcuts (Apple, [HTML](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/xcode_help-command_shortcuts/Introduction/Introduction.html))
* Xcode Keyboard Shortcuts (McIntyre, [PDF](https://petermcintyre.files.wordpress.com/2013/09/xcode-keyboard-shortcuts.pdf))

Oft-used keyboard shortcuts:
* Build Cmd+B, Run (with debugging) Cmd+R
* Navigator area management – Cmd+0, Cmd+1, Option+Cmd+0
* Show/hide debug console area – Shift+Cmd+Y

If you have multiple projects open…

*   Command-` (back quote character, beside the 1 key) – switch window within app
*   Control-down-arrow – show/preview all open windows of the app

#### Optionals in Swift

When you declare a variable or property, you usually assign its type, and you often assign a value.

If you don’t know the initial value, or don’t want one, add ? (question mark) as a type suffix. This marks the variable as _optional_, where its value may be absent. For example:

```swift
// Typical variable
var firstName = "Peter"
 
// Optional variable
var middleName: String?
```

Read [this section](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID330) from The Swift Programming Guide before continuing.

There are two common ways to access the value of an optional (variable):

1.  Use the bang, or exclamation mark, !
2.  Use an optional binding block of code

When you are sure that the variable has a value, you can append a bang to the variable name. For example:

```swift
// Assume that "firstName" is an optional string, or String?
print(firstName!)
```

Alternatively, you can create an “optional binding” block of code. For those familiar with the C# “using” block of code, it’s a similar concept. Here’s an example:

```swift
// Using the variable "firstName" from above, which is an optional string,
// attempt to create a temporary constant ("let")...
 
if let fname = firstName {
  print(fname)
} else {
  print("nothing")
}
```

#### String – number conversions

This is not a very exciting topic. However, it’s very important, because it helps a new iOS programmer make progress.

Try this in a playground:

```swift
// Create an Int
var age: Int = 23
 
// Create a String that can convert to an Int
var ageString: String = "45"
 
// Attempt to convert the String into an Int
age = Int(ageString) ?? 0
 
// Remove the ?? (nil-coalescing operator) and see what happens
// Can replace it with a bang ! to unwrap the value (if you know it's there)
 
// Create a Double
var temp: Double = 24.5
 
// Create a String that can convert to a Double
var hotDay: String = "35.5"
 
// Attempt to convert the String into a Double
temp = Double(hotDay) ?? 0.0
 
// Remove the ?? (nil-coalescing operator) and see what happens
// Can replace it with a bang ! to unwrap the value (if you know it's there)
 
```

Now, we’ll try the same with an iOS app. Below, you will learn about two user interface controls:

Label – text displayed on a view; <span style="color:#ff0000;">cannot</span> be edited by the user

Text field – text displayed on a view; <span style="color:#008000;">can</span> be edited by the user

The important characteristic of both controls is that they work with “text”, specifically a String object. Therefore, when we need to display a number, or get numeric input, we need to do a string-to-number conversion.

#### Brief MVC introduction

<span class="s1">As introduced in the CCC [<span class="s2">“Model-View-Controller” document</span>](https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html):</span>

> <span class="s3">The Model-View-Controller (MVC) design pattern assigns objects in an application one of three roles: model, view, or controller. …</span>
> 
> <span class="s3">Each of the three types of objects is separated from the others by abstract boundaries and communicates with objects of the other types across those boundaries. The collection of objects of a certain MVC type in an application is sometimes referred to as a layer—for example, model layer.</span>
> 
> <span class="s3">MVC is central to a good design for a Cocoa application. The benefits of adopting this pattern are numerous. Many objects in these applications tend to be more reusable, and their interfaces tend to be better defined. Applications having an MVC design are also more easily extensible than other applications.</span>
> 
> <span class="s3">Moreover, many Cocoa technologies and architectures are based on MVC and require that your custom objects play one of the MVC roles.</span>

<span class="s3"> </span>

<span class="s3">**Controllers**</span>

<span class="s3">In the simple apps that we have worked with, there has been one controller class, named “ViewController”. It is in a source code file named “ViewController.swift”. There’s nothing magical or prescriptive about these names – the ‘new project’ template simply created them that way.</span>

<span class="s3">It should be apparent that an app can have many controllers.</span>

<span class="s3">When you begin creating your own controllers, we strongly recommend that you use [<span class="s4">meaningful names</span>](http://en.wikipedia.org/wiki/Semantics). For example, the controller for a list of teacher names should be called something like “TeacherList”.</span>

<span class="s3">**Views**</span>

<span class="s3">In the simple apps, there has been one view, also known as a “scene” on the “storyboard”.</span>

<span class="s3">It should also be apparent that the storyboard can hold many scenes. The storyboard itself is a source code file, and XML is the language. It includes a collection of <scene> elements (although our simple app has only one <scene> element).</span>

<span class="s3">Each scene has an internal “object identifier” (which is a string). How can you show this data? Select the “View Controller” icon on the scene’s dock. Show the Identity Inspector. In the “Document” area, you will see a value for “Object ID”. Well, that’s not a very friendly name. Use the “Label” field to enter a better and friendlier identifier.</span>

**Model**

Our simple apps may not have a model object. We’ll get to this topic in the next week or two.

**Getting started – create a Convert project**

In Xcode, create a new project:<br>
Template is “Single View Application”

(Next…)

Product Name is “Convert”<br>
Organization Name is Seneca College<br>
Organization Identifier is ca.senecacollege.ict

Language is Swift<br>
Devices is iPhone<br>
Un-check (clear) all three checkboxes on this panel<br>

(Next…)

Choose the folder to save your work in, USB or the Work Drive<br>
Un-check (clear) the Create Git repository… checkbox<br>

Select (to display) the Main.storyboard. It will show you the scene that’s managed by the view controller class.

At the bottom of the Utility area, select the Object library. From that library, locate and add these items to the upper-left area of the scene:

*   Label (to simply display an app title to the user)
*   Text Field (allows the user to enter a number with decimal places; change its Keyboard Type to Numbers and Punctuation)
*   Button (to start the ‘convert’ action)
*   Label (displays the result)

Click the Show Document Outline button. Select/highlight the View object.

Click the Resolve Auto Layout Issues button. In the lower “All Views” area, select Add Missing Constraints.

If you wish to preview what it will look like on an iPhone:

Show the Assistant Editor. On its jump bar, click the Automatic segment, and change (select) Preview. When you’re happy, you can close (hide) the Assistant Editor.

Create outlets for the Text Field and the bottom Label.

> Your teacher will show you how to do this.

Create an action for the Button, using the code guidelines below.

How to dismiss the keyboard? Call the resignFirstResponder() method on the text field.

**String to number**

A user will enter a number into the text field. The number could include a decimal portion. In the text field, the data is a string. Therefore, we must convert the string data to a number.

Use a the Double() initializer:
```swift
// String to double  
// Assume the name of the text field is “userInput”  
var input = Double(userInput.text!)!

// Perform an arithmetic operation  
input = (input * 2) + 3.45214
```

**Number to string**

The label has a text property, which needs a string. Therefore, we must convert the number data to a string.

Use the String() initializer:
```swift
// double to String  
results.text = String(format: “%1.3f”, input)
```

#### Begin working with iOS apps, and essential user interaction

In Xcode, create another new project; its name will be “January12”.

Study the project’s structure, it has three new source code assets:

1.  **AppDelegate** – handles app lifecycle events (launch, interrupt because of incoming phone call, etc.), and app state transitions (e.g. active, background, etc.)
2.  **Main.storyboard** – container that holds the app’s scenes (i.e. the user interface)
3.  **ViewController** – manages one scene (view)

Learn more about the AppDelegate in [this introduction](https://developer.apple.com/library/ios/documentation/general/conceptual/Devpedia-CocoaApp/ApplicationObject.html). The “Overview” section of the [UIApplication](https://developer.apple.com/library/ios/DOCUMENTATION/UIKit/Reference/UIApplication_Class/Reference/Reference.html) Class Reference document is good. Also, the “Overview” section of the [UIApplicationDelegate](https://developer.apple.com/library/ios/DOCUMENTATION/UIKit/Reference/UIApplicationDelegate_Protocol/Reference/Reference.html) Protocol Reference document is good.

Learn more about the storyboard in [this introduction](https://developer.apple.com/library/ios/documentation/general/conceptual/Devpedia-CocoaApp/Storyboard.html).

Learn more about a controller in [this introduction](https://developer.apple.com/library/ios/documentation/general/conceptual/devpedia-cocoacore/ControllerObject.html). The “Overview” section of the [UIViewController](https://developer.apple.com/library/ios/documentation/uikit/reference/UIViewController_Class/Reference/Reference.html) Class Reference document is good.

Run (Command+R), and the iOS Simulator will open your app.

While using the iOS Simulator app:

*   Shift+Command+H = performs a “home” button press
*   Command+Q = quit the simulator app
*   Command+K = show/hide the keyboard on the simulator
*   Command+3 = scale window to the smallest size
*   Command+2 = scale window a bit larger

Look at the iOS Simulator app’s menus to learn more about what it can do for you.

Click/select Main.storyboard, and the app’s scene will load in the editor. Look at the right-side Utility area, and notice the _Attributes Inspector_ (fourth icon from left).

At the bottom of the Utility area, notice the _Object library_ (third icon from left). That list shows the user interface objects that can be dragged to a scene.

We will work with these three objects as you begin work on the first assignment in the course, “Assign 1”.

In Xcode, the screen layout when designing the app’s user interface shows these areas:

1.  Left-side Navigator area – show or hide, you decide (Command+0)
2.  Storyboard, select (click) the scene (view) that you want to work with (then select the first icon in its dock, named “View Controller”
3.  Then press Option+Command+Return to open the Assistant Editor, which shows the scene’s controller
4.  Right-side Utility area – should show that, because we’ll need it (toggle with Option+Command+0)

How do you get programmatic access to objects in the user interface? Two important ways for new iOS programmers are to use outlets and actions. (A third way, which you will use soon, is known as a delegate.)

What is… an _outlet_, and an _action_?

*   [Outlet](https://developer.apple.com/library/ios/documentation/general/conceptual/Devpedia-CocoaApp/Outlet.html) – an object (in your class) that points to a user interface object
*   [Action](https://developer.apple.com/library/ios/documentation/general/conceptual/Devpedia-CocoaApp/TargetAction.html) – the method that’s called when an event occurs (e.g. value changed, button tap, etc.)

Creating an outlet or action for a user interface object:

Click to select / highlight a user interface object. Then:

1.  Press and hold the Control key
2.  Click and drag to the source code, until the insertion pointer appears, then release the mouse button (or touchpad)
3.  Complete the configuration of the dialog that pops up

The “Name” field is for the outlet or action name that appears in your source code. The name should begin with a lowercase letter. Multi-word names begin with a lowercase letter, but use camel-casing for the remaining words (e.g. userInput, or doSomething).

The following shows the dialog for an outlet (text field), and for an action (button). Click to view them full-size in a new tab/window.

[![Outlet, create, for text field](https://petermcintyre.files.wordpress.com/2014/01/outlet-create-for-text-field.png?w=300&h=92)](https://petermcintyre.files.wordpress.com/2014/01/outlet-create-for-text-field.png)

[![Action, create, for button](https://petermcintyre.files.wordpress.com/2014/01/action-create-for-button.png?w=300&h=119)](https://petermcintyre.files.wordpress.com/2014/01/action-create-for-button.png)

> Tip: When configuring an _action_, set the Type to the actual type of the user interface control.

