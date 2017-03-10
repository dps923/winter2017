
## Core Data relationships

These were introduced in Assignment 5, let's review and cover in more detail.

### Reading:
https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreData/HowManagedObjectsarerelated.html

Read these sections only:
- Relationship Fundamentals
- Creating Relationships Does Not Create Objects
    - An obvious concept, there is no automatic creation of objects for you.
    - In assignment 5, you saw that creating a _Program_ didn't automatically create any _Course_ objects, you had to do that manually.
- Inverse Relationships
    - Relationships are inherently bidirectional. This is a very useful concept. In assignment 5, the _Program_ entity had a _courses_ attribute, and a _Course_ had a _program_ attribute. Thus, given a _Program_ object in your code you can access the courses that it contains, or given a _Course_ object you can access the programs.
    - In assignment 5, _Course_ entities were created, then their _program_ attribute was set. This will automatically add this course object to the _Program's_ _courses_ collection. <br>Alternatively, we could have added the course to the _Program's_ _courses_ collection. In this case, would the _Course_ object's _program_ get set to a value automatically?
- Relationship Delete Rules (specifically Cascade, Nullify)
    - __Cascade__ and __Nullify__ are the two delete rules you will use most commonly. The Nullify rule is the default; thus in assignment 5, if a _Program_ was deleted, the courses it contained would not be deleted.<br>What do you think would happen if a _Course_ object is deleted in this case?
    - What would happen if the _Program_ entity's _courses_ relationship was set to the __Cascade__ delete rule?

## Core Data and fetching specific data with NSPredicate

__NSFetchRequest__ is used to specify which entity you will be fetching, and what the predicate is.

The predicate uses the class __NSPredicate__ to specify how data should filtered during a fetch request.

In assignment 5, we did some fetching with NSFetchedResultsController (which is the magical object to connect Core Data with UITableView).<br>
No predicate was used on the fetch request, therefore no filter was applied on the data and all objects for the given entity were returned.

Let's say we wanted to fetch only programs whose code name started with "BT":
```swift
let fetchRequest = NSFetchRequest<Program>(entityName: "Program")
fetchRequest.predicate = NSPredicate(format: "code BEGINSWITH %@", "BT")
```

Predicate syntax is unusual, a few points to keep in mind:
- Arguments are passed into the _format_ using the placeholder _%@_.
- Primitive-type arguments that are constant can be placed directly in the format string, i.e. "age == 24", "code BEGINSWITH 'BT'".
- Predicate operators such as _BEGINSWITH_ can be lowercase, i.e. "code beginswith %@"
- Using equals operators: _=_ and _==_ mean the same thing

### Reading:
String Comparison predicates (BEGINSWITH, CONTAINS, ENDSWITH, MATCHES) in
https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html

We won't cover too many other types of predicates, normally you would look them up as needed.

#### Case insensitive predicates are created by adding [c] to the end of the operator
This is used commonly so be aware of how to do this.
#### Diacritic insensitive predicates add [d] to the end of the operator
Again you will see this commonly. This will treat "é" and "e" as the same character, you don't need to search for both.

These are combined using __[cd]__, like:
```swift
let findAllStartingWithLetterE = NSPredicate(format: "name BEGINSWITH[cd] %@", "e")
// matches e, E, é, É, etc.
```

## Core Data fetching without a table view

So far we have only used NSFetchedResultsController to fetch data.

Let's add a function to the CoreDataModel template that will fetch entities as an array.

In the Model class:
```swift
    func get(withPredicate: NSPredicate?) -> [Example]? {
        let fetchRequest: NSFetchRequest<Example> = Example.fetchRequest()
        fetchRequest.predicate = withPredicate

        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return nil
    }
```

This is simpler than setting up a NSFetchedResultsController, which also requires a sort attribute.

> Side note regarding try/catch: in a 'catch' block there is an automatic variable called 'error', I don't think this was mentioned previously.

## Core Data deletions

The managed object context has a __delete(obj)__ function for this. 

Let's add a function to the CoreDataModel template that will delete all data.

In the Model class:
```swift
    func deleteAll() {
        if let result = get(withPredicate: nil) {
            for obj in result {
                context.delete(obj)
            }
        }
    }
```

## Table View Editing

### Reading:
https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/ManageInsertDeleteRow/ManageInsertDeleteRow.html

https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/Art/table_view_editing.jpg

Let's modify the CoreDataModel template table view to support edit mode; by default the __editingStyle__ of a table view is __delete__.

In the ExampleList class (which is a UITableViewController):

#### Hook up an edit button to turn editing mode on/off on the table view
```swift
    @IBAction func onEditButton(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
```

Now the table view can enter an edit mode which will show a delete button.

#### Add required delegate to 'commit editingStyle forRowAt'

Pressing the delete button on a row will call this UITableViewDataSource delegate function:

```swift
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedItem: Example = frc.object(at: indexPath)
            model.context.delete(deletedItem)
            model.context.save() // this will make sure the changes are saved to disk
        }
    }
```

Reference doc: https://developer.apple.com/reference/uikit/uitableviewdatasource?language=swift

> We deleted the object from Core Data, but the table view will look the same. We aren't done yet ...

#### Hook up NSFetchedResultsControllerDelegate so that Core Data changes trigger updates to the table view

This is another bit of 'magic' from NSFetchedResultsController; hook up its delegate to your table view and the table view will show live changes –even animating the changes as they happen.

A __big__ block of boilerplate code is used for this. You just add this to your table view and it all works.
We will provide the code in the CoreDataModel template, it looks like this:

```swift
extension ExampleList : NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
               // SNIP: the body removed for brevity
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let index = newIndexPath {
                tableView.insertRows(at: [index], with: .automatic)
            }
        // SNIP: the rest of the function is removed for brevity
    }
}
```

> TIP: Use __extensions__ to organize your delegate code, it makes code easier to read. This is a common pattern in Swift for implementing delegate functions; it is used above to group the NSFetchedResultsControllerDelegate together. You _could_ place these functions in the ExampleList class, but it is harder to see that these four functions are all part of a common category.

