//
//  ParseConstants.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/17/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit

extension ParseClient {
    
    // MARK: Constants
    struct Constants {
        
        // MARK: API Key
        static let ApiKey : String = "a55aeb535cdb7bfcf9394f2c712ff8c0"
        
        // MARK: URLs
        static let ApiScheme = "https"               /////////////
        static let ApiHost = "parse.udacity.com"       /////////////
        static let ApiPath = "/parse/classes"                  /////////////
    }
    
    // MARK: Methods
    struct Methods {
        static let StudentLocation = "/StudentLocation"              ///////////
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
        static let StudentResults = "results"
    }
    
    // MARK: UI
    struct UI {
        static let LoginColorTop = UIColor(red: 0.345, green: 0.839, blue: 0.988, alpha: 1.0).CGColor
        static let LoginColorBottom = UIColor(red: 0.023, green: 0.569, blue: 0.910, alpha: 1.0).CGColor
        static let GreyColor = UIColor(red: 0.702, green: 0.863, blue: 0.929, alpha:1.0)
        static let BlueColor = UIColor(red: 0.0, green:0.502, blue:0.839, alpha: 1.0)
    }
    
}