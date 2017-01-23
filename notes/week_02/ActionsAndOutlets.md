#### Learn the common user interface controls

Create an iOS app, using the Single View Application template.

Select Main.storyboard to edit the user interface.

#### Text field

“Text fields allows the user to input a single line of text into an app. You typically use text fields to gather small amounts of text from the user and perform some immediate action, such as a search operation, based on that text.” ([Text Fields](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UITextField.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uitextfield_intro_2x.png)

Drag a text field to the scene.

Size to fit your situation.

Create an outlet. For the code samples below, we’ll assume that its name is “userInput”.

**Read the content** from the “text” property with this code:
```swift
var foo = userInput.text
```

**Write the content** to the “text” property with this code:
```swift
userInput.text = "hello"
```

Study/skim the [UITextField](https://developer.apple.com/library/ios/documentation/uikit/reference/UITextField_Class/Reference/UITextField.html) class reference documentation.

#### Label

“A label displays static text. Labels are often used in conjunction with controls to describe their intended purpose, such as explaining which value a button or slider affects.” ([Labels](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UILabel.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uilabel_intro_2x.png)

Drag a label to the scene.

Size to fit your situation.

Create an outlet. For the code samples below, we’ll assume that its name is “results”.

**Read the content** from the “text” property with this code:
```swift
var foo = results.text
```

**Write the content** to the “text” property with this code:
```swift
results.text = "hello"
```
Study/skim the [UILabel](https://developer.apple.com/library/ios/documentation/uikit/reference/UILabel_Class/Reference/UILabel.html) class reference documentation.

#### Button

“Buttons let a user initiate behavior with a tap. You communicate a button’s function through a textual label or with an image.” ([Buttons](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UIButton.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uibutton_intro.png)

Drag a button to the scene.

Size to fit your situation.

Create an action. For the code samples below, we’ll assume that its name is “doSomething”.

**Write code** in the method implementation to do whatever you want. 
For example, copy from the text field to the label:
```swift
results.text = userInput.text
```
Study/skim the [UIButton](https://developer.apple.com/library/ios/documentation/uikit/reference/UIButton_Class/UIButton/UIButton.html) class reference documentation.

#### Text view

“A text view accepts and displays multiple lines of text. Text views support scrolling and text editing. You typically use a text view to display a large amount of text, such as the body of an email message.” ([Text Views](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UITextView.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uitextview_intro_2x.png)

Drag a text view to the scene.

In this example, we will use the text view to display content, but editing will be disabled. In the Attributes Inspector, you can type or paste text. (The code example has the text from the DPS923 course description.)

Size it to fit your situation.

Create an outlet. For the code samples below, we’ll assume that its name is “courseDescription”.

**Read the content** from the “text” property with this code:
```swift
var foo = courseDescription.text
```
**Write the content** to the “text” property with this code:
```swift
courseDescription.text = "hello"
```
Study/skim the [UITextView](https://developer.apple.com/library/ios/documentation/uikit/reference/uitextview_class/Reference/UITextView.html) class reference documentation.

#### Segmented control

“A segmented control is a horizontal control made of multiple segments, each segment functioning as a discrete button.” ([Segmented Controls](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UISegmentedControl.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uisegmentedcontrol_intro_2x.png)

Drag a segmented control to the scene.

Size to fit your situation.

Create an outlet, if you want access to the segmented control’s properties and methods anywhere in the controller. For the code samples below, we’ll assume that its name is “itemSelector”.

Create an action, if you want to handle an event, such as a change in the selected segment. For this control, the “Value Changed” event is the default event shown in the dialog, but you can choose another if you wish. (Remember to change the Type selected to UISegmentedControl.) For the code samples below, we’ll assume that its name is “itemSelectionChanged”.

**Read the control state** with this code, from anywhere in the controller:
```swift
var segmentIndex = itemSelector.selectedSegmentIndex  
var segmentTitle = itemSelector.titleForSegmentAtIndex(2)
```

**Write the control state** with this code, from anywhere in the controller:
```swift
itemSelector.selectedSegmentIndex = -1  
itemSelector.setEnabled(false, forSegmentAtIndex: 2)  
itemSelector.setTitle(“Hello” forSegmentAtIndex: 1)
```

**Handle an event** in the ‘action’ method, with this code: (“sender” is a reference to the segmented control)
```swift
// do whatever; you can use “sender” as the local name of the control  
var segmentIndex = sender.selectedSegmentIndex  
sender.setTitle(“Hello” forSegmentAtIndex: 1)
```

Study/skim the [UISegmentedControl](https://developer.apple.com/library/ios/documentation/uikit/reference/UISegmentedControl_Class/Reference/UISegmentedControl.html) class reference documentation.

#### Slider

“Sliders enable users to interactively modify some adjustable value in an app, such as speaker volume or screen brightness. Users control a slider by moving its current value indicator along a continuous range of values between a specified minimum and maximum.” ([Sliders](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UISlider.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uislider_intro_2x.png)

Drag a slider to the scene.

Size to fit your situation. Configure its minimum and maximum values, and its initial value.

Create an outlet, if you want access to the slider’s properties and methods anywhere in the controller. For the code samples below, we’ll assume that its name is “temperature”.

Create an action, if you want to handle an event, such as a change in the slider’s current value indicator. For this control, the “Value Changed” event is the default event shown in the dialog, but you can choose another if you wish. (Remember to change the Type selected to UISlider.) For the code samples below, we’ll assume that its name is “temperatureChanged”.

**Read the control state** with this code, from anywhere in the controller:
```swift
var temperatureValue = self.temperature.value  
var maxTemperature = self.temperature.maximumValue
```
**Write the control state** with this code, from anywhere in the controller:
```swift
temperature.value = 23.5f;
```
**Handle an event** in the ‘action’ method, with this code: (“sender” is a reference to the slider)
```swift
// do whatever; you can use “sender” as the local name of the control  
var newTemperature = sender.value  
sender.value = 31.0f;
```
Study/skim the [UISlider](https://developer.apple.com/library/ios/documentation/uikit/reference/UISlider_Class/Reference/Reference.html) class reference documentation.

#### Switch

“A switch lets the user turn an option on and off. You see switches used throughout the Settings app to let a user quickly toggle a specific setting.” ([Switches](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UISwitch.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uiswitch_on_2x.png) – ![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uiswitch_off_2x.png)

Drag a switch to the scene.

Create an outlet, if you want access to the switch’s properties and methods anywhere in the controller. For the code samples below, we’ll assume that its name is “activateAudio”.

Create an action, if you want to handle an event, such as a change in the switch’s state. For this control, the “Value Changed” event is the default event shown on the dialog, but you can choose another if you wish. (Remember to change the Type selected to UISwitch.) For the code samples below, we’ll assume that its name is “switchTapped”.

**Read the control state** with this code, from anywhere in the controller:
```swift
var isAudioActivated = activateAudio.on
```
**Write the control state** with this code, from anywhere in the controller:
```swift
activateAudio.on = true
```
**Handle an event** in the ‘action’ method, with this code: (“sender” is a reference to the switch)
```swift
// do whatever; you can use “sender” as the local name of the control  
if (sender.on)…
```
Study/skim the [UISwitch](https://developer.apple.com/library/ios/documentation/uikit/reference/UISwitch_Class/Reference/Reference.html) class reference documentation.

#### Stepper

“A stepper lets the user adjust a value by increasing and decreasing it in small steps. Steppers are used in situations where a user needs to adjust a value by a small amount.” ([Steppers](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UIStepper.html), from the UIKit User Interface Catalog)

![](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/Art/uistepper_intro_2x.png)

Drag a stepper to the scene.

Configure its minimum, maximum, and current values, and other properties if you wish.

Create an outlet, if you want access to the stepper’s properties and methods anywhere in the controller. For the code samples below, we’ll assume that its name is “ageSelector”.

Create an action, if you want to handle an event, such as a change in the stepper’s state. For this control, the “Value Changed” event is the default event shown on the dialog, but you can choose another if you wish. (Remember to change the Type selected to UIStepper.) For the code samples below, we’ll assume that its name is “adjustAge”.

**Read the control state** with this code, from anywhere in the controller:
```swift
var currentValue = ageSelector.value  
var maximumValue = ageSelector.maximumValue
```

**Write the control state** with this code, from anywhere in the controller:
```swift
ageSelector.Value = 25.0f
```

**Handle an event** in the ‘action’ method, with this code: (“sender” is a reference to the stepper)
```swift
if (sender.value > 29)…
```

Study/skim the [UIStepper](https://developer.apple.com/library/ios/documentation/uikit/reference/UIStepper_Class/Reference/Reference.html) class reference documentation.

#### Image

“An image view displays an image or an animated sequence of images. An image view lets you efficiently draw an image (such as a JPEG or PNG file) or an animated series of images onscreen, scaling the images automatically to fit within the current size of the view.” ([Image Views](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/UIKitUICatalog/UIImageView.html), from the UIKit User Interface Catalog)

If you have an existing image, save it somewhere in your project. In Project Navigator, you should probably create a folder to hold your app’s image assets. Maybe create a new group (folder) named “Images” under your main project group (folder), or under the Supporting Files group (folder). Then right-click then “Add Files to…” (and make sure to check-mark/select “Copy items into destination…).

When you do this, then the images are available to your _Media library_ (fourth icon from the left) in the panel at the bottom of the Utility area (on the right side of the Xcode screen). Simply drag-and-drop the image to your scene. That action will wrap your image with a UIImage object, which you can then configure to suit your needs.

Alternatively, you can set the image at runtime.

Create an outlet. For the code samples below, we’ll assume that its name is “myPhoto”.

**Read the content** from the “image” property with this code:
```swift
CGSize imageSize = myPhoto.image.size()
```

**Write the content** to the “image” property with this code:
```swift
myPhoto.image = UIImage.imageNamed(“peter.png”)
```

Study/skim the [UIImageView](https://developer.apple.com/library/ios/documentation/uikit/reference/UIImageView_Class/Reference/Reference.html) class reference documentation.

#### Code example

A code example will also be posted in the GitHub code repository.

Here’s the startup state of the app:

![UI Controls startup state](https://petermcintyre.files.wordpress.com/2014/01/ui-controls-startup-state.png?w=595)

Here’s what it looks like after being used:

![UI Controls after using](https://petermcintyre.files.wordpress.com/2014/01/ui-controls-after-using.png?w=595)
