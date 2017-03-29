//
//  MyLocation.swift
//  Location
//
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

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


class MyLocation: UIViewController {
    var lm: CLLocationManager!
    
    // MARK: - User interface
    
    @IBOutlet weak var toggleLocationButton: UIButton!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var myMap: MKMapView!
    
    // MARK: - UI interactions
    
    @IBAction func toggleLocation(_ sender: UIButton) {
        if myMap.showsUserLocation {
            lm.stopUpdatingLocation()
        } else {
            lm.startUpdatingLocation()
        }

        myMap.showsUserLocation = !myMap.showsUserLocation
    }

    @IBAction func onPinDrop(_ sender: UIButton) {
        let pin = Pin(coordinate: myMap.centerCoordinate)
        myMap.addAnnotation(pin)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureLocationObjects()
    }

    fileprivate func configureLocationObjects() {
        myMap.delegate = self

        // Initialize and configure the location manager
        lm = CLLocationManager()
        lm.delegate = self
        
        // Change these values to affect the update frequency
        lm.distanceFilter = 100
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        lm.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("Location services enabled\n")
            lm.startUpdatingLocation()
            myMap.showsUserLocation = true
        }
    }
}

extension MyLocation : CLLocationManagerDelegate {
    // CLLocationManagerDelegate has many methods, all are optional.
    // We only need these three.

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
            myMap.showsUserLocation = true
        } else {
            print("User didn't authorize location services, status: \(status)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Most recent location is the last item in the 'locations' array
        // The array has CLLocation objects, 'coordinate' property has lat and long
        // Other properties are 'altitude' and 'timestamp'

        if let l = locations.last {
            // Display the latitude and longitude
            latitude.text = "Lat: \(l.coordinate.latitude)"
            longitude.text = "Long: \(l.coordinate.longitude)"

            print("location update \(latitude.text!) \(longitude.text!)")

            // When the map first loads, it is zoomed out to show country or world level, let's detect that
            // and zoom in to 2km x 2km
            let kmPerDegreeLat = 111.325 // roughly!
            let maxKmSpanToShow = 100.0
            // If more than 100km from top-to-bottom is being shown, zoom in to 2km x 2km
            if myMap.region.span.latitudeDelta * kmPerDegreeLat > maxKmSpanToShow {
                // Set the display region of the map
                myMap.setRegion(MKCoordinateRegionMakeWithDistance(l.coordinate, 2000, 2000), animated: true)
            }
        }

        myMap.userTrackingMode = .follow
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")

        let nserr = error as NSError
        if nserr.domain == "kCLErrorDomain" && nserr.code == 0 {
            print("(If you are in simulator: Go to Simulator app menu Debug>Location and enable a location.")
        }
    }
}

extension MyLocation: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton.init(type: UIButtonType.detailDisclosure)
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else{
            return
        }

        print("calloutAccessoryControlTapped: \(annotation.coordinate.latitude),\(annotation.coordinate.longitude)")
    }
}
