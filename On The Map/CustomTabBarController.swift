//
//  CustomTabBarController.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/27/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//
//

import UIKit

class CustomTabBarController: UITabBarController {

    @IBAction func logout(sender: AnyObject) {
        UdacityClient.sharedInstance().deleteSession()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addStudentLocation(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InformationPostingViewController") as! InformationPostingViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func refresh(sender: AnyObject) {
        let mapVC = self.viewControllers![0] as! TabbedMapViewController
        let tableVC = self.viewControllers![1] as! TabbedTableViewController
        ParseClient.sharedInstance().getStudentLocations { (studentLocations, error) in
            if let studentLocations = studentLocations {
                mapVC.studentLocations = studentLocations
                tableVC.studentLocations = studentLocations
                performUIUpdatesOnMain{
                    mapVC.loadMap()
                    // tableVC.StudentLocationsTableView will be nil if we hit refresh without ever going to TabbedTableViewController
                    if tableVC.StudentLocationsTableView != nil {
                        tableVC.StudentLocationsTableView.reloadData()
                    }
                }
            } else {
                print(error)
            }
        }
        
    }
}