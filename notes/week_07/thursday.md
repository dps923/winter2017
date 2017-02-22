Thursday, February 23, 2017  
Computer-lab room T3078 at 1:30pm  

 Agenda for today:  
1. Learn about the "add" and "edit" patterns for iOS apps  
2. Continue work on Assignment 5  
<br>

### Planning information  
Next week is study week, so there are no classes/sessions.  

Our next class/session is on Monday, March 6. The plan is to introduce the networking topic on that day. We will begin the class with a test.  
<br>

### More to come  

(end)  

### Checkpoint, and the next week or two
Its worthwhile to pause for a moment, and list the topic sequence we have covered to date:
<ol>
 	<li>Working with <em>user interface objects</em> on a single <em>view</em></li>
 	<li>Learning the <em>delegate</em> pattern, first with a text field, and then with a picker view</li>
 	<li>Using a <em>collection</em>, and a <em>picker view</em> that relies on a collection and the delegate pattern</li>
 	<li>Designing a <em>model</em> object, to host the app's data</li>
 	<li>Learning the <em>navigation-based app style</em>, using a <em>table view</em> (which is similar to the picker view, because it also relies on a collection and the delegate pattern)</li>
 	<li>Getting started with the <em>Core Data</em> object design, management, and persistence framework</li>
</ol>
<br>
Make sure that you're comfortable with these topics. If not, ask your professor.

In the next week or two, we will introduce these topics:
<ul>
 	<li>The <em>add/edit item pattern</em>, which requires you to write a <em>protocol</em>, and learn <em>modal segues</em></li>
 	<li>Using the <em>network</em>, which most often means a <em>web service</em></li>
 	<li>Working with multiple related entities</li>
</ul>
<br>
What about the future? <em>We want to hear from you</em>. Talk to your professor, and/or contact by email.
<ul>
 	<li>What graphics and touch topics do you want to learn?</li>
 	<li>What device hardware topics (e.g. location, camera, etc.) do you want to learn?</li>
 	<li>How much do you want to learn about iPad apps?</li>
</ul>
<br>

### The 'add/edit item' pattern
At this point in time, you have some knowledge of and experience with:
<ul>
 	<li>navigation-based app style</li>
 	<li>table view</li>
 	<li>model object</li>
 	<li>persistent store, using Core Data</li>
</ul>
<br>

What if you want to <em>add new items</em> to your app?

New items can be added from a number of different sources:
<ul>
 	<li>a data entry view that you create as part of the app</li>
 	<li>a select list with items fetched from the network</li>
 	<li>on-devices sources, including the camera</li>
</ul>
<br>

How is this done? Using the <em>add/edit item</em> pattern. A central feature of this pattern is the <em>modal view</em> concept.

What is a <a href="https://developer.apple.com/ios/human-interface-guidelines/interaction/modality/" target="_blank">modal view</a>? It is a view that provides self-contained functionality in the context of the current task or workflow.  
<br>
A modal view:
<ul>
 	<li>Can occupy the entire screen, the entire area of a parent view (such as a popover), or a portion of the screen</li>
 	<li>Contains the text and controls that are necessary to complete the task</li>
 	<li>Usually displays a button that completes the task and dismisses the view and a Cancel button that abandons the task and dismisses the view</li>
</ul>

> For more information, also read these sections in the **iOS Human Interface Guidelines** document:  
> Action Sheets  
> Alerts  
> Popovers  

<br>
Use a modal view when you need to offer the ability to accomplish a self-contained task related to your app’s primary function. A modal view is especially appropriate for a multistep subtask that requires UI elements that don’t belong in the main app UI all the time.  
<br>

Modal views are often used in iOS apps for these situations:
<ul>
 	<li>The user is completing a fill-in form that has user interface controls (an "add item" pattern)</li>
 	<li>The user must select one or more items from a lengthy list (a "select item(s)" pattern)</li>
</ul>
<br>

Here is the design and coding approach:
<ol>
 	<li>Create a controller</li>
 	<li>Add code that declares a <em>protocol</em> (with at least one method), and add a <em>delegate</em> property to the controller</li>
 	<li>Add a new scene to the storyboard (and embed it in a nav controller)</li>
 	<li>Alternate between the scene and controller code to build the user interface and handle events</li>
 	<li>In the controller, add code (to validate and) package the user input, and call the delegate method</li>
 	<li>In the presenting controller, adopt the protocol, code the segue, and implement the delegate method(s)</li>
