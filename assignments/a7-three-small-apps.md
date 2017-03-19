## DPS923 MAP523 Assignment 7 - Fetch, load, query

Assignment 7 enables you to continue working with the network and Core Data, separately and/or together. Three separate small apps will enable you to get experience with some common mobile app patterns.  
<br>

> This document is being edited.  
> This notice will be removed when the edits are complete.  

<br>

### Due date
Wednesday, March 22, 2017, at 11:00pm ET  
Grade value: 5% of your final course grade  

*If you wish to submit the assignment before the due date and time, you can do that.*  
<br>

### Objective(s)
Use the network, and a public web service.  
Save data (from a plist file, and from the network) into a Core Data store.  
Round-trip data, over the network, to a web service.  
Implement differently-configured fetch requests to query a Core Data store.  
Continue using the foundation topics from previous classes.  
<br>

### Introduction to the problem that you will solve
In this assignment, you will create three separate small apps. Each will enable you to learn and get experience in a common mobile app interaction and data-handling pattern.  

(Your teacher team decided that it was better to do three separate small apps, instead of attempting to create an all-in-one app scenario.)  

**App 1 - Plan Tour**: Enable a user to make reservations for a full-day tour of Toronto. Data is sent to a web service, which processes the data and returns a response that confirms the reservation.  

<kbd>![Startup](images/a7-tour-request.png)</kbd>&nbsp;&nbsp;<kbd>![Startup](images/a7-tour-response.png)</kbd>  
<br>

**App 2 - Players**: Load the NFL quarterback player data into a Core Data store (on first run of the app). Then, support querying, using *fetch request* objects.  

> A few more screen captures will be posted  

**App 3 - Courses**: Loads School of ICT academic course data into a Core Data store (on first run of the app). Then, support querying, using *fetch request* objects.  

> A few more screen captures will be posted  

<br>

### App 1 - Plan Tour
Get (download) the new *CombinedModel* app, which is in the GitHub repo. (Its path is notes/Project_Templates).  

Follow the instructions in its Readme.txt, to create an iOS app named **PlanTour**.  

> IMPORTANT!  
> The WebServiceRequest.swift source code file was updated again to add support for the HTTP POST and PUT methods.  
> If you downloaded the new *CombinedModel* app BEFORE Sunday, March 19, at 11:30am, then you have an old or obsolete version of the WebServiceRequest.swift source code file.  
> Before continuing, replace your existing WebServiceRequest.swift source code file with the new file.  

<br>

#### Verify that the app runs
First, run the app in the iOS Simulator, so that you know that it does successfully run. It will display a list of academic programs offered by the School of ICT, because that's what the project template does, by default. We will replace that functionality with our own.  

#### Task preview
In the sections that follow, you will perform these tasks:  
1. Initial storyboard and controller work  
2. Learning about the web service  
3. Controller work  
4. Model work  
<br>

### Storyboard and controller work
On the storyboard, the existing navigation controller and view controller can be deleted. We will need a single scene, a standard view controller, so you can leave that on the storyboard, if you wish.  

Add a new view controller (Swift) code file to the project. Its name will not matter much, so you can name it "TourHome" or something like that. Adopt the WebServiceRequestDelegate, which means that you will have to copy in the ```webServiceRequestDidChangeContent``` method stub.  

It will need a reference to the model. While you're thinking about this, go and edit the app delegate, and set a reference to this new view controller, instead of the original nav + table view.    

Back on the storyboard, set the custom class to the just-added controller. Also, configure it to be the "initial" view controller.  
<br>

#### UI, outlets and actions
From top to bottom, the scene will have the following user interface objects. Some will need labels (use your judgement).  

Text field (outlet): For the name(s) of the people who want to go on the tour. Set the text and keyboard properties so that data input is not annoying for the user.  

Segmented control (outlet): With 6 segments, and segment titles 1 through 6.  

Date picker (outlet): Date mode (no time).  

Button (action and outlet): For the "Buy" action. We need an outlet so that we can disable/enable user interaction with the button.   

Button (action): For the "Clear" action.  

Text view (outlet): Displays data from the web service response. Disable editing.  
<br>

### Web service
A web service has been configured to listen for tour requests. It is designed to accept a package of data in a HTTP POST request, and respond with synthesized info about the tour.  

The web service resource URL is:  
```
https://ios2017.azurewebsites.net/api/tours
```

It supports HTTP GET, but the response will simply tell you what to send.  

