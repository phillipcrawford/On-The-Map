//
//  TabbedTableViewController.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/15/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit

// MARK: - TabbedTableViewController: UIViewController

class TabbedTableViewController: UIViewController {
    
    // MARK: Properties
    
    //var movies: [TMDBMovie] = [TMDBMovie]()
    
    // MARK: Outlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create and set the logout button
        parentViewController!.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Reply, target: self, action: #selector(logout))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        TMDBClient.sharedInstance().getWatchlistMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                performUIUpdatesOnMain {
                    self.moviesTableView.reloadData()
                }
            } else {
                print(error)
            }
        }
    }
    
    // MARK: Logout
    
    func logout() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - WatchlistViewController: UITableViewDelegate, UITableViewDataSource

extension TabbedTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /* Get cell type */
        let cellReuseIdentifier = "WatchlistTableViewCell"
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!
        
        /* Set cell defaults */
        cell.textLabel!.text = movie.title
        cell.imageView!.image = UIImage(named: "Film")
        cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        if let posterPath = movie.posterPath {
            TMDBClient.sharedInstance().taskForGETImage(TMDBClient.PosterSizes.RowPoster, filePath: posterPath, completionHandlerForImage: { (imageData, error) in
                if let image = UIImage(data: imageData!) {
                    performUIUpdatesOnMain {
                        cell.imageView!.image = image
                    }
                } else {
                    print(error)
                }
            })
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        controller.movie = movies[indexPath.row]
        navigationController!.pushViewController(controller, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}