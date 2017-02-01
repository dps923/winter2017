## Test 2 example answers

When your test is marked, we are looking for an answer that captures the essence of the example answers (indented, below). Your answer does not necessarily have to be exactly the same, and part marks are possible. Over time, you should strive to improve your explanations, as that will improve your academic and career prospects.

Answer any five (5) questions.  
<br>

`1.` Briefly compare the features/characteristics of custom subclasses of UIView and UIImageView. 

>UIImageView is a subclass of UIView, so it has all its base state and behaviours
>
>UIImageView purpose-built to hold a stored/generated image or photo 
>
>UIView allows user interaction by default (gestures etc.), but must be configured for UIImageView
>
>Both objects can encapsulate common state or behaviours.
>
>Easier and more consistent coding. Maybe less setup when initializing a new object.

<br>

`2.` Name and briefly explain/describe any two gesture recognizers. 

>Tap – any number of taps, for select
>
>Long press - touch and hold (to initiate a secondary action)
>
>Pinch – in or out, for zooming
>
>Swipe – move with an undefined destination (compared to a known start-and-end point)
>
>Rotate – as its name suggests, rotate an object
Shake device – often an undo, can also be for random value entry

<br>

`3.` Briefly define a “graphics context”, and explain how it can enable you design and implement graphics.

>Area of memory that’s used to compose graphics
>
>Well-understood and accessible API for using it
>
>On iOS, coordinate system begins in upper-left
>
>Objects are placed in layers, normally opaque, unless the layer is translucent 

<br>

`4.` In a custom subclass of UIView (or UIImageView), is it always necessary to implement the “draw” function? Explain your answer. 

>No. 
>
>Only if custom drawing of the image is needed. 
>
>In other words, if the initializer and the object properties can configure the image, draw isn’t needed.

<br>

`5.` Briefly explain the purpose or importance of the “layout” topic. (In other words, what problem are we trying to solve?)

>We get the ability to configure user interfaces that adapt to the screen size and orientation of a user’s device. 

<br>

`6.` Assume that you’re working with a storyboard scene. Consider a situation where we needed an object anchored to the left margin of the (main) view, and another anchored to the right margin of the view. Name and briefly explain two techniques that can make this work. 

>In the Size Inspector, setting the autoresizing handles correctly for each object.
>
>Stack view – Can embed the objects in a stack view, and anchor the left and right edges to the margins.

<br>

`7.` Recently, you learned about the “stack view”. What is its purpose/benefit? (What task(s) does it help with?)

>Convenient container to enable auto layout for a group of objects. 
>
>Enables consistent spacing and appearance, on different screen sizes and orientations. 

<br>

`8.` Using Auto Layout, the same scene can be used for different screen sizes. Briefly describe how any two of these techniques are useful: 1) stack view, 2) view constraints, 3) size classes and vary for traits. 

>Stack Views
>* arrange items horizontally and vertically, and can grow to fill space in their respective direction (horizontal or vertical)
>* consistent spacing between elements (or mention of adjustability of spacing)
>* options to distribute in the available space
>
>View Constraints
>* used for pinning or aligning to edges of superview and neighbouring views, and for setting the size of elements
>
>Size Classes and Vary for Traits<br>
>Used to customize for screen size: 
>* the view layout
>* what elements appear on the view
>* appearance properties of views (colours, font size, etc.)
