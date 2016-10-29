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
        self.viewDidLoad()
    }

}