</ol>
<br>

A protocol is a source code module that declares properties and methods for a task. Then, a class in your app can 'adopt' the protocol, and provide an implementation for the protocol's members.

<a href="https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html" target="_blank">Discussion in The Swift Programming Language guide</a>

<a href="https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/Protocol.html" target="_blank">Discussion in the Cocoa Core Competencies document</a>  
<br> 

You can follow along by studying the "CanadaAdd" code example, which is posted on the GitHub code repository. It implements the "add item" pattern.

You can also watch these videos, which cover the same content.

Part 1:

http://www.youtube.com/watch?v=VsiN_WsBP8Q

Part 2:

http://www.youtube.com/watch?v=DSwQHVKbCeQ

#### Create a controller

Add a new controller. It will be a subclass of UIViewController. In the code example, the controller name is "ProvinceEdit".  
<br>

#### Add code that declares a protocol, and add a delegate property to the controller

Edit the ProvinceEdit controller's source code file.

At the bottom of the source code file (and BELOW the controller' class closing brace), declare a delegate, and its (required) method:

```swift
protocol EditItemDelegate {

    func editItemController(controller: AnyObject, didEditItem item: AnyObject?)
}
```
<br>

Notice that this protocol has only one method. You can declare as many methods as you need.

The implementation code - the tasks that the method actually performs - is written in the class that adopts the protocol.

Next, define a "delegate" property for the controller class.

```swift
var delegate: EditItemDelegate?
```
<br>

####Add a new scene to the storyboard (and embed it in a nav controller)

On the storyboard, add a new View Controller scene from the object library. On the Editor menu, embed it in a navigation controller.

<img class="alignright wp-image-13945 size-full" style="margin-bottom: 10px; margin-left: 25px;" src="https://petermcintyre.files.wordpress.com/2015/02/storyboard-id-on-add-edit-scene.png" alt="storyboard-id-on-add-edit-scene" width="200" height="142" />  
<br>

On the Identity inspector, set its Custom Class property to be the just-added ProvinceEdit class.

Also, in the "Identity" section (just below the Custom Class section), enter a string for the "Storyboard ID". A suggested name is "AddEditProvince".

Set the scene's nav bar title.

Add the user interface objects. (For this app, we need three text fields, and a date picker.)

Add two 'bar button item' controls - one for 'Cancel' (left side), and the other for 'Save' (right side).

On the storyboard, create a segue from the presenter scene (ProvinceList) to the new scene. Here's how:
<ol>
 	<li>Add a 'bar button item' control to the presenter scene's nav bar, right side</li>
 	<li>Control+click-drag from the control to the new scene</li>
 	<li>On the segue popup, choose 'modal', then add an identifier (e.g. 'toProvinceEdit')</li>
</ol>
<br>

<a href="https://petermcintyre.files.wordpress.com/2015/02/storyboard-with-add-scene.png" target="_blank"><img class="alignnone wp-image-13796 size-large" src="https://petermcintyre.files.wordpress.com/2015/02/storyboard-with-add-scene.png?w=595" alt="storyboard-with-add-scene" width="595" height="373" /></a>  
<br>

#### Alternate between the scene and controller code to build the user interface and handle events

As you have done before, alternate your work between the scene and controller code to build the user interface, and handle events. Add outlets, and actions for 'cancel' and 'save'.  
<br>

#### In the 'add item' controller, add code that packages the user input, and call the delegate method

Add properties for the model object, and an entity object:

```swift
var model: Model! // will be configured by the presenting controller

var detailItem: Province? // not used in this example, but will be used in the future
```
<br>

In the 'cancel' method, we simply call back into the delegate method, and pass <em>nil</em> as an object.

In the 'save' method, your code will package the user input, and call the delegate method, passing along the user input package.

You can decide on the packaging format. If you have a single string or number item, just send that along. If you have multiple items to send, package them into an NSDictionary and/or an NSArray object. In <em>this</em> situation, package it into a new 'Province' object.  
<br>

#### In the presenting controller, adopt the protocol, code the segue, and implement the delegate method(s)

In the presenting controller's declaration, adopt the new 'add item' protocol.

Code the segue.

Add a method (defined by NSFetchedResultsControllerDelegate) that will respond to changes in the 'fetchedObjects' result set. The method is <em>controllerDidChangeContent()</em>.

Then, implement the delegate method(s).

Finally, dismiss the 'add item' controller.
