## FriendPix

Assignment 2 is designed to enable you to create a fun and simple app that you can install/copy to an iOS device. It lets you work with graphics and touch, and a device feature, the camera.  
<br>

### Due date
Wednesday, February 1, 2017, at 11:00pm ET  
Grade value: 5% of your final course grade  

*If you wish to submit the assignment before the due date and time, you can do that.*  
<br>

### Objective(s)
Work with graphics and touch  
Copy/install app to an iOS device  
Use the device camera  
<br>

### Introduction to the problem that you will solve
We need an iOS app that enables you to take and display photos of your friends.  

The app will run on a device, like an iPhone, iPad, or iPod touch. On the device, the camera will be used.  

After taking a photo, it will appear on the screen / surface.  
( insert drawing here )
<br>

You will be able to do the following touch tasks for each photo:  
1. Move it, using a tap-and-drag gesture  
2. Bring it to the foreground, if it is partially covered by another photo, by using a single tap  
3. Removing it from the view (i.e. delete), by using a press-and-hold (for two seconds) gesture  
<br>

### Getting started
Create a new iOS app, using the Single View Application template. The name of the app should be **FriendPix**. 

It should target the iPhone, and do not use source control (e.g. git).

#### App cleanup
It is possible that you will have to configure/set a development team. For ease of use, select the "Personal Team" item.  

The project template created a view controller with the source code file named "ViewController.swift". Inside that source code file, the class name is "ViewController".  

Those names are OK for the project template code generator, but we do not like them. So, let's fix them.

**Source code file rename** - In the project navigator panel, click to select the ViewController.swift source code file. Then press the `Tab` key, and its name will be selected, ready for you to type the new name.  

What name should we use: How about "PhotoSurface.swift".  

**Class rename** - Open the PhotoSurface.swift source code file for editing. Simply replace the class name "ViewController" with "PhotoSurface".  

Are we done? No. Why? The storyboard scene is still configured with the "ViewController" name. So, if you attempt to run the app now, it will fail.  

Here's how to fix that: Open the Main.storyboard for editing. Select the "View Controller" icon in the top area of the scene's rectangle. On the right-side Identity Inspector (the third icon over), notice the "Custom Class" section of settings. Currently, the "Class" is the old bad value. Simply change it to the new "PhotoSurface" value.  

Build and optionally run to ensure that the cleanup tasks were done correctly.  
<br>

### Think about the app's code design (classes etc.)
You already know that the app will have a view controller class (PhotoSurface).  

We will need one more separate class, to define and describe a photo. Although it is technically possible to do what we need to without a separate class, it is a much better and cleaner design to have one.  

The new class - Photo - will be a subclass of UIImageView. In the "shapes" code examples, you saw that we created a "Shape" class, which was a subclass of UIView. Well, for us, UIView doesn't have enough.  

UIImageView is a sublcass of UIView, so it has all its goodness. In addition, it is specifically designed to hold an image (photo), and has features that are nice and useful for image-handling.  

Similar to the "shapes" code examples, we will add touch and gesture handlers to the new class. All the functionality in one place. Nice.  

( add diagram here )  
<br> 

### Configure the scene
The scene will have a very simple configuration. It will have one button. So, add it now. It's text can be something simple like "Add Photo".  

Then, add a connection - an action - for the button. The action (function) name can be something simple like "addPhoto". For best results, in the Connection dialog, make sure the Type is UIButton.  

![Make sure the Type is UIButton](images/connection-action-type.png)  
<br>

Optionally, you can make the background black, instead of white. How?  
1. Make sure the Document Outline is showing, so that you can see the view hierarchy.  
2. Select the "View" object in the Document Outline. You will notice that the rectangle will have a light blue shade, indicating that it has been selected.  
3. On the right-side Attributes Inspector, look for the "Background" setting in the "View" section of settings. You probably know how to do the rest.  
<br>

### Write code for the new Photo class
To plan for this task, study (again) the "shapes" code examples. Notice that their "Shape" classes have:  
- initialization and configuration  
- custom drawing  
- touch/gesture handlers  

Well, in our class, we will need *initialization* and *touch/gesture handlers*. Our job is simple enough that we will not need custom drawing (and anyway, we're not really drawing anything, because the image/photo is the content to be rendered). 

First, add the source code file to hold the new class. In the left-side project navigator, click/select the "FriendPix" group (folder). Add a new file. (There are at least three ways to do this; use your common sense and experience with other editor enviroments to figure out how to do this task.)  

The template for a Swift class is "Cocoa Touch Class".  
![Choose Cocoa Touch Class](images/new-file-cocoa-touch-class.png)  
<br>

Its name can be something simple like "Photo", and it should be a subclass of UIImageView.  

![Choose UIImageView](images/photo-class-based-on-uiimageview.png)  
<br>

#### Initialization - part one
In subclasses of UIImageView (and UIView), we must write the initialization function(s). (We will need two here.)  

Here's the code-writing cadence that you can use here, and into the future. First, in the class, type "init" and allow the code sense to show you the choices.  

![init choices](images/init-step-1.png)  
<br>

Choose the highlighted choice, with the "frame: CGRect" parameter. It gets added to the class. After a few seconds, the compiler will complain.  

![init choices](images/init-step-2.png)  
<br>

Click the first error (stop sign). It tells you how to fix. Accept the fix.  

![init choices](images/init-step-3.png)  
<br>

Next, click the remaining error. It tells you how to fix. Accept the fix.  

![init choices](images/init-step-4.png)  
<br>

At the end, you will have two initialization functions. The first one is used by us in our view controller code. The other is required for compatibility (and you may learn about that in the future). 

![init choices](images/init-step-5.png)  
<br>

Soon, you'll learn how to replace the code in the "required init?" function.   

We do not need the commented out draw code, so you can remove that commented code block, if you wish.  
<br>

#### Initialization - part two
Above, you added the "init" functions that are needed for compatibility and convention. In all initialization situations, we need to do the same set of tasks. Therefore, let's follow the pattern that we learned in the "shapes" code examples. 

Add a new private function, probably named "commonInit".  

Now, go back and clean up the "init" functions. In "override init", call super (this is a convention), and then call commonInit:

```swift
super.init(frame: frame)
commonInit()
```

In "required init?", call super, and then call commonInit:

```swift
super.init(coder: aDecoder)
commonInit()
```

Soon, we'll come back to commonInit, and write code to work with the touch and gesture handlers.  
<br>

#### Touch / gesture handlers



<br><br><br>
Here's a draft of what we'll probably do...

It will show the camera app (on a device) or the photo library (on the simulator)  
Taking (or selecting) a photo will resize it (maybe 150 wide) and place it on the view  
The user can then drag it to a new location on the view  
Can repeat, to take (or select) another photo and reposition it  

It is possible that you may have to support "delete"  
And/or maybe "save"  
Will want a screen capture of the working app with a number of photos

<br><br><br>

### Submitting your work
Follow these instructions to submit your work:  
1. Make sure your project works correctly  
2. Locate your project folder in Finder  
3. Right-click the folder, and choose **Compress "(project-name)"**, which creates a zip file (make sure the zip file is fairly small, around 500KB or less)  
4. Login to Blackboard/My.Seneca, and in this course's Assignments area, look for the upload link, and submit your work there  
