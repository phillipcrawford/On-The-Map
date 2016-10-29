//
//  UdacityConvenience.swift
//  TheMovieManager
//
//  Created by Phillip Crawford on 10/7/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit
import Foundation

// MARK: - TMDBClient (Convenient Resource Methods)

extension UdacityClient {
    
    func authenticateWithViewController(parameters: [String: String!], completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
        getSessionID(parameters) { (success, sessionID, userID, errorString) in
            if success {
                self.sessionID = sessionID!
                self.userID = userID!
                ParseClient.sharedInstance().userID = userID
            }
            completionHandlerForAuth(success: success, errorString: errorString)
        }
    }
    
    func userData(completionHandlerForUserData: (success: Bool, errorString: String?) -> Void) {
        getUserData { (success, firstName, lastName, errorString) in
            if success {
                self.firstName = firstName
                ParseClient.sharedInstance().firstName = firstName
                self.lastName = lastName
                ParseClient.sharedInstance().lastName = lastName
                completionHandlerForUserData(success: success, errorString: errorString)
            }
        }
    }
    
    func deleteSession(){
        taskForDELETEMethod()
    }
    
    private func getSessionID(parameters: [String: String!], completionHandlerForSession: (success: Bool, sessionID: String?, userID: String?, errorString: String?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let jsonBody = "{\"udacity\": {\"username\": \"\(parameters[UdacityClient.ParameterKeys.Username]!)\", \"password\": \"\(parameters[UdacityClient.ParameterKeys.Password]!)\"}}"
        /* 2. Make the request */
        taskForPOSTMethod(Methods.AuthenticationSessionNew, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if error != nil {
                completionHandlerForSession(success: false, sessionID: nil, userID: nil, errorString: (error?.userInfo)!["NSLocalizedDescription"]! as? String)
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
            }
        }
    }
}