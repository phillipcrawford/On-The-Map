//
//  ParseConvenience.swift
//  TheMovieManager
//
//  Created by Phillip Crawford on 10/17/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit
import Foundation

extension ParseClient {
    
    func getStudentLocations(completionHandlerForStudentLocations: (result: [StudentLocation]?, error: String?) -> Void) {
        let method = ParseClient.Methods.StudentLocation
        taskForGETMethod(method) { (results, error) in
            if let error = error {
                completionHandlerForStudentLocations(result: nil, error: (error.userInfo)["NSLocalizedDescription"]! as? String)
            } else {
                if let results = results[ParseClient.JSONResponseKeys.StudentResults] as? [[String:AnyObject]] {
                    let studentLocations = StudentLocation.studentLocationsFromResults(results)
                    completionHandlerForStudentLocations(result: studentLocations, error: nil)
                } else {
                    completionHandlerForStudentLocations(result: nil, error: "getStudentLocations parsing")
                }
            }
        }
    }
    
    func postStudentLocation(completionHandlerForStudentLocation: (result: [StudentLocation]?, error: String?) -> Void) {
        let method = ParseClient.Methods.StudentLocation
        let jsonBody = "{\"\(ParseClient.JSONBodyKeys.UniqueKey)\": \"\(userID!)\", \"\(ParseClient.JSONBodyKeys.FirstName)\": \"\(firstName!)\", \"\(ParseClient.JSONBodyKeys.LastName)\": \"\(lastName!)\",\"\(ParseClient.JSONBodyKeys.MapString)\": \"\(mapString!)\", \"\(ParseClient.JSONBodyKeys.MediaURL)\": \"\(mediaURL!)\",\"\(ParseClient.JSONBodyKeys.Latitude)\": \(latitude!), \"\(ParseClient.JSONBodyKeys.Longitude)\": \(longitude!)}"
        taskForPOSTMethod(method, jsonBody: jsonBody) { (results, error) in
            if let error = error {
                completionHandlerForStudentLocation(result: nil, error: (error.userInfo)["NSLocalizedDescription"]! as? String)
            } else {
                if let results = results as? [String:AnyObject!] {
                    let currentStudent = StudentLocation.currentStudent(results)
                    completionHandlerForStudentLocation(result: currentStudent, error: nil)
                } else {
                    completionHandlerForStudentLocation(result: nil, error: "getStudentLocations parsing")
                }
            }
        }
    }
}