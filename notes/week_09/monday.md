Monday, March 13, 2017  
Classroom S2150 at 11:40am  

Agenda and sequence for today:
1. More about fetch requests  
2. Test 6  
3. Answer questions about, and help on Assignment 6  
<br>

### Reintroduction to Core Data
A few weeks ago, you were introduced to Core Data. As you know, it is an object design, management, and persistence framework. It helps you manage the lifecycle of objects and [object graphs](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/ObjectGraph.html).  
<br>

#### Web services, and Core Data
More recently, you began to learn how to use web services in an iOS app. Web services and Core Data go together. When you need local on-device and/or offline-enabled storage of data from a web service, Core Data is the storage scheme. 

#### Project template
Recently, you used the WebServiceModel project template to begin learning about a web service enabled iOS app. It featured a "WebServiceModel.swift" class. This was done to isolate and highlight the code needed to fulfill the web service usage pattern, away from the larger code base in the Model class. 

Now that you know what's needed - a property to hold the response from the web service, and a method that represents a web service request - we can put that code into the Model class. 

A new project template has been posted, named "CombinedModel". Use that from now on (until further notice).  
<br>

### What management tasks can I perform on my Core Data objects?

All the tasks you would expect:

**Fetch:** Get all, or get one, or get some filtered, or get a scalar value (e.g. the number of objects). Done with a “fetch request” object, introduced below.

> You have some experience with "fetch". Our code examples and your Assignment 5 work used a *fetched results controller*, which includes a "fetch request" object, and is designed to work with a table view controller. 

**Add:** Add new object.

**Edit:** Edit an existing object.

**Remove:** Remove an existing object.

These tasks are implemented as methods in the Model class.  
<br>

### What is a "fetch request"?

"An instance of NSFetchRequest collects the criteria needed to select and - optionally - order a group of managed objects, or data about records held in a persistent store." (From the [NSFetchRequest class documentation](https://developer.apple.com/reference/coredata/nsfetchrequest) document.)

What criteria?  
* Name of entity being searched  
* If required, a *predicate* (which is a logical condition that constrains or filters a search)  
* If required, sort descriptors  
<br>

#### Compare "fetch request" with "fetched results controller"

A "fetched results controller to efficiently manage the results returned from a Core Data fetch request to provide data for a UITableView object." (From the [NSFetchedResultsController class documentation](https://developer.apple.com/reference/coredata/nsfetchedresultscontroller) document.)  

A fetched results controller (frc) includes a fetch request object.  

Therefore, if you are planing to use the results of a fetch request in a table view, then use an frc.  

Otherwise, use a fetch request object. For example, if you need a single matching object, to display on a details view, use a fetch request to get the matching object. 

Whether you need to use a fetch request object on its own or as a property of an frc, you can still set the search criteria and sort order.  

Please note that an iOS app with many features and workflows will have a Model class that has a number of fetch requests and frcs. That is completely normal and expected.  Remember, the purpose of the Model class is to be the container for all of the code that performs data service tasks, no matter what the task, or where the data's location.  
<br>

### How do I . . .

Typical Core Data tasks:  

How do I define an entity?  
* Use the Core Data model editor.  
* Add an entity, and then add and configure properties.  
* Write a custom class declaration.  
* Finally, use Xcode to generate an extension for the entity.  

How do I write code to manage the entity?  
* Do most of your work in the Model class.  
* Create a property for the entity’s fetched results controller.  
* Then write methods for other fetch requests, and for handling object creation, modification, and removal.  

How do I perform searches and handle results?  
* You can use the fetch request object in the fetched results controller if you plan to bind the results to a table view.  
* Alternatively, you can use a fetch request object, on its own.  
* In either case, results are available as an array of zero-or-more objects.  

How do I add, edit, and remove objects?  
* As noted above, write methods that handle object creation, modification, and removal in the Model class.  
* For ‘add’, create and configure a new object.  
* For ‘edit’, fetch the object. Then change its property values.  
* For ‘remove’, fetch the object. Then ask the context to remove it.
Always “save changes”.  

### How do I . . . with a web service involved?

Before answering, think about the situation. Without a web service involved, new data comes into the app from the user, who is entering data by using the on-screen keyboard (or from a device hardware interface, like the camera). You already would know how to handle that. (Gather the data, pass it to an "add new" method in the Model class.)  

New data from a web service works the same way. After the new data comes in, pass it to an "add new" method in the Model class.  
<br>

### More about a standalone "fetch request" object

You can use a fetch request object to perform a get-all, get-some-filtered, or get-one query. For all of these situations, the results come back as an array that has zero or more objects.  

A *get-all* query will not need a predicate.

A *get-some-filtered* or *get-one* query will need a predicate. Predicate string format examples are [fully documented here](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html) (although some will not work with a Core Data store).

For any query that will return a collection, you can choose to configure sort behaviour, if you wish.

#### Guidance

Here's some guidance on how to work with fetch request objects. 

Some of the work is done in a controller (define and configure a fetch request), and some of the work is done in the model (execute a fetch request, and return the results). 

For best results, in your Model class, create a method that will accept a fetch request object as an argument, execute the fetch request, and deliver the results. (We do this in the model because controllers do not have direct access to the Core Data stack.) For example:  

```swift
func execute(fetchRequest fr: NSFetchRequest<NSFetchRequestResult>) -> [Any] {

    // Define a container to hold the results
    var results = [Any]()
        
    // Attempt to do the fetch
    do {
        results = try cdStack.managedObjectContext.fetch(fr)
    } catch  {
        print("Fetch error: \(error)")
    }
        
    return results
}
```  
<br>

Then, in the controller, write code that will create a fetch request object, and then pass it as an argument to the just-written "execute" method in the model class. For example:  

```swift
    // Sample code in a controller...

    // Note - the "Example" entity is used in this code example
    // Recall that it has two attributes:
    // attribute1 - string
    // attribute2 - integer

    // Create a fetch request
    let fr: NSFetchRequest<Example> = Example.fetchRequest()
        
    // Optionally, add criteria (filters)
    // Select all where the value of attribute2 is greater than zero
    fr.predicate = NSPredicate(format: "attribute2 > %@", argumentArray: [0])
        
    // Optionally, add sort descriptors
    // It is possible to have more than one sort descriptor,
    // so a fetch request has an array of zero or more
    // Sort by the attribute1 string, ascending order
    fr.sortDescriptors?.append(NSSortDescriptor(key: "attribute1", ascending: true))
        
    // Optionally, limit the number of results
    fr.fetchLimit = 15
        
    // Pass the fetch request to the model for execution
    let results = model.execute(fetchRequest: fr as! NSFetchRequest<NSFetchRequestResult>)
        
    // Handle the results
    print("Results count is \(results.count)")
```  
<br>

( it is possible that more content will be posted )


