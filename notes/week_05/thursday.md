Thursday, February 9, 2017  
Computer-lab room T3078 at 1:30pm  

Agenda for today:
1. Review of this week's topics, with more explanations  
2. Introduce the next programming assignment  
3. Begin work on Assignment 4  
<br>

### Review of this week's topics  

> More detail to come... patterns... table view controller, model class, app initialization  
> Preview of the content...  

<br>
A table view controller is a *listener*.  

Its initialization has three "phases":
1. Initialization  
2. Table-building  
3. Responding to user interaction  

A table view controller adopts (conforms to) delegate and data source protocols. So, it must have a *data source* available.  

The Model class is that source of data. It has public properties and functions. It is responsible for materializing its data, which could come from device storage, or the network.  

Pattern for using the model class:  
1. Create an instance in the app delegate  
2. Pass it on to the app's root view controller  
<br>

### Introduce and begin work on Assignment 4  
Assignment 4 has been published to the usual location.  

We will look at a sample app, and the app's workflow.  

Then, we'll begin work on Assignment 4.  
