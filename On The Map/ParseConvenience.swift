//
//  UdacityConvenience.swift
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
    func authenticateWithViewController(hostViewController: UIViewController, parameters: [String: String!], completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
        
        // chain completion handlers for each request so that they run one after the other
        getSessionID(parameters) { (success, sessionID, userID, errorString) in
            
            if success {
                // success! we have the sessionID!
                self.sessionID = sessionID!
                self.userID = userID!
                completionHandlerForAuth(success: success, errorString: errorString)
            }
        }
    }
    
    func userData(completionHandlerForUserData: (success: Bool, errorString: String?) -> Void) {
        getUserData { (success, firstName, lastName, errorString) in
            if success {
                self.firstName = firstName
                self.lastName = lastName
                completionHandlerForUserData(success: success, errorString: errorString)
            }
        }
    }
    
    private func getUserData(completionHandlerForUser: (success: Bool, firstName: String?, lastName: String?, errorString: String?) -> Void) {
        let method = "\(UdacityClient.Methods.User)" // user
        taskForGETMethod(method) { (results, error) in
            if let error = error {
                print(error)
                completionHandlerForUser(success: false, firstName: nil, lastName: nil, errorString: "Failed (Get User Data).")
            } else {
                if let firstName = results[UdacityClient.JSONResponseKeys.User]!![UdacityClient.JSONResponseKeys.FirstName]!! as? String, lastName = results[UdacityClient.JSONResponseKeys.User]!![UdacityClient.JSONResponseKeys.LastName]!! as? String {
                    completionHandlerForUser(success: true, firstName: firstName, lastName: lastName, errorString: nil)
                } else {
                    print("Could not find \(UdacityClient.JSONResponseKeys.SessionID) in \(results)")
                    completionHandlerForUser(success: false, firstName: nil, lastName: nil, errorString: "Failed (Get User Data).")
                }
                print(results["user"]!!["first_name"]!!)
                print(results["user"]!!["last_name"]!!)
                
            }
            
        }
    }
    
    private func getSessionID(parameters: [String: String!], completionHandlerForSession: (success: Bool, sessionID: String?, userID: String?, errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let jsonBody = "{\"udacity\": {\"username\": \"\(parameters[UdacityClient.ParameterKeys.Username]!)\", \"password\": \"\(parameters[UdacityClient.ParameterKeys.Password]!)\"}}"
        /* 2. Make the request */
        taskForPOSTMethod(Methods.AuthenticationSessionNew, parameters: parameters, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForSession(success: false, sessionID: nil, userID: nil, errorString: "Login Failed (Session ID).")
            } else {
                if let sessionID = results[UdacityClient.JSONResponseKeys.SessionID]!![UdacityClient.JSONResponseKeys.UserID]!! as? String, userID = results[UdacityClient.JSONResponseKeys.Account]!![UdacityClient.JSONResponseKeys.Key]!! as? String {
                    completionHandlerForSession(success: true, sessionID: sessionID, userID: userID, errorString: nil)
                } else {
                    print("Could not find \(UdacityClient.JSONResponseKeys.SessionID) in \(results)")
                    completionHandlerForSession(success: false, sessionID: nil, userID: nil, errorString: "Login Failed (Session ID).")
                }
            }
        }
    }
}