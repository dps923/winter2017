## Test 3 example answers

When your test is marked, we are looking for an answer that captures the essence of the example answers (indented, below). Your answer does not necessarily have to be exactly the same, and part marks are possible. Over time, you should strive to improve your explanations, as that will improve your academic and career prospects.

Answer any five (5) questions.  
<br>

`1.` Briefly describe the purpose and usefulness of a model class in an iOS app. 

> It implements the app’s data model. 
>
> Central place to manage and maintain the app’s data.
>
> Provides properties (data state) and functions (state modification).

<br>

`2.` What is the most obvious and useful benefit of a navigation controller? (UINavigationController)

> Enables a way to navigate data or operations that are organized in a hierarchy
>
> Less obvious and useful – has a nav bar, to display object title, and hold buttons for user operations

<br>

`3.` What is the most obvious and useful benefit provided by a table view controller? (UITableViewController)

> Presents data in a scrolling single-column list
>
> Or, easily supports a hierarchical navigation scheme
>
> Less obvious and useful – adopts protocols to help build the table view 

<br>

`4.` Briefly compare a push segue with a modal segue. How does their appearance differ? How do their use cases (their reason for being) compare? 

> Push segue… right-to-left slide in, has “back” button, for drill-down into data or tasks
>
> Modal segue… slide up from bottom, covers the screen, intended to interrupt the task that presented it

<br>

`5.` When doing web programming, and building an HTML Table (for example) you typically write the code to loop through the data and render table elements. In an iOS table view, the process is quite different. Briefly explain how. 

> Table view is managed by a UITableViewController
>
> iOS runtime calls methods to build the table view
>
> Therefore, the programmer MUST write the code for these delegate methods
>
> In other words, we are not in control – we are writing event handlers

<br>

`6.` Briefly describe the best practice for initializing then using a model object in an iOS app. 

> The model class init will get or materialize the data, and make the data available as public properties and functions. 
>
> When the app starts up, the app delegate will create an instance of the model.
>
> It will pass it on to the first view controller in the app. 
>
> The implication is that all view controllers must be configured with a property to hold the model object.

<br>

`7.` After reading the “About Table Views” or “UIKit User Interface Catalog” documents, what was the most interesting thing that you learned about the functionality of a table view? (What are you looking forward to doing/coding in the near future with a table view?)

> Answers will vary.

<br>

`8.` Briefly explain the view and logic hierarchy of a table view. We’re interested in how the physical appearance of a table view is organized, or laid out, or generated. 

> Main take-away:
>
> A table view has cells.
>
> A table view cell has content. Each is generated to hold whatever you want, based on the data source.
>
> Some table cells can be “grouped” into “sections”.

