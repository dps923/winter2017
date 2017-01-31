## Test 1 - Example Answers

When your test is marked, we are looking for an answer that captures the essence of the example answers (indented, below). Your answer does not necessarily have to be exactly the same, and part marks are possible. Over time, you should strive to improve your explanations, as that will improve your academic and career prospects.

`1.` Briefly define and describe the purpose of any two (2) of the following iOS application components. If it helps your answer, use an example. (1 mark each; 2 marks total)  
Application delegate  
Delegate  
View controller  
Storyboard  
Scene  

> Application delegate – A helper object; it is a central (and required) component of an iOS app, as it implements methods that are important during the app’s startup and lifetime.  
>
>Delegate – A helper object that performs tasks for an object that cannot be directly edited. 
>	
>View controller – An object that manages a view/scene. Implements the “C” in MVC.
>
>Storyboard – The user interface design surface in Xcode. Contains the app’s scenes and segues. 
>
>Scene – One specific user interface. Each scene is the “V” in MVC. Managed by a view controller.

<br>

`2.` Briefly explain the purpose of protocol in Swift.

>Names required and/or optional methods that must be implemented by adopting classes.
>
>Enables loose coupling of classes.

<br>

`3.` Consider a scenario where a scene includes a picker view object. Briefly explain the storyboard and coding tasks that must be done to enable the picker view to display its data at runtime.

>Drag a picker view to the scene.
>
>Configure an outlet connection to the view controller code
>
>Configure the view controller to be its delegate and data source
>
>In the view controller code, edit the class signature to include the two protocols
>
>Implement the necessary protocol methods to build and react to the picker view

<br>

`4.` Name the property that’s used to read or write data to a UITextField object. Then, briefly explain why we must do string/number conversions on its data (assuming that we need the data as a number). 

>“text”
>
>Its data type is String – so we MUST do string/number conversions if we have to!

<br>

`5.` Is it possible to configure a user interface object as both an outlet and an action? Explain your answer.

>Yes.
>
>Sometimes you need to read-or-write the object’s value.
>
>And sometimes, you need to react to changes in its state, as a result of user interaction.
