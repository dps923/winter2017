UISplitViewController

https://developer.apple.com/reference/uikit/uisplitviewcontroller

The UISplit​View​Controller class is a container view controller that presents a master-detail interface. In a master-detail interface, changes in the primary view controller (the master) drive changes in a secondary view controller (the detail).

The two view controllers can be arranged so that they
- are side-by-side,
- so that only one at a time is visible,
- or so that one only partially hides the other.

You cannot push a split view controller onto a navigation stack, by-design they should be the root view controller in your app.

## Why is this an important topic?

In the course we have built apps that show a table view that navigates, and we have targeted iPhones for these apps.<br>
On iPad, the apps work ok, but look very odd –since the table view (and the detail view shown when a row is tapped) take up the entire screen. This is not a good use of screen space.

We _could_ use auto layout with trait variations to design our interface to adapt to the different screen sizes. <br>
But -yay- we don't have to. Apple provides the UISplitViewController to handle this for us.

On **iPad** it provides:
* A master view on the left (typically a table view), defaults to 320 points wide
* A detail view on the right

On the **iPhone** it behaves as if the split view isn't there, and will just show the master and detail view full-screen. (This is how our existing apps have behaved.)

In summary, if your app can make use of the master-detail view layout, UISplitViewController saves you a ton of work to make an app that displays nicely on iPad and iPhone.

### iPhone 6+ and 7+ in Landscape behave like iPads

These are special devices in the iPhone family due to their large screen size.<br>
In portrait view, the layout system will treat them as iPhones, but in landscape view, they will behave exactly like iPads in landscape view.<br>
For simplicity, in these notes I am going to refer to split view controller behaviours in simple terms of iPad vs. iPhone.

## Setting up in storyboards

Start with a single view app, and clear the storyboard and delete the ViewController.swift, so everything is empty.

Drag a UISplitViewController to the storyboard.
This will create scenes for four items:
- a split view controller
- a navigation controller, which has it's root view controller set to a table view controller
    - this is the *master* relationship
- a view controller
    - this is the *detail* relationship

The split view controller has **relationships** to master and detail view controllers, these are preset to the navigation controller and the view controller respectively.

### Connect the master and detail with a segue

By default, the master and detail aren't connected in any way.<br>
The desired behaviour is that tapping on a row in the master table view, will change the content in the detail view controller.

Drag-connect on the storyboard from the cell in the table view to the detail view controller, and select a 'Show Detail' segue.<br>
Note this connection is being made between two scenes; from the master (the table view scene) to the detail (the detail view scene).

Tapping on a row in the table view will now trigger `prepare(for segue: UIStoryboardSegue, sender: Any?)` which we are familiar with.<br>

### A bare minimum demo app

What we have so far will run, but the master and detail panes are empty.

To get our app to show content in the master and detail, we need to create Swift UIViewController classes for those.

Let's create a TableViewController.swift and a DetailViewController.swift, which matches what we have been doing in the assignments. 

Notice that the UISplitViewController and the UINavigationController on the Scene don't need to be connected to concrete Swift classes in our project. 

>Consider why we have been doing this (or not doing it)

>If we are customizing the behaviour of a Scene, we need to connect it to a concrete view controller class in our project. In those classes we write code to customize how it behaves.

>If we needed to customize the split view controller behaviour beyond what can be accomplished in Interface Builder (or customize the navigation controller), a Swift class in the project code would be created that subclasses UISplitViewController (or UINavigationController) and wired up accordingly to the Scene objects.

The minimum we could do in the table view would be to display some static data in a few rows (arbitrarily, five rows are used):

```swift
class TableViewController: UITableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "My row number is \(indexPath.row)"
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! DetailViewController
        detail.rowNumber = tableView.indexPathForSelectedRow?.row
    }
}
```

And the detail view controller will have a single label:
```swift
class DetailViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    var rowNumber: Int? = nil

    override func viewDidLoad() {
        if let rowNumber = rowNumber {
            label.text = "Row Num \(rowNumber)"
        }
    }
}
```

In the storyboard, the detail view controller needs a label as mentioned, and the table view controller will need the cell reuse identifier set to "reuseIdentifier".

Now if we run we have a working UISplitViewController with a five-row table view, that when rows are tapped on, will show the row number tapped in the detail view.

* on iPad:
    * in portrait one can swipe from the left of the screen to show the master table view
    * and in landscape, the master table view is always shown
* on iPhone:
    * behaves like a standard navigating table view controller, except it starts with the detail view showing and a "Back" navigation button on the upper left

## Improving Split View navigation behaviour

There are a two setup quirks to UISplitViewController regarding the navigation bar behaviour.

#### Quirk 1: Double navigation controllers 

Apple recommends that both the master and detail controllers are navigation controllers. <br>
Dropping a UISplitViewController on your Scene doesn't setup the views this way, it only adds the master as a navigation controller.

Without the detail as a navigation controller, you get no navigation bar on the right side, and this is rarely what you want in your app. (Some apps will use this, but it is an exception).

See the section on **Double Navigation Controllers** here:<br>
http://nshipster.com/uisplitviewcontroller/ <br>
It explains it very well.


#### Quirk 2: displayModeButtonItem 

When in portrait mode on an iPad, the master view is hidden and requires swiping from the left to show as an overlay.
_This is the default behaviour, the split view can be configured to show the master at all times._

However, there is no indicator that there is a master view, it looks just like a regular view with a navigation bar with a title. The user will not know to swipe from the left to show the master view.

`UISplitViewController.displayModeButtonItem` and `UINavigationController.leftItemsSupplementBackButton` make for a 2-line solution to this quirk.

```swift
    // in DetailViewController viewDidLoad()
    navigationItem.leftItemsSupplementBackButton = true
    navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
```

This won't affect the iPhone views, and will 'do the right thing' on iPad and show an indicator in the upper left that can be tapped to show the master view.

See the section on **displayModeButtonItem** here:
http://nshipster.com/uisplitviewcontroller/
