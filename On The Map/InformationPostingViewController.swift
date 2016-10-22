//
//  InformationPostingViewController.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/20/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit
import MapKit

/**
 * This view controller demonstrates the objects involved in displaying pins on a map.
 *
 * The map is a MKMapView.
 * The pins are represented by MKPointAnnotation instances.
 *
 * The view controller conforms to the MKMapViewDelegate so that it can receive a method
 * invocation when a pin annotation is tapped. It accomplishes this using two delegate
 * methods: one to put a small "info" button on the right side of each pin, and one to
 * respond when the "info" button is tapped.
 */

class InformationPostingViewController: UIViewController, MKMapViewDelegate {

    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.
    var latitude: Double?
    var longitude: Double?
    
    //@IBOutlet weak var prompt: UILabel!                     //1
    @IBOutlet weak var locationInputText: UITextView!       //1
    //@IBOutlet weak var graySpace: UILabel!                  //1
    @IBOutlet weak var submitLocationButton: UIButton!      //1
    
    @IBOutlet weak var mapView: MKMapView!                  //2
    @IBOutlet weak var linkText: UITextView!                //2
    @IBOutlet weak var submit: UIButton!                    //2
    
    @IBAction func submitLocationButton(sender: AnyObject) {//1
        let locationString = locationInputText.text
        geocoding(locationString) {
            print("\(self.coordinates)")
            ParseClient.sharedInstance().setLocation(locationString, passedLatitude: self.latitude!, passedLongitude: self.longitude!)
        }
        
    }
    
    @IBAction func submit(sender: AnyObject) {              //2
        let linkString = linkText.text
        print(linkString)
        ParseClient.sharedInstance().setLinkString(linkString)
    }
    
    override func viewDidLoad() {
        
    }
    
    var coordinates = (0.0, 0.0)
    
    func geocoding(location: String, completion: () -> ()) {
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark!.location
                let coordinate = location?.coordinate
                self.coordinates = (coordinate!.latitude, coordinate!.longitude)
                self.latitude = coordinate!.latitude
                self.longitude = coordinate!.longitude
                print("Inside completion handler: \(self.coordinates)")
                completion()
            }
        }
        print("Outside completion handler: \(coordinates)")
    }
}