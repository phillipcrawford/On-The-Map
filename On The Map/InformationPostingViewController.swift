//
//  InformationPostingViewController.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/20/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit
import MapKit

class InformationPostingViewController: UIViewController, UITextViewDelegate, MKMapViewDelegate {
    
    var keyboardOnScreen = false
    var studentLocations: [StudentLocation] = [StudentLocation]()
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBAction func cancel1(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var textView1: UITextView!
    
    @IBOutlet weak var button1: UIButton!
    @IBAction func findOnTheMap(sender: AnyObject) {
        userDidTapView(self)
        let locationString = textView1.text
        ParseClient.sharedInstance().mapString = locationString
        geocoding(locationString) {
            self.view2.hidden = false
            UIView.animateWithDuration(1.5, animations: {
                self.view1.hidden = true
                self.view2.hidden = false
            })
        }
    }
    ////////////////
    @IBAction func cancel2(sender: AnyObject) {
        UIView.animateWithDuration(1.5, animations: {
            self.view1.hidden = false
            self.view2.hidden = true
        })
    }
                
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var button2: UIButton!
    @IBAction func submit(sender: AnyObject) {
        userDidTapView(self)
        let linkString = textView2.text
        print(linkString)
        ParseClient.sharedInstance().mediaURL = linkString
        ParseClient.sharedInstance().postStudentLocation { (studentLocations, error) in
            if let studentLocations = studentLocations {
                self.studentLocations = studentLocations
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print(error)
                
            }
        }
    }
    
    override func viewDidLoad() {
        textView1.delegate = self
        textView2.delegate = self
        button1.layer.cornerRadius = 5
        button2.layer.cornerRadius = 5
        subscribeToNotification(UIKeyboardWillShowNotification, selector: #selector(keyboardWillShow))
        subscribeToNotification(UIKeyboardWillHideNotification, selector: #selector(keyboardWillHide))
        subscribeToNotification(UIKeyboardDidShowNotification, selector: #selector(keyboardDidShow))
        subscribeToNotification(UIKeyboardDidHideNotification, selector: #selector(keyboardDidHide))
    }
    
    override func viewWillAppear(animated: Bool) {
        view2.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = nil
    }
    
    func geocoding(location: String, completion: () -> ()) {
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark!.location
                let coordinate = location?.coordinate
                ParseClient.sharedInstance().latitude = coordinate!.latitude
                ParseClient.sharedInstance().longitude = coordinate!.longitude
                print(coordinate!.latitude)
                print(coordinate!.longitude)
                let center = CLLocationCoordinate2D(latitude: coordinate!.latitude, longitude: coordinate!.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
                let annotation = MKPointAnnotation()
                annotation.coordinate = center
                annotation.title = ParseClient.sharedInstance().mapString
                completion()
            }
        }
    }
}


extension InformationPostingViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Show/Hide Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        if !keyboardOnScreen {
            view.frame.origin.y -= keyboardHeight(notification)
            //logoImageView.hidden = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardOnScreen {
            view.frame.origin.y += keyboardHeight(notification)
            //logoImageView.hidden = false
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        keyboardOnScreen = true
    }
    
    func keyboardDidHide(notification: NSNotification) {
        keyboardOnScreen = false
    }
    
    private func keyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    private func resignIfFirstResponder(textField: UITextView) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(textView1)
        resignIfFirstResponder(textView2)
    }

}

// MARK: - InformationPostingViewController (Notifications)
extension InformationPostingViewController {
    
    private func subscribeToNotification(notification: String, selector: Selector) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    private func unsubscribeFromAllNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
