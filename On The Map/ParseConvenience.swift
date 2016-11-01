//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/17/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit
import Foundation

extension ParseClient {
    
    func getStudentInformation(completionHandlerForStudentInformation: (result: [StudentInformation]?, error: String?) -> Void) {
        let method = ParseClient.Methods.StudentLocation
        taskForGETMethod(method) { (results, error) in
            if let error = error {
                completionHandlerForStudentInformation(result: nil, error: (error.userInfo)["NSLocalizedDescription"]! as? String)
            } else {
                if let results = results[ParseClient.JSONResponseKeys.StudentResults] as? [[String:AnyObject]] {
                    let studentInformation = StudentInformation.studentInformationFromResults(results)
                    completionHandlerForStudentInformation(result: studentInformation, error: nil)
                } else {
                    completionHandlerForStudentInformation(result: nil, error: "getStudentInformation parsing")
                }
            }
        }
    }
    
    func postStudentInformation(completionHandlerForStudentInformation: (result: [StudentInformation]?, error: String?) -> Void) {
        let method = ParseClient.Methods.StudentLocation
        
        var dictionary = [String:AnyObject]()
        dictionary[ParseClient.JSONBodyKeys.UniqueKey] = userID
        dictionary[ParseClient.JSONBodyKeys.FirstName] = firstName
        dictionary[ParseClient.JSONBodyKeys.LastName] = lastName
        dictionary[ParseClient.JSONBodyKeys.MapString] = mapString
        dictionary[ParseClient.JSONBodyKeys.MediaURL] = mediaURL
        dictionary[ParseClient.JSONBodyKeys.Latitude] = latitude
        dictionary[ParseClient.JSONBodyKeys.Longitude] = longitude
        
        let jsonBody = try! NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions())
        
        taskForPOSTMethod(method, jsonBody: jsonBody) { (results, error) in
            if let error = error {
                completionHandlerForStudentInformation(result: nil, error: (error.userInfo)["NSLocalizedDescription"]! as? String)
            } else {
                if let results = results as? [String:AnyObject!] {
                    let currentStudent = StudentInformation.currentStudent(results)
                    completionHandlerForStudentInformation(result: currentStudent, error: nil)
                } else {
                    completionHandlerForStudentInformation(result: nil, error: "getStudentInformation parsing")
                }
            }
        }
    }
}


    