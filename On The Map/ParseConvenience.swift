//
//  ParseConvenience.swift
//  TheMovieManager
//
//  Created by Phillip Crawford on 10/17/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit
import Foundation

// MARK: - TMDBClient (Convenient Resource Methods)

extension ParseClient {
    
    // MARK: Authentication (GET) Methods
    /*
     Steps for Authentication...
     https://www.themoviedb.org/documentation/api/sessions
     
     Step 1: Create a new request token
     Step 2a: Ask the user for permission via the website
     Step 3: Create a session ID
     Bonus Step: Go ahead and get the user id 😄!
     */
    
    func getStudentLocations(completionHandlerForStudentLocations: (result: [StudentLocation]?, error: NSError?) -> Void) {
        let method = ParseClient.Methods.StudentLocation
        taskForGETMethod(method) { (results, error) in
            if let error = error {
                print(error)
                completionHandlerForStudentLocations(result: nil, error: error)
            } else {
                if let results = results[ParseClient.JSONResponseKeys.StudentResults] as? [[String:AnyObject]] {
                    let studentLocations = StudentLocation.studentLocationsFromResults(results)
                    completionHandlerForStudentLocations(result: studentLocations, error: nil)
                } else {
                    completionHandlerForStudentLocations(result: nil, error: NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations"]))
                }
            }
        }
    }
    
    func postStudentLocation(completionHandlerForStudentLocation: (result: [StudentLocation]?, error: NSError?) -> Void) {
        let method = ParseClient.Methods.StudentLocation
        let jsonBody = "{\"\(ParseClient.JSONBodyKeys.UniqueKey)\": \"\(ParseClient.sharedInstance().userID!)\", \"\(ParseClient.JSONBodyKeys.FirstName)\": \"\(ParseClient.sharedInstance().firstName!)\", \"\(ParseClient.JSONBodyKeys.LastName)\": \"\(ParseClient.sharedInstance().lastName!)\",\"\(ParseClient.JSONBodyKeys.MapString)\": \"\(ParseClient.sharedInstance().mapString!)\", \"\(ParseClient.JSONBodyKeys.MediaURL)\": \"\(ParseClient.sharedInstance().mediaURL!)\",\"\(ParseClient.JSONBodyKeys.Latitude)\": \(ParseClient.sharedInstance().latitude!), \"\(ParseClient.JSONBodyKeys.Longitude)\": \(ParseClient.sharedInstance().longitude!)}"
        taskForPOSTMethod(method, jsonBody: jsonBody) { (results, error) in
            if let error = error {
                print(error)
                completionHandlerForStudentLocation(result: nil, error: error)
            } else {
                print(results)
                if let results = results[ParseClient.JSONResponseKeys.StudentResults] as? [[String:AnyObject]] {
                    let studentLocations = StudentLocation.studentLocationsFromResults(results)
                    completionHandlerForStudentLocation(result: studentLocations, error: nil)
                    print("AUTISMSPEAKS!")
                } else {
                    completionHandlerForStudentLocation(result: nil, error: NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations"]))
                    print("ANDITSAYSSHUTUP!")
                }
            }
        }
    }
}