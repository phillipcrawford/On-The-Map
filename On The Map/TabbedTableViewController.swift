//
//  TabbedTableViewController.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/15/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//  Some code originally came from the TMDBMovieManager app
//

import UIKit

// MARK: - FavoritesViewController: UIViewController

class TabbedTableViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var StudentInformationTableView: UITableView!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        StoredData.sharedInstance().getStudentInformation { (error) in
            if error == nil {
                performUIUpdatesOnMain {
                    self.StudentInformationTableView.reloadData()
                }
            } else {
                self.alertWithError(error!)
            }
        }
    }
    
    private func alertWithError(error: String) {
        let alertView = UIAlertController(title: "Download Error", message: error, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }
    
}

// MARK: - TabbedTableViewController: UITableViewDelegate, UITableViewDataSource

extension TabbedTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /* Get cell type */
        let cellReuseIdentifier = "StudentInformationViewCell"
        let singleStudentInformation = StoredData.sharedInstance().studentInformation[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!
        
        /* Set cell defaults */
        cell.textLabel!.text = "\(singleStudentInformation.firstName) \(singleStudentInformation.lastName)"
        cell.imageView!.image = UIImage(named: "pin")
        cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
    
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoredData.sharedInstance().studentInformation.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let singleStudentInformation = StoredData.sharedInstance().studentInformation[indexPath.row]
        
        let app = UIApplication.sharedApplication()
        let toOpen = singleStudentInformation.mediaURL
        app.openURL(NSURL(string: toOpen)!)
    }
}