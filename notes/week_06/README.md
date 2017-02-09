#### Downcasting

Read [this section](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html#//apple_ref/doc/uid/TP40014097-CH22-ID341) in The Swift Programming Guide before continuing.

Here are its highlights:

> A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with the type cast operator (as).
> 
> Because downcasting can fail, the type cast operator comes in two different forms. The optional form, as?, returns an optional value of the type you are trying to downcast to. The forced form, as, attempts the downcast and force-unwraps the result as a single compound action.
> 
> Use the optional form of the type cast operator (as?) when you are not sure if the downcast will succeed. This form of the operator will always return an optional value, and the value will be nil if the downcast was not possible. This enables you to check for a successful downcast.
> 
> Use the forced form of the type cast operator (as) only when you are sure that the downcast will always succeed.

.

**Discussion**

In the player list (table view) controller, the _tableView(cellForRowAtIndexPath: )_ method configures and returns a table view cell (to the Cocoa runtime).

Based on the table view row that’s being rendered/drawn, the data source – the model object’s “players” array/collection – is accessed, and a specific object (using its index value) is read/fetched from the data source.

The “players” array/collection type is _AnyObject_. However, we know that it is a _Dictionary<String, AnyObject>_.

Therefore, when we get the object from the data source, we downcast the object to the type we want:

<span style="color:#0000ff;">let player = model.players[<span class="skimlinks-unlinked">indexPath.row</span>] as Dictionary<String, AnyObject></span>

Then, for the “player” object, we begin to extract the required key-value pairs:

<span style="color:#0000ff;">let playerName = player[“Player”] as String </span>  
<span style="color:#0000ff;">let teamName = player[“Team”] as String</span>

The value of “Player” or “Team” is an _AnyObject_ type. However, we know that it is a _String_.

.

#### Type Casting for… AnyObject

Read [this section](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html#//apple_ref/doc/uid/TP40014097-CH22-ID342) in The Swift Programming Guide before continuing.

Here are its highlights:

> Swift provides [a] special type [alias] for working with non-specific types:  AnyObject [, which] can represent an instance of any class type.
> 
> When working with Cocoa APIs, it is common to receive an array with a type of [AnyObject], or “an array of values of any object type”. This is because Objective-C does not have explicitly typed arrays. However, you can often be confident about the type of objects contained in such an array just from the information you know about the API that provided the array.
> 
> In these situations, you can use the forced version of the type cast operator (as) to downcast each item in the array to a more specific class type than AnyObject, without the need for optional unwrapping.

.

#### Re-writing some of the Lab 3 code

(apply this new knowledge)

.

#### Classes that describe real-world objects

Before moving on to Core Data, we will briefly discuss how to design and write a custom class that describes a real-world object.

Entity classes use _properties_ for data/state storage, and _methods_ for behaviour. Similar to other languages and frameworks.

In our apps, we work with objects and collections of objects, similar to what you’d do in other languages and frameworks.

What about persistence? How do we persist the object graph? Well, Cocoa offers at least two techniques, [archiving](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Archiving/Archiving.html), and the Core Data framework, which we study next.

> We should note that small and simple object graphs can be persisted in a plist, “property list”. However, this kind of storage is perhaps more suited to, for example, configuration settings, and is usually inadequate for persisting the app’s data.

.

#### Introduction to Core Data

Core Data is an object design, management, and persistence framework.

It helps you manage the lifecycle of objects and [object graphs](https://developer.apple.com/library/ios/Documentation/General/Conceptual/DevPedia-CocoaCore/ObjectGraph.html).

.

#### How do I get started?

Use a ‘project template’.

In the course GitHub repository, in the [Project_Templates](https://github.com/peteratseneca/dps923winter2015/tree/master/Project_Templates) folder, you will see a project named **ClassesV1**.

Make a copy of that, and you will have all you need to get started.

> How do I make a copy?
> 
> The <span class="skimlinks-unlinked">Readme.txt</span> file in the ClassesV1 project helps you do this.

.

#### What’s in the “ClassesV1” project template?

The project template has all the pieces you need.

It is _nicely organized_.

The project template includes the **Core Data ‘stack’**, which provides the necessary objects, and a [factory](http://en.wikipedia.org/wiki/Factory_(software_concept))/[builder](http://en.wikipedia.org/wiki/Builder_pattern).

A **store initializer** is included, enabling you to create startup data for the app when launched for the first time.

Its **Model** class is configured for Core Data, and has examples of properties of methods.

And it has a _table view controller_, and a standard _view controller_, which can use Core Data objects.

.

#### Where do I see Core Data in a project?

The following screen shot shows some of the Model class in the ClassesV1 project template. (Click to view it in a new tab/window.)

Look at the following notable items:

*   The CDStack class
*   The ObjectModel file, which is the Core Data (object) model created by the model editor
*   Properties and methods in Model.m, shown in the code editor

[![where-is-cd-in-a-project](https://petermcintyre.files.wordpress.com/2014/02/where-is-cd-in-a-project.png?w=595&h=377)](https://petermcintyre.files.wordpress.com/2014/02/where-is-cd-in-a-project.png)

.

#### How do I design my entity objects?

Use the [Core Data model editor](https://developer.apple.com/library/ios/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html).

The screen shot below shows an example where two entities were designed. (Click to view it in a new tab/window.)

Look at the following notable items:

*   Add Entity control
*   List of entities that have been designed
*   Add ( + ) and Remove ( – )  properties controls
*   For a selected/highlighted entity, a list of attributes and relationships
*   For a selected/highlighted entity, available settings in the Data Model Inspector (in the right-side Utility area)

[![how-to-design-entities](https://petermcintyre.files.wordpress.com/2014/02/how-to-design-entities.png?w=595&h=377)](https://petermcintyre.files.wordpress.com/2014/02/how-to-design-entities.png)

.

**Naming conventions**

Entity names begin with an upper-case letter. Multi-word names use camel-casing.

Property names – attribute, relationship – begin with a lower-case letter. Multi-word names use camel-casing.

Do NOT use “description” for the name of an attribute.

> Why?
> 
> It’s documented in the [Core Data Programming Guide](https://developer.apple.com/library/mac/documentation/cocoa/conceptual/coredata/articles/cdMOM.html#//apple_ref/doc/uid/TP40002328-SW6), and in the [NSPropertyDescription](https://developer.apple.com/library/mac/documentation/cocoa/Reference/CoreDataFramework/Classes/NSPropertyDescription_Class/NSPropertyDescription.html) class reference document. In summary, DO NOT use these names for properties:
> 
> *   <span style="line-height:1.5em;">description</span>
> *   <span style="line-height:1.5em;">class</span>
> *   entity
> *   objectID
> *   <span style="line-height:1.5em;">self</span>

.

A “to-one” relationship property name is singular. For example, “supplier”.

A “to-many” relationship property name is plural. For example, “products”.

.

**After designing an entity, use Xcode to generate a custom class**

After designing an entity, and adding and configuring its properties, use Xcode to generate a custom class. Here’s how:

1\. Display the Core Data model editor. Select one or more entities.

2\. On the Editor menu, choose “Create NSManagedObject Subclass…”. Answer the dialogs appropriately.

[![generate-custom-class-1](https://petermcintyre.files.wordpress.com/2014/02/generate-custom-class-1.png?w=300&h=173)](https://petermcintyre.files.wordpress.com/2014/02/generate-custom-class-1.png)

.

[![generate-custom-class-2](https://petermcintyre.files.wordpress.com/2014/02/generate-custom-class-2.png?w=300&h=64)](https://petermcintyre.files.wordpress.com/2014/02/generate-custom-class-2.png)

.

[![generate-custom-class-3](https://petermcintyre.files.wordpress.com/2014/02/generate-custom-class-3.png?w=300&h=64)](https://petermcintyre.files.wordpress.com/2014/02/generate-custom-class-3.png)

.

The result will be a class that is much more pleasurable to use when writing code.

[![generate-custom-class-4](https://petermcintyre.files.wordpress.com/2014/02/generate-custom-class-4.png?w=300&h=139)](https://petermcintyre.files.wordpress.com/2014/02/generate-custom-class-4.png)

<span style="line-height:1.5em;">.</span>

#### What is a “managed object”?

“NSManagedObject is a generic class that implements all the basic behavior required of a Core Data model object.” (From the [NSManagedObject](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/CoreDataFramework/Classes/NSManagedObject_Class/Reference/NSManagedObject.html) class reference document.)

NSManagedObject inherits from NSObject.

In addition, we normally will use Xcode to create a _custom class_ for an entity, which inherits from NSManagedObject. For example, if we created a “Person” entity, and generated a custom class, the inheritance hierarchy would look like this:

NSObject > NSManagedObject > Person

.

#### What is the “managed object context”?

“An instance of NSManagedObjectContext represents a single “object space” or scratch pad in an application. Its primary responsibility is to manage a collection of managed objects. The context is a powerful object with a central role in the life-cycle of managed objects, with responsibilities from life-cycle management … to validation, inverse relationship handling, and undo/redo.” (From the [NSManagedObjectContext](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/CoreDataFramework/Classes/NSManagedObjectContext_Class/NSManagedObjectContext.html) class reference document.)

Think of it as an in-memory “scratch pad” or temporary “work area” that you use.

.

#### What ‘management’ tasks can I perform on my objects?

All the tasks you would expect:

**Fetch:** Get all, or get one, or get some filtered, or get a scalar value (e.g. the number of objects). Done with a “fetch request”, introduced below.

**Add:** Add new object.

**Edit:** Edit an existing object.

**Remove:** Remove an existing object.

These tasks are implemented as methods in the Model class.

.

#### Where is the data (object graph) persisted?

In your app’s “Documents” directory.

The Core Data stack manages access to the store file. We don’t have to worry about it.

The data format of the store file is private, and is NOT important to us.

.

#### What is a “fetch request”?

“An instance of NSFetchRequest describes search criteria used to retrieve data from a persistent store.” (From the [NSFetchRequest](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/CoreDataFramework/Classes/NSFetchRequest_Class/NSFetchRequest.html) class documentation document.)

What “_search criteria_“?

*   Name of entity being searched
*   If required, a predicate (logical conditions that constrain a search)
*   If required, sort descriptors

.

#### What’s a “fetched results controller”?

A _wonderful_ and _awesome_ object.

“You use a fetched results controller to efficiently manage the results returned from a Core Data fetch request to provide data for a UITableView object.” (From the [NSFetchedResultsController](https://developer.apple.com/library/ios/documentation/CoreData/Reference/NSFetchedResultsController_Class/Reference/Reference.html) class reference document.)

Are you planning to use a table view? Then you will want to ‘bind’ it to a fetched results controller. The result? Happiness.

If we have only one entity in our project, we create one fetched results controller.

If we have multiple entities in our project, we create a fetched results controller for each entity.

They are created in our Model class, as properties, with custom getters.

.

#### How do I…

How do I _define an entity object_?  
Use the Core Data model editor.  
Add an entity, and then add and configure properties.  
Finally, use Xcode to generate a custom class for the entity.

How do I _write code to manage the entity_?  
Do most of your work in the Model class.  
Create a property for the entity’s fetched results controller.  
Then write methods for other fetch requests, and for handling object creation, modification, and removal.

How do I _perform searches and handle results_?  
You can use the fetch request object in the fetched results controller if you plan to ‘bind’ the results to a table view.  
Alternatively, you can use a fetch request object to do so.  
In either case, results are available as an NSArray of zero-or-more objects.

How do I _add, edit, and remove objects_?  
As noted above, write methods that handle object creation, modification, and removal in the Model class.  
For ‘add’, create and configure a new object.  
For ‘edit’, fetch the object. Then change its property values.  
For ‘remove’, fetch the object. Then ask the context to remove it.  
Always “save changes”.

.

#### Can I study a code example?

Yes.

The **CD Types** code example (in the GitHub repository) is a good example of an app that works with one entity.

You _should attempt_ to re-create this example, using your own copy of the ClassesV1 template. Strongly recommended.

.

#### Show me a diagram of the objects in an iOS app that uses Core Data

In the style that we have been using in class, here is a diagram. (Click to open it full-size in a new tab/window.)

[![iOSAppObjectsWithCoreData](https://petermcintyre.files.wordpress.com/2014/02/iosappobjectswithcoredata.png?w=595&h=467)](https://petermcintyre.files.wordpress.com/2014/02/iosappobjectswithcoredata.png)

.