The request must have these settings:
POST method
Content type is application/json
It needs a request with this data, as a JSON object:  
* CustomerName - string, length 2 to 100 characters  
* NumberOfCustomers - integer, ranging from 1 through 6  
* TourDate - string, a valid date in ISO 8601 format (see note below)  

For example:  

```json
{
    "CustomerName": "Garvan Keeley",
    "NumberOfCustomers": 4,
    "TourDate": "2017-03-29T12:00Z"
}
```

The response will include:  
* The three data items in the request, unchanged  
* Id - integer, which is an identifier  
* Message - string, information about the tour  
* ReservationCode - string, a reservation (confirmation) code  
* DateCreated - string, in ISO 8601 format  

Use Postman (or similar) to interact with the web service. Create a request, and send it. The data format is JSON, so write/create a suitable JSON object. Study the response.  
<br>

#### ISO 8601 dates
Many JSON interactions with web services use the ISO 8601 standard for dates and times. At a minimum, it needs a date, and hours and minutes. A full representation needs seconds and detailed time zone information.  

We will use the "minimum" format. For example, the ISO 8601 date format for Friday at noon is:  
```
2017-03-24T12:00Z
```

The date picker's "date" property value is a Swift "Date" type. How can we convert the "Date" value to an ISO 8601 compatible string? With the [ISO8601DateFormatter](https://developer.apple.com/reference/foundation/iso8601dateformatter) class. For example:  

```swift
let isoDateString = ISO8601DateFormatter()
isoDateString.timeZone = TimeZone.current
// Then... use the "isoDateString.string..." method
// to get a string from a Swift "Date" value
```

<br>

### Controller work
There are several tasks to be done.  
<br>

#### Initialization (viewDidLoad())
As you have seen and done before, set this class to be the delegate of the model class.

We must set the allowable dates for the date picker:  
* The minimum allowable date will be tomorrow  
* The maximum allowable date will be two weeks from today  

We cannot set these values in the storyboard's Attribute Inspector. They must be set programmatically here.  

