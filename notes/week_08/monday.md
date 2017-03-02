#### Important things to know before you begin coding

There are some very important things to know before you begin coding network tasks:

**Basic knowledge of HTTP is required.** You must know what a ‘request’ is, and what a ‘response’ is. These are the fundamental building blocks in an app that uses the network.

**Basic knowledge of web services is required.** You must know what a ‘web service’ is, and how to use one. In this course, you do not have to code/create a web service – you simply have to use one. You must also be able to understand and use [JSON](http://json.org).

**Network operations are asynchronous.** That means that we do not know _if_ or _when_ our request will be responded to.

**You must learn something about closures.** A closure in Swift is an executable code object. Network operations use closures.

**Simple tasks are easy to code, but complex tasks require more study.** Simple tasks include ‘get one’ and ‘get all’ from a resource. More complex tasks include HTTP POST, data modifications, authentication, and so on.

### Swift Closures

Think of a _closure_ as an _inline function_. (You have likely worked with similar constructs in the past, including JavaScript functions (and closures), and C# lambda expressions.)

Read the Apple doc on this topic:
https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html

Watch the WWDC video on Swift closures, from 25 min->33 min in this video:
[WWDC Intro to Swift Video](https://developer.apple.com/videos/play/wwdc2016/404/)
<sub><sup><b>This requires Safari. Without Safari, you can open a 'network stream' in VLC player with this URL: http://devstreaming.apple.com/videos/wwdc/2016/404hskg1ijeev16mdej/404/hls_vod_mvp.m3u8</b></sup></sub>

A closure, like a function, has parameters and a return type:

```
// Instead of this
func myFunc(parameters) -> returnValue {
  statements
}
// a closure looks like this
{ (parameters) -> returnValue in
    statements
}
```

But you can't call that closure, in fact it does absolutely nothing.
Let's look at how you might call a closure:

```
// A closure that takes and Int and returns nothing (Void)
let closure = { (value: Int) -> Void in
    print("The value is \(value)")
}
closure(10)
```

Here we assigned the closure to a variable, then called it by using the variable with function syntax.
The important point here is that a _closure can be assigned to a variable_.
This is very useful in this week's examples. 

#### Void and () 

To indicate a closure takes no parameters, use `()`, 
or to indicate it returns nothing, `Void` or `()` is used:
```swift
// These are the same 
() -> ()
() -> Void

// A func in swift that doesn't specify a return value is implicity returning Void:
func noReturnValue() -> Void {
}
```

Tip: If the closure has no parameters are returns nothing, that is `() -> Void`, you can leave out the line `() -> Void in`.
If the closure takes parameters and returns nothing, like `(Int) -> Void`, you can leave out the `-> Void`.
This will look like:
```swift
let example = { (x: Int) in // no ->Void needed
  print("\(x)")
}
```

#### Closures as function arguments

Closures are super-handy (and commonly used) to pass in to functions as arguments.
The WWDC video above shows how a closure can be used to iterate collections so that you closure gets called for every item of the collection visited.
We will focus on using closures as _completion callbacks_, so that the caller can be notified a function is complete.

```
func doLotsOfWork(completion: () -> Void) {
    // do lots of work
    completion() // call the completion closure 
}

doLotsOfWork(completion: { 
    () -> Void in 
    print("Yay you are done!")
}
```

#### Asynchronous code and Closures go together like peas and carrots

When you call an asynchronous function, your code does not stop to wait for it complete. 
We will see our first asynchronous function this week when performing a networking call to get data.
Networking code is asynchronous because it can take long periods of time to complete and your program should not stop executing to wait.
The URLSessionDataTask.execute() function behaves like this.

```swift
// setup a networking task
let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: onComplete) 

// tell the task to start
task.execute()
```
This last line does not block the program execution. So how do we know when the data is downloaded and ready?
Notice the `completionHandler` parameter. That is a closure of the form `(Data?, URLResponse?, Error?) -> Void`.

This closure is chock-full of information, it has the data retreived, the error (if there is one), and other response information.



### Getting started, hands-on

This week, you will use the Project_Templates/WebServiceModel template to create a simple app that uses a web service.

Download the template from the [GitHub code example repository](../Project_Templates/WebServiceModel/). Then, perform the project-rename task.

We will use a public web service that your professor created recently. It is here:

http://<fill in>.azurewebsites.net/api

The web service is designed to be self-documenting, so you can discover its data and permitted operations.

By itself, a web browser is not a good tool to use to inspect a web service. Instead, use this web app:

[http://jsonformatter.curiousconcept.com](http://jsonformatter.curiousconcept.com)

Enter a resource URI in its “JSON Data Url” field, and click its “Process” button. The response to each request will be displayed in its own grey-bordered box. Try it with these URIs:

http://<fill in>azurewebsites.net/api/programs

[https://itunes.apple.com/search?term=big+bang+theory&entity=tvEpisode&limit=10&sort=recent](https://itunes.apple.com/search?term=big+bang+theory&entity=tvEpisode&limit=10&sort=recent)


#### Composing a network request, and handling the response

In iOS (and OS X), we use a ‘task’ object to compose a network request, and handle the response.

The ‘task’ object is an instance of [NSURLSessionDataTask](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLSessionDataTask_class/Reference/Reference.html). It uses a ‘session’ object, and a ‘request’ object.

The ‘session’ object is an instance of [NSURLSession](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLSession_class/Introduction/Introduction.html), which represents a logical session between your app and a web service. A ‘session’ object must be configured, using a ‘session configuration’ object (which is an instance of [NSURLSessionConfiguration](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLSessionConfiguration_class/Reference/Reference.html)).

The ‘request’ object is an instance of [NSMutableURLRequest](https://developer.apple.com/library/ios/documentation/cocoa/reference/foundation/Classes/NSMutableURLRequest_Class/Reference/Reference.html), which needs a ‘URL’ object, and can be configured with request headers if necessary.

In summary, a ‘task’ object relies on the presence of a number of other initialized and configured objects.

#### Configuring and executing the ‘task’ object

When a ‘task’ object is created, it does not immediately execute. You must execute it, when you are ready, by sending the ‘resume’ message to the object. The ‘task’ object executes in the background, so it does not impair the responsiveness of your app’s user interface.

More important is the configuration of the ‘task’ object: You must write a _block of code_ that will run when the task completes execution.

This _block of code_ is known as a _closure_ in Swift. 

The _closure_ is defined on the ‘task’ object’s _completionHandler_ parameter. It exposes these values:

*   The data returned in the response body
*   Metadata about the response
*   If necessary, error information

The data type of the data returned in the response body is NSData. Therefore, we must transform it into the format we expect. In this course, we plan to work with web services that use JSON, so we will [transform](https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html) the NSData object to JSON and then to an array or dictionary, as appropriate for the request.

#### Code example

See the <fill in> code example on the GitHub code example repository, in the Week_08 folder.

#### Learning resources

[URL Loading System Programming Guide](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.html) (a summary will be added below)

#### A deeper look at the networking classes

The following is a summary of the important parts of the URL Loading System Programming Guide, as well as the class reference documents for NSURLSession and others.

> Content copied directly/verbatim from the Apple documentation is <span style="color:#0000ff;">blue-coloured</span>.

<span style="color:#0000ff;">The URL loading system is a set of classes and protocols that allow your app to access content referenced by a URL.</span>

<span style="color:#0000ff;">The most commonly used classes in the URL loading system allow your app to retrieve the content of a URL from the source. In iOS 7 and later or OS X v10.9 and later, NSURLSession is the preferred API for new code that performs URL requests.</span> Old code examples and search engine results will use other classes (NSURLConnection, AFNetworking). While useful and instructive, you should not rely on old code examples.

<span style="color:#0000ff;">The URL loading classes use two helper classes that provide additional metadata—one for the request itself (NSURLRequest) and one for the server’s response (NSURLResponse).</span>

<span style="color:#0000ff;">The NSURLSession class and related classes provide an API for downloading content via HTTP. Like most networking APIs, the NSURLSession API is highly asynchronous. If you use the default, system-provided delegate, you must provide a completion handler block that returns data to your app when a transfer finishes successfully or with an error. </span>

<span style="color:#0000ff;">The NSURLSession API supports three types of sessions.</span> We will use the “default session” type.

<span style="color:#0000ff;">Within a session, the NSURLSession class supports three types of tasks: data tasks, download tasks, and upload tasks.</span> We will mostly use “data tasks”.

<span style="color:#0000ff;">The NSURLSession API provides a wide range of configuration options. Most settings are contained in a separate configuration object</span> (which is an instance of NSURLSessionConfiguration).

For many of our getting-started examples, <span style="color:#0000ff;">when you instantiate <span style="color:#333333;">an NSURLSession</span> object, you specify the following: </span>

1.  <span style="color:#0000ff;">A configuration object that governs the behavior of that session and the tasks within it</span>
2.  <span style="color:#0000ff;">Optionally, a delegate object</span>; however, we will use _nil_. <span style="color:#0000ff;">If you do not provide a delegate, the NSURLSession object uses a system-provided delegate. </span>
3.  The name of an _operation queue_ that performs the task specified in the _completion handler block_. We will use _[NSOperationQueue mainQueue]_.

<span style="color:#0000ff;">Your app can provide the request body content for an HTTP POST request in three ways.</span> We will use an NSData object.

<span style="color:#0000ff;">To upload body content with an NSData object, your app calls … the uploadTaskWithRequest:fromData:completionHandler: method to create an upload task, and provides request body data through the fromData parameter.  </span>

<span style="color:#0000ff;">The session object computes the Content-Length header based on the size of the data object.</span>

<span style="color:#0000ff;">Your app must provide any additional header information that the server might require—content type, for example—as part of the URL request object.</span>


<span style="color:#0000ff;">**Life Cycle of a URL Session with System-Provided Delegates**</span>

Here is the basic sequence of method calls that your app must make and completion handler calls that your app receives when using NSURLSession with the system-provided delegate:

<span style="color:#0000ff;">1\. Create a session configuration. </span>

<span style="color:#0000ff;">2\. Create a session, specifying a configuration object, a nil delegate</span>, and an operation queue.

<span style="color:#0000ff;">3\. Create task objects within a session that each represent a resource request.</span> Write a completion handler block.

<span style="color:#0000ff;">Each task starts out in a suspended state. After your app calls resume on the task, it begins downloading the specified resource.</span>

<span style="color:#0000ff;">When a task completes, the NSURLSession object calls the task’s completion handler.</span>

<span style="color:#0000ff;">When your app no longer needs a session, invalidate it by calling _finishTasksAndInvalidate_ (to allow outstanding tasks to finish before invalidating the object).</span>

> <span style="color:#0000ff;">Note: NSURLSession does not report server errors through the error parameter. The only errors your app receives through the error parameter are client-side errors, such as being unable to resolve the hostname or connect to the host. </span>
> 
> <span style="color:#0000ff;">Server-side errors are reported through the HTTP status code in the NSHTTPURLResponse object. </span>

