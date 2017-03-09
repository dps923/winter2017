## DPS923 MAP523 Assignment 6 - Query the iTunes Store Web Service

Assignment 6 enables you to begin working with the network, in read-only mode. We will send queries to the iTunes Store web service, and display the results on the device.  
<br>

~~~
This document is being edited.  
We expect to be finished the edits by mid-day on Friday, March 10.  
When the edits are complete, this notice will be removed.  
~~~
<br>

### Due date
Wednesday, March 15, 2017, at 11:00pm ET  
Grade value: 5% of your final course grade  

*If you wish to submit the assignment before the due date and time, you can do that.*  
<br>

### Objective(s)
Use the network, and a public web service.  
Create an interactive app with a search screen, which will lead to a navigation-based result, with two levels (list, and list-or-detail)  
Continue using the foundation topics from previous classes.  
<br>

### Introduction to the problem that you will solve
We need an app that will enable the user to search the iTunes Store for music, and *display* the results. The app uses the network, so its essential nature is that it will perform its search/fetch and rendering tasks in an asynchronous manner.  

The app's start screen is a data entry screen, and will be managed by a standard view controller. It will enable the user to enter values in one or more text fields. The purpose of this screen will be to gather search terms to be used when querying the iTunes Store web service.  

When the app user taps/selects the "Search" button, a results list (managed by a table view controller) will slide in, and display a list of items that match the search term(s).  

Then, when the app user taps/selects an item on the list, another  screen will slide in:  
* If the item is a song, a standard details view will appear  
* Alternatively, if the item is an album, a list will appear (managed by a standard view controller)  
<br>

