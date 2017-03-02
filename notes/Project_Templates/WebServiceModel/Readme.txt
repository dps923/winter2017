
This adds a new model and data source, for accessing data from the web.
This example loads json data from the web, and uses this data as a model data source.

On startup, the app loads a list of programs from a web service, and shows them in a table view.

The Core Data code in the 'Persistence' group in Xcode is not used. However, it may be useful in future to combine a web data source with a Core Data source, so they are both here.

############################################################

You can use this project as a 'template'. How?

In Finder, select this project's folder.
Command+D to duplicate.

Rename the folder to your desired new name.
Open the folder, then open the project file (still named "Classes.xcodeproj") in Xcode.

In the Project Navigator, select the project item (it has a blue icon).
Press the tab key, and type your desired new name.
You will be prompted through the rename procedure.

On the Product menu, choose Scheme > Manage Schemes...
Click to select the (only) scheme, and press the tab key until it highlights the (old) scheme name.
Type the new scheme name, and press Enter (then Close on the dialog box)
