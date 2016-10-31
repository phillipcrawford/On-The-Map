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

    @IBAction func addStudentInformation(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InformationPostingViewController") as! InformationPostingViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func refresh(sender: AnyObject) {
        let mapVC = self.viewControllers![0] as! TabbedMapViewController
        let tableVC = self.viewControllers![1] as! TabbedTableViewController
        ParseClient.sharedInstance().getStudentInformation { (studentInformation, error) in
            if let studentInformation = studentInformation {
                mapVC.studentInformation = studentInformation
                tableVC.studentInformation = studentInformation
                performUIUpdatesOnMain{
                    mapVC.loadMap()
                    // tableVC.StudentInformationTableView will be nil if we hit refresh without ever going to TabbedTableViewController
                    if tableVC.StudentInformationTableView != nil {
                        tableVC.StudentInformationTableView.reloadData()
                    }
                }
            } else {
                self.alertWithError(error!)
            }
        }
    }
    
    private func alertWithError(error: String) {
        let alertView = UIAlertController(title: "Download Error", message: error, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
}


