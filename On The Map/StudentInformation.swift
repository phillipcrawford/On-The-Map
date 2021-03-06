//
//  StudentInformation.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/17/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

struct StudentInformation {
    
    // MARK: Properties
    
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectID: String
    let uniqueKey: String
    let createdAt: AnyObject
    let updatedAt: AnyObject
    // MARK: Initializers
    
    // construct a StudentInformation object from a dictionary
    init(dictionary: [String:AnyObject]) {
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String ?? ""
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String ?? ""
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double ?? 0
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double ?? 0
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String ?? ""
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String ?? ""
        objectID = dictionary[ParseClient.JSONResponseKeys.ObjectID] as? String ?? ""
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String ?? ""
        createdAt = dictionary["createdAt"]!
        updatedAt = dictionary["updatedAt"]!
        
    }
    
    static func currentStudent(results: [String:AnyObject]) -> [StudentInformation] {
        var studentInformation = [StudentInformation]()
        var newResult = [String:AnyObject]()
        newResult[ParseClient.JSONResponseKeys.FirstName] = ParseClient.sharedInstance().firstName
        newResult[ParseClient.JSONResponseKeys.LastName] = ParseClient.sharedInstance().lastName
        newResult[ParseClient.JSONResponseKeys.Latitude] = ParseClient.sharedInstance().latitude
        newResult[ParseClient.JSONResponseKeys.Longitude] = ParseClient.sharedInstance().longitude
        newResult[ParseClient.JSONResponseKeys.MapString] = ParseClient.sharedInstance().mapString
        newResult[ParseClient.JSONResponseKeys.MediaURL] = ParseClient.sharedInstance().mediaURL
        newResult["objectId"] = results["objectId"]
        newResult[ParseClient.JSONResponseKeys.UniqueKey] = ParseClient.sharedInstance().userID
        newResult["createdAt"] = results["createdAt"]
        newResult["updatedAt"] = ""
        
        studentInformation.append(StudentInformation(dictionary: newResult))
        return studentInformation
    }
    
    static func studentInformationFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var studentInformation = [StudentInformation]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            studentInformation.append(StudentInformation(dictionary: result))
        }
        
        return studentInformation
    }
}