> Notice - We plan to post a few more screen shots by mid-day Friday, March 10 (and then we'll remove this notice)  

<br>

<kbd>![Startup](images/a6-startup.png)</kbd>&nbsp;&nbsp;<kbd>![Search scene](images/a6-search-terms.png)</kbd>&nbsp;&nbsp;<kbd>![Search results scene](images/a6-search-results.png)</kbd>  
<br>

### Getting started
Get (download) the WebServiceModel app, which is in the GitHub repo. (Its path is notes/Project_Templates.) 

Follow the instructions in its [Readme.txt](https://github.com/dps923/winter2017/blob/master/notes/Project_Templates/WebServiceModel/Readme.txt), to create an iOS app named **MusicFinder**.  

Show the "projects and targets list", and select the project. Verify that the iOS Deployment Target is set to version 9.0, so that the app will work with all modern/typical devices.  
<br>

#### Verify that the app runs  
First, run the app in the iOS Simulator, so that you know that it does successfully run. It will display a list of academic programs offered by the School of ICT, because that's what the project template does, by default. We will replace that functionality with our own.  
<br>

#### App cleanup
There will be several cleanup tasks, but we'll do them later. Why? We want to leave the project template code bits in the project, until we have added replacements. That way, your app can be built incrementally, and it will still run successfully.  

The project includes a Core Data stack. We will not be using it in this Assignment 6. 
<br>

#### Task preview
In the sections that follow, you will perform these tasks:  
1. Visualize the storyboard  
2. Add new view controllers  
1. (to be determined)  
2. (to be determined)  
<br>

### Visualize and then partially configure the storyboard  
The storyboard in the project template enables the app to run successfully, but it will not be suitable for our use. In this section, you will learn how to modify the storyboard.    
<br>

#### Clean up the existing storyboard
The existing storyboard, as provided in the project template, has three assets on it:  
1. Navigation controller object  
2. Table view scene  
3. Standard view scene  

We do not need numbers 2 and 3. So, delete them, leaving only the navigation controller.  
<br>

#### Do an initial configuration of the storyboard
After you complete this section, your storyboard will look similar to the following:  

![Storyboard, interim](images/a6-storyboard-interim.png)  
<br>

As described above, the app's start screen is a data entry screen. So, add a view controller. Position it to the right of the navigation controller.  

> We will configure its custom class (controller) later/soon.  

Add three text fields to the top area of the scene. 

> We will configure some more properties of the text fields later/soon.  

Add a button to the view, located below the text fields. Configure its visible text to be "Search".  

> We will configure an outlet for it later/soon.  

Next, click/select the navigation controller. Add a segue to the new view controller; it will be a Relationship Segue > root view controller.  

As described above, when the app user taps/selects the "Search" button, a results list will slide in. So, add a table view controller to the storyboard. Position it to the right of the just-added view "search" controller. 

> We will configure its custom class (controller) later/soon.  
> We will also configure its prototype cell later/soon.  

Next, click/select the button on the "search" view controller. Add a segue to the new table view controller; it will be an Action Segue > Show.  

> Yes, we can do this. A button tap can trigger a segue. It does not have to be tied to an action.  

Later, we will return to the storyboard, and configure additional scenes.  
<br>

### Create a controller for the "search" scene  
In this section, you will create a *new* view controller, which will display a list of Program objects. The contents and layout of the new controller will be similar to the ExampleList controller that's included in the project template.  

There are a number of programming tasks that must be done:  
1. Create the new controller class  
2. Configure it for use with Core Data and our app architecture (in other words, the Model class)  
3. Write the initialization code  
4. Write the code that will render the data in the table view  
<br>

#### Create the new controller class  
In/under the Classes group, create a new Cocoa Touch Class. It will be a subclass of UIViewController (right?). We suggest that you name it "MediaSearch".  
<br>

#### Configure it for use  
Next, study the ExampleList controller code. Notice that it has a reference to the model class. Do the same for the MediaSearch controller.  

In viewDidLoad(), set/configure the scene's title property with something (like "Search music").  
<br>

#### Fix the app delegate startup method  
In the application(didFinishLaunchingWithOptions) function, it has code that passes the model object reference to the ExampleList controller.  

Change the code so that it passes the reference to the MediaSearch controller.  
<br>

#### Fix the storyboard  
Now that we have the MediaSearch controller created and partially configured, fix the "search" scene on the storyboard. Set its custom class to MediaSearch.  
<br>

#### Test your work
At this point in time, the app should load, and show the "search" scene. It will not have any functionality yet, but it should load.  
<br>

### Learn how to use the iTunes Store web service
The iTunes Search API (web service) enables you to search for content within the iTUnes Store, App Store, iBooks Store, and Mac App Store.  

[Here is a link](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/) to its documentation. The text below will get you started, but you will need to read/scan the documentation to get full value out of the API.  

As you learned in the Week 8 Monday notes and class, it is an open web service, and does not require a developer key for casual use. Specifying a resource URL that begins with  
```
https://itunes.apple.com/search?parameterkeyvalues  
```
will return plain-text JSON results.  
<br>

#### Searching for music
We want to enable the user to search for music. We will enable them to enter search terms, for at least one, but maybe any of:  
* Artist  
* Album  
* Song  

There are seven (7) kinds of queries that are possible:  
* Any one search term (3 possible)  
* Any two search term (3 possible)  
* All three search terms

For example:  

**Any one**

Artist - yes  
Album - no  
Song - no  
All works by the artist   
https://itunes.apple.com/search?term=the+rolling+stones&limit=15  

> The "limit" key is not required. It is used here to simply make the result set smaller.  

Artist - no  
Album - no  
Song - yes  
A specific song (from any artist on any album)  
https://itunes.apple.com/search?term=under+my+thumb&entity=song  

**Any two**

Artist - yes  
Album - yes  
Song - no  
A specific album by the artist  
https://itunes.apple.com/search?term=the+rolling+stones+exile+on+main&entity=album&limit=15  

Artist - no  
Album - yes  
Song - yes  
A specific song on a specific album  
https://itunes.apple.com/search?term=hot+rocks+under+my+thumb&entity=song  

Artist - yes  
Album - no  
Song - yes  
A specific song by an artist  
https://itunes.apple.com/search?term=rolling+stones+under+my+thumb&entity=song&limit=25  

**All three**

Artist - yes  
Album - yes  
Song - yes  
A specific song on a specific album by the artist  
https://itunes.apple.com/search?term=the+rolling+stones+hot+rocks+thumb&entity=song  
<br>

#### Identifiers
As you would expect, all data items have identifiers. Two common identifiers that you will see include artistId and collectionId (for the album). Here's some more information:

To extract the collectionId, which is the album identifier  
"artistId":275557, "collectionId":251792623  

Info about the artist  
https://itunes.apple.com/lookup?id=275557  

Info about the album  
https://itunes.apple.com/lookup?id=251792623    

Songs on an album  
https://itunes.apple.com/lookup?id=251792623&entity=song  

Songs by an artist  
https://itunes.apple.com/lookup?id=275557&entity=song&limit=25  
<br>

#### Wrapper types
Values in the results are organized in a certain way. For example you would expect a "song" query to include just the info about that song. Alternatively, you would expect an "album" query to include a *collection* of song items.  

We will use wrapper type values to determine what scene to show after an item is tapped/selected from a list-of-results scene (table view). Here's some more information:  

wrapperType = artist  
artistId = <number>  
artistName = ADELE  
primaryGenreName = Pop  
artistLinkUrl = <link>  

wrapperType = collection  
collectionId = <number>  
artistName = ADELE  
collectionName = 21  
releaseDate = <date>  
primaryGenreName = Pop  

wrapperType = track  
trackId = <number>  
artistName = ADELE  
collectionName = 21  
trackName = Rolling in the Deep  
releaseDate = <date>  
primaryGenreName = Pop  
<br>

#### Interacting with the web service from your computer
A browser can sometimes interact with a web service, but you should really use an HTTP inspector, which is an app that can configure and send HTTP requests, and accept the responses. Then, it enables you to inspect both, and learn about a web service.  

Your professor team recommends that you add the Postman add-in to your Google Chrome browser configuration.  




<br><br><br><br><br><br>
(more to come)
<br><br><br><br><br><br>


### Preview of what will come
As you read above, this document is being edited. We expect to be finished the edits by mid-day on Friday, March 10. 

However, here's a preview of the tasks that you will do, if you want to explore on your own.  
* Fix the search scene  
* Configure the MediaSearch controller to be able to search the iTunes Store API (which will require string assembly)  
* Add a list-of-results controller, configure it, and the storyboard tasks  
* Return to the search controller, and add the segue code  
* Test  
* Add the ability to handle requests for images (thumbnails), asynchronously  
* Study the results of multiple queries to be prepared for changes to the list-of-results controller  
* Edit the storyboard, to add two new scenes (controllers); one will be another list/table view (for collection results, e.g. songs on an album), and the other a standard view (for one-of result details)  
* Add and code the two new controller classes  
* Iterate and test  
<br>

### Clean up the project  
Now it's time to clean up the project (more to come).  

Reminder about the recently-learned project "clean" task: If you attempted a build/compile/run right now, it is likely that there would be an error (and that error's message isn't really helpful). The reason is due to the cleanup that we just did. Therefore, we can "clean" the project of any past compilation assets, and start anew. How?  

On the Xcode Product menu, there is a Clean option (with keyboard shortcut Command+Shift+K). Choose/run it.  

Then, build/compile (Command+B). It should be successful now. 
<br>

### Test your work
Run the app on the iOS Simulator, using different devices (that have different screen sizes):  
1. iPhone SE or 5 (4-inch screen)  
2. iPhone 7 (4.7-inch screen)  
3. iPhone 7 Plus (5.5-inch screen)  

Make sure that the content lays out nicely, in portrait mode, on all of these screen sizes.  
<br>

#### Borrowing a device
If you have an iOS device, great, please use it in this course. 

If you do not have an iOS device, the School of ICT has a limited supply of iPod touch devices available for loan. Contact Professor McIntyre to request a device.  
<br>

#### Show / prove that your app works
Final testing of your app must be on a device. Then, take a screenshot of **each** scene (list, list, and detail). 

Screenshots can be taken:
- on the device itself
- using the Xcode Devices window (on the Window menu), you can use the "take screenshot" button, and it will be stored on the desktop.
- in the Simulator, File>Screenshot, it will store the file on the desktop

Submit **all three** screenshots with your project. Put them in the project folder, before doing the zip task.  
<br>

### Submitting your work
Follow these instructions to submit your work:  
1. Make sure your project works correctly  
2. Locate your project folder in Finder  
3. Right-click the folder, and choose **Compress "(project-name)"**, which creates a zip file (make sure the zip file is fairly small, around 1MB or less)  
4. Login to Blackboard/My.Seneca, and in this course's Assignments area, look for the upload link, and submit your work there  
