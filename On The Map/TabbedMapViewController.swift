//
//  TabbedMapViewController.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/15/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//  Some code originally came from the Pin-Example app
//

import UIKit
import MapKit

class TabbedMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        StoredData.sharedInstance().getStudentInformation { (error) in
            if error == nil {
                performUIUpdatesOnMain{
                    self.loadMap()
                }
            } else {
                self.alertWithError(error!)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
    }
    
    func loadMap(){
        var annotations = [MKPointAnnotation]()
        for dictionary in StoredData.sharedInstance().studentInformation {
            
            let lat = CLLocationDegrees(dictionary.latitude)
            let long = CLLocationDegrees(dictionary.longitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        // When the array is complete, we add the annotations to the map.
        mapView.addAnnotations(annotations)
    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(NSURL(string: toOpen)!)
            }
        }
    }
    
    private func alertWithError(error: String) {
        let alertView = UIAlertController(title: "Download Error", message: error, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }
    
    class func sharedInstance() -> TabbedMapViewController {
        struct Singleton {
            static var sharedInstance = TabbedMapViewController()
        }
        return Singleton.sharedInstance
    }
    
}