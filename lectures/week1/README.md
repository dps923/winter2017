<h4>Welcome</h4>
<p>This course will be fun. Challenging, but fun.</p>
<p>You&#8217;ll learn to program apps for iOS.</p>
<p>You&#8217;ll learn mobile app development principles, useful for any mobile platform.</p>

### Intro
* Overview of iOS development tools and languages (Xcode, Objective-C, Swift)
* Students: quick review of comfort level with C++ as I will make comparisons between Swift and C++
* What are the benefits of Swift?

### Xcode and Playgrounds
* Xcode Playgrounds allow you to practice swift. It is a type of REPL (Read-Evaluate-Print-Loop, that is, a tool to write code and see immediate output without setting up a project). 

### Learning Swift

Please excuse when I write code as one-line instead of on multiple lines in the following examples. It is just to illustrate a point, I expect you to format your code on multiple lines.
All the referenced documentation sections should only be 1-2 paragraphs in length, my intention is to give you short summaries to refer to.

#### First period
* Variables
    * Read: [The Basics, Declaring Constants and Variables, Type Annotations](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html)
* Basic Types
    * Declaration of:<br>Boolean `var swiftIsFun = true`,<br>Int `var x = 10`,<br>Double `var d = 2.2`,<br>Float `var f: Float = 2.2`,<br>String `var hello = "is it me you're looking for?"`
    * All are objects, there are no primitive (non-object) types like C++. 
    * All are **value types**, which means they are copied when assigned to another variable or passed to a function:<br>`var x = 1;`<br>`var y = x;`<br>`var x = 2;`<br>the variable `y == 1` still, it is unchanged
    * Tip: only **class** types are not **value types**. We'll talk about this more later.
* Strings
    * Swift has built-in unicode support, the downside being a slightly clunky way to access characters and their count:<br>`var count = hello.characters.count`
    * Read [String Interpolation](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID292)
* Conditionals
    * Read: [Conditionals](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html)
    * Should be similar to other languages. 
* Looping
    * Read: [For In Loops] (https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html)
    * Common loops to know:
        * half-open range operator: `for i in 0..<10 {}` -> how many times does this run?
        * reverse of a range `for i in (0..<3).reversed() {}` -> what values are there for i?
        * Equivalent of `for (int i = 0; i < 9; i += 3)` in Swift is:<br>`for i in stride(from: 0, to: 9, by: 3) {}`<br> <sub>Stride is less important but good to be aware of</sub>

#### Second period
* Built-in Collection Types
    * Array and Dictionary. Both very similar declaration using square brackets.
    * Array if type can be inferred:<br>`var cars = ["Honda", "Ford", "Toyota"]`
    * initializing empty array (notice type can't be inferred, need to use explicit typing):
        * `var cars: [String] = []`
        * `var cars = [String]()` is equivalent to the above, and we didn't cover in class
    * Dictionary:<br>`var importantDates = ["Confederation": 1867, "Moon Landing": 1969, "Bieber's Birthday": 1994]`
    * and for an empty Dictionary initialization, there are 2 equivalent ways:
        * `var importantDates: [String: Int] = [:]`
        * `var importantDates = [String: Int]()`
    * Reference is (unlike the above reading links, this is long, I don't expect you to read it just yet): [Collection Types](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105) 
* Looping collection types
    * `for car in cars { print(car) }` or<br>`for i in 0..<cars.count { print(cars[i]) }`
    * We did not cover iterating dictionaries, we'll cover it later:
        * `for (event, year) in importantDates { print("In \(year) this happened: \(event)") }` 
        * `for event in importantDates.keys {`<br>&nbsp;&nbsp;`print("In \(importantDates[event]) this happened: \(event)")`<br>`}` 
* Functions
    * Read: [Functions With Multiple Parameters](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158)
    * C++ equivalents
        * `void noParams() {}` in Swift is<br>`func noParams() -> Void {}`<br>Tip: `-> Void` is not needed for functions returning nothing: `func noParams() {}`
        * `int gimmieAnInt() { return 1; }` in Swift is<br>`func gimmieAnInt() -> Int { return 1 }`
        * `void greetPerson(string name) { cout << "hello " << name; }` in Swift is<br>`func greetPerson(name: String) { print("hello \(name)") }`
* Classes and Structs
    * Simplified reason to use structs:
        1. Don't need inheritance from a base type
        1. Don't need reference counting of the object<br>Struct is a `value type`, see the example for how a value type behaves in the "Variables" section above 

     * Similar to C++, a class can inherit from another class, but no multiple inheritance.
     * Read these brief sections: [Definition Syntax, Class and Structure Instances, Accessing Properties, Memberwise Initializers for Structure Types](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82) 
     
* Optional Type
    * Covered in Jan 12 lab

#### Resources
[WWDC Intro to Swift Video](https://developer.apple.com/videos/play/wwdc2016/404/)
<sub><sup><b>This requires Safari. Without Safari, you can open a 'network stream' in VLC player with this URL: http://devstreaming.apple.com/videos/wwdc/2016/404hskg1ijeev16mdej/404/hls_vod_mvp.m3u8</b></sup></sub>
<p>Swift Programming Language (Apple, <a href="https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html" target="_blank">HTML</a>, or for <a href="https://itunes.apple.com/us/book/the-swift-programming-language/id881256329?mt=11" target="_blank">iBooks</a>)</p>
<p>Swift Standard Library Reference (Apple, <a href="https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html" target="_blank">HTML</a>, <a href="https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/SwiftStandardLibraryReference.pdf" target="_blank">PDF</a>)</p>
<p>Xcode Application Help (Apple, <a href="http://help.apple.com/xcode/mac/8.0/" target="_blank">HTML</a>) (also available on the Xcode &#8216;Help&#8217; menu)</p>
<p>Xcode Gestures and Keyboard Shortcuts (Apple, <a href="https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/xcode_help-command_shortcuts/Introduction/Introduction.html" target="_blank">HTML</a>)</p>
<p>Xcode Keyboard Shortcuts (McIntyre, <a href="https://petermcintyre.files.wordpress.com/2013/09/xcode-keyboard-shortcuts.pdf">PDF</a>)</p>
