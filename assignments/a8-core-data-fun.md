## DPS923 MAP523 Assignment 8 - Core Data Fun

Assignment 8 enables you to perform common tasks (add, delete, search) in an app that uses a Core Data store. A table view controller will show live updates, based on user interaction.  
<br>

> This document is being edited.  
> This notice will be removed when the edits are complete.  

<br>

### Due date
Wednesday, March 29, 2017, at 11:00pm ET  
Grade value: 5% of your final course grade  

*If you wish to submit the assignment before the due date and time, you can do that.*  
<br>

### Objective(s)  
Learn common patterns for adding, searching, and deleting data that's stored on the device.  
Continue using the foundation topics from previous classes.  
<br>

### Introduction to the problem that you will solve
This is a non-navigating table view that shows people (friends) on a list. It has buttons for Add, Search, and Edit.  

The app loads with an empty list. There are no objects in the store. New friends can be added by tapping the plus button ```+``` on the nav bar at the top.  

<kbd>![Startup](images/a8-list-empty.png)</kbd>&nbsp;&nbsp;<kbd>![Startup](images/a8-add-friend.png)</kbd>  
<br>

After adding a number of friends, the list will show them, alphabetically by last name. Notice that when you add each friend, the fetched results controller (frc) will detect the change, run the query again, and the table view will dynamically reload.  

When you load your friends into the app, make sure you add names that will enable the search function to find multiple matching objects. So, friends with the same first and/or last names.  

As noted above, search is supported, as is edit (delete). For example:  

<kbd>![Startup](images/a8-list-friends.png)</kbd>&nbsp;&nbsp;<kbd>![Startup](images/a8-search.png)</kbd>&nbsp;&nbsp;<kbd>![Startup](images/a8-search-result.png)</kbd>  
<br>

And:  

<kbd>![Startup](images/a8-edit-delete.png)</kbd>  
<br>

### Getting started  
Get (download) the *CoreDataModel* app, which is in the GitHub repo. (Its path is notes/Project_Templates).  

Follow the instructions in its Readme.txt, to create an iOS app named **MyFriends**.  
<br>

#### Verify that the app runs
First, run the app in the iOS Simulator, so that you know that it does successfully run. It will display a list of teacher names, because that's what the project template does, by default. We will replace that functionality with our own.  
<br>

#### Task preview
In the sections that follow, you will perform these tasks:  
1. (more to come)  
<br>

Design a Core Data model.  

Create a table view controller to manage the list of friends.  

Create a controller to handle the "add" functionality.  

Storyboard work:  
Delete the existing detail scene.  
Configure the list scene to work with the new table view controller.  
Make and configure a new "add" scene, it will work with a toolbar button.  



<br><br><br><br><br>
( more to come )  
<br><br><br><br><br>


### Submitting your work
Follow these instructions to submit your work:  

1. Make sure your project works correctly  
2. Locate your project folder in Finder  
3. Right-click the folder, and choose **Compress "(project-name)"**, which creates a zip file (make sure the zip file is fairly small, around 1MB or less)  
4. Login to Blackboard/My.Seneca, and in this course's Assignments area, look for the upload link, and submit your work there  
