## Geolocation on Mobile Devices

Geolocation means to get a position on the earth in geographic coordinates (latitude and longitude). On mobile devices, this is achieved using:

* Global Positioning System (GPS): a radio chip on devices that use the GPS satellite system to provide accurate position.
* Network location services: uses the Internet to get a location based on
    * IP Address, which is low accuracy –a safe assumption is that it is within 50 km of the correct location,
    * Cell Tower(s) -if the device has a SIM card– which has an accuracy of 1-10 km,
    * and Wi-Fi Access Points, typically 30-200 meters of accuracy.

As an aside, we are simplifying a bit here, modern devices can also use the sensors on the device (accelerometer, barometer, etc.) to contribute positioning information.

*There are additional cell tower geolocation services that are only available to government agencies (and popularly used on TV crime shows), however we won't concern ourselves with those.*

#### Key Points

Location APIs (on iOS, Android, even HTML 5 in a browser) have options to specify how accurate you want the location to be. The higher the accuracy used, the more power is used on the device.

See: https://developer.apple.com/reference/corelocation/cllocationaccuracy

Specifying to the API that the GPS should/shouldn't be used isn't possible, you can only specify whether low/medium/high accuracy is requested. 
Most certainly, high accuracy location requires using the GPS chip on the device, and this will drain the device battery quickly (often in 2-4 hours).

Low accuracy location may have little or no battery impact, but may not be useful depending on the needs of the app.<br>
A navigation app would obviously require high accuracy location, but if you simply need to show a list of Starbucks in the user's city, low accuracy would be appropriate.

Another consideration is whether to use a single location, to ask periodically for a location, or to track the location closely. The last option would increase the device power consumption.

## A brief introduction to location services

The course’s GitHub code repository has an app named [WhereAmI](./WhereAmI) which introduces location services.

All the code of interest is in one file: [MyLocation.swift](WhereAmI/Classes/MyLocation.swift)

The app uses two services:
*   Location
*   Mapping

The MyLocation controller manages a scene (view) that has labels for latitude, longitude, and a map view to display the map. The controller conforms to a location manager delegate protocol.

When the controller loads, it will configure the location service objects. A class-level variable holds the ‘location manager’, and some of its settings need to be configured.

An important task is to ask the device user for authorization to use location services. This task will cause an _alert_ to appear, and the user must give permission for the location services to work properly.

This task must be configured. In your project’s Supporting Files group, you will see a file named “[Info.plist](https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/AboutInformationPropertyListFiles.html)“. It has configuration settings for your app. Select it to open it in the editor.

Add a new key – right-click in an empty area of the editor, and “Add Row”. Here’s the settings information:

*   Key: NSLocationWhenInUseUsageDescription
*   Type: String
*   Value: empty, or the text of a message that you want to appear in the alert

![location-info-plist-setting](https://petermcintyre.files.wordpress.com/2015/03/location-info-plist-setting.png?w=595)

When a location-related event is detected on the device, the iOS runtime will call the _locationManager:didUpdateLocations:_ method.

Then, we can extract the location data from the passed-in data, and if we need to, use a map view to show the location on a map.

## Running the app

The iOS simulator actually trumps running on-device for developing location-based (and map-based) apps, as it has a built-in location simulator.

In the Simulator app, go to the menu Debug > Location.
You can put in a single simulated location, use the location of Apple in Cupertino, California, or my preferred choices:
* city run
* city bike ride
* freeway drive

Those three options simulate movement around the Cupertino region and provide useful (and interesting) location data while you are sitting at a desk coding.

Alternatively, if you run on a device, you can get a single location while developing, and then to test the app you can move around.

## MapKit 

MapKit is an iOS API that makes it easy to display maps, draw routes and other shapes on top. The most common use case is to put pins on a map, and we will look at this in the demo application.

MapKit API's are prefixed with **MK**.

**MKMapView** is the name of class that presents the map. It is available as an object you can drop on your storyboard.

In the demo app, we perform the following on the MKMapView:

* have it show the user's location with **MKMapView.showsUserLocation**
* set the displayed region to a 2km x 2km area around the current location using **MKMapView.setRegion(...)**
* set the **MKMapView.userTrackingMode** to follow the user

These are tip-of-the-iceberg operations in terms of the types of things you can do with MKMapView, it is a fun area of the iOS API to play with because of the extensive API, and very popular to use in apps.

### Dropping pins on a map

This common operation is performed using an **MKAnnotation** to represent a pin. 

Adding the pin to the map is performed with **MKMapView.addAnnotation(...)**

This is a protocol, so you have to make a class that implements this protocol. The demo code has this simple MKAnnotation class:

```swift
class Pin: NSObject, MKAnnotation {
    let _coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self._coordinate = coordinate
        super.init()
    }

    public var coordinate: CLLocationCoordinate2D {
        return _coordinate
    }

    public var title: String? {
        return "location"
    }

    public var subtitle: String? {
        return "subtitle"
    }
}
```

Then when the 'Drop Pin' button is pressed, the code does:

```swift
    @IBAction func onPinDrop(_ sender: UIButton) {
        let pin = Pin(coordinate: myMap.centerCoordinate)
        myMap.addAnnotation(pin)
    }
```

Now pins will be dropped at the current location. Nice!

#### MKAnnotations can be made interactive

The MKMapView has a delegate, **MKMapViewDelegate**, that is setup to callback to the view controller in the demo when the screen is tapped.

See: https://developer.apple.com/reference/mapkit/mkmapviewdelegate

```swift
extension MyLocation: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton.init(type: UIButtonType.detailDisclosure)
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Perhaps show a detail view of the pin that was tapped
    }
}
```

The function `map​View(MKMapView, view​For:​ MKAnnotation)` gets called when the pin is tapped.

The demo uses the built-in **MKPinAnnotationView** to show a bubble (called a **callout**) at the pin location.<br>
It sets the **rightCalloutAccessoryView** to an info button, that when pressed, will call the second function above (the func **annotationView, calloutAccessoryControlTapped**).  
<br>

### For more information  
For more information, read the [Location and Maps Programming Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/Introduction/Introduction.html). 