To do date arithmetic in Swift, we use the [Calendar](https://developer.apple.com/reference/foundation/calendar) class. For example, if we have a Date object that represents today, we can create another that represents tomorrow:  

```swift
let now = Date()
let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)
```   
<br>

#### Write code for the Clear method
The purpose of this method is to clear any data in the view, and enable user interaction with the objects on the top part of the scene. (Later, you will learn how to disable user interaction, in the Buy method.)  

The other task that must be done in this method is to dismiss the keyboard. This is done by calling the ```resignFirstResponder``` method on the text field.  
<br>

#### Write code for the Buy method
The purpose of this method is to send the data to the web service, and display the response. During this request-response cycle, the code will disable user interaction with most of the objects on the top part of the scene. The Clear button will remain enabled. 
<br>

**Important tasks to do first**  

One of the first things that you should do is ensure that the user has entered something in the customer name field. If not, just return. (Later, we will learn ways to communicate error info to the user.)  

Then, dismiss the keyboard.  

Next, disable most of the controls. Each has an "enabled" property.  

Finally, get the selected date from the date picker, as an ISO 8601 date string.  

Now you're ready to package the data, and call the web service.  
<br>

**Package the data, call the web service**

Create a Dictionary (string key, any value). Get the data from the user interface objects. The key names MUST match the names shown in the sample JSON request above. And, the value types must match.  

> Note: A Dictionary is a standard packaging format when working with JSON objects and a web service. Request and response.  
> The built-in JSON serializer/deserializer expects to work with Dictionary instances when reading or writing JSON objects.  

The last thing to do is to call the method in the Model class which will interact with the web service.  Let's switch to the Model class now, and write that code.  
<br>

### Model work  
As recently discussed, the Model class (in the CombinedModel app project template) now includes all the bits needed for both Core Data and web service interaction. So, this is where we place our code.  

As before, we ALWAYS add two members to the class, to support interaction with a web service:  
* A property to hold the results of the web service request  
* A method that calls the web service  
<br>

#### Property to hold the results  
As you have learned above, we send a POST request to the web service, with a JSON object. The web service responds with HTTP 201, and a JSON object. Not an array, but a single object.

Therefore, create a Dictionary property (string key, any value) to hold the result.  
<br>

#### Method that calls the web service  
This method can (should) accept a single parameter, which will be a Dictionary (string key, any value). Remember, the controller's "Buy" method will be calling this method eventually, and passing on a Dictionary with the data entered by the user.  

Following the pattern you have seen before, write the code, and add in code for the tasks that are new to you:  
```swift
// Create the web service request object  
// Set the HTTP method to POST  
// Configure the resource URL (do this however you wish, with a separate URL base and path, or all-in-one URL base)  

// Set the message body; the syntax is a bit tricky, because "messageBody" can be any type, but we have an incoming Dictionary object  
// This should work:
request.messageBody = userData as AnyObject?

// Send the request
// The code in the "completion" closure does the following:
// The response is available in the "result" variable, which is an ARRAY of AnyObject  
// Recall from above that the web service responds with a single JSON object  
// It can be found as the first (and only) element of the result array, so extract that (it will be a Dictionary)
// Then, set the just-created property value to the extracted Dictionary  

// Notify the delegate that the web service request did change content  
```  
<br>

#### Go back to finish writing code in the controller "Buy" method  
Now that we have a Model class method to call, return to the controller code, in the Buy method, and add the statement that calls the new Model class method.  
<br>

### App 2 - Players
Get (download) the new *CombinedModel* app, which is in the GitHub repo. (Its path is notes/Project_Templates).  

Follow the instructions in its Readme.txt, to create an iOS app named **Players**.  

#### Verify that the app runs
First, run the app in the iOS Simulator, so that you know that it does successfully run. It will display a list of academic programs offered by the School of ICT, because that's what the project template does, by default. We will replace that functionality with our own.  

#### Task preview
In the sections that follow, you will perform these tasks:  
1. (more to come)  

Create a Core Data model that will hold NFL quarterback data  
On first launch, app will open a plist file, and add the contents to the Core Data store  
Nav style app, with a home scene that has two (or three, to be decided) buttons  
One button runs a query (fetch request) that selects the "top 5" quarterbacks by "rating" (sorted)  
The results are displayed on a list (table view controller)  
Another button runs a query (fetch request) that fetches all quarterbacks who play for teams that begin with the letters "C" or "D" (sorted)  
The results are displayed on a list (table view controller)  

URL (use Postman to inspect):  
http://(tba).azurewebsites.net/api/tours  

<br><br><br><br><br>
( more to come )
<br><br><br><br><br>

### App 3 - Courses
Get (download) the new *CombinedModel* app, which is in the GitHub repo. (Its path is notes/Project_Templates).  

Follow the instructions in its Readme.txt, to create an iOS app named **Courses**.  

#### Verify that the app runs
First, run the app in the iOS Simulator, so that you know that it does successfully run. It will display a list of academic programs offered by the School of ICT, because that's what the project template does, by default. We will replace that functionality with our own.  

#### Task preview
In the sections that follow, you will perform these tasks:  
1. (more to come)  

Create a Core Data model that will hold School of ICT course data  
On first launch, app will call a web service, and add the response/contents to the Core Data store  
Nav style app, with two levels, list scene (table view) and details scene (standard view)  
The list (table view) will show relevant info about courses  
When the user taps/selects a row, the way that we get the data for the details scene *will be different* from what you have learned - we will use the unique object identifier (NSManagedObjectID) to query (fetch request) the Core Data store for the item that we want to display  

URLs (use Postman to inspect):  
https://ict.senecacollege.ca/api/courses/in/cpa  
https://ict.senecacollege.ca/api/courses/in/bsd  

<br><br><br><br><br>
( more to come )
<br><br><br><br><br>


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

#### Show / prove that your apps work
Final testing of your apps must be on a device. Then, take a few screenshots that shows/proves that your app works.  

Screenshots can be taken:
- on the device itself
- using the Xcode Devices window (on the Window menu), you can use the "take screenshot" button, and it will be stored on the desktop.
- in the Simulator, File>Screenshot, it will store the file on the desktop

Submit the screenshots with your project. Put them in the project folder, before doing the zip task.  
<br>

### Submitting your work
Follow these instructions to submit your work:  

> Note - special instructions, because you will submit all three (3) apps...  

1. Make sure your apps work correctly  
2. Locate each project folder in Finder  
3. Select all three (using click, then Command+click, then Command+click)  
4. Right-click a selected folder, and choose **Compress 3 items**, which creates a zip file (make sure the zip file is fairly small, around 1MB or less)  
5. Login to Blackboard/My.Seneca, and in this course's Assignments area, look for the upload link, and submit your work there  
