//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/7/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import UIKit

extension UdacityClient {
    
    // MARK: Constants
    struct Constants {
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
        static let SignUp = "https://www.udacity.com/account/auth#!/signup"
    }
    
    // MARK: Methods
    struct Methods {
    
        static let AuthenticationSessionNew = "/session"
        static let User = "/users"
        
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let Username = "Username"
        static let Password = "Password"
    }

    struct JSONResponseKeys {

        // MARK: Authorization
        static let SessionID = "session"
        static let UserID = "id"
        static let Account = "account"
        static let Key = "key"
        
        // MARK: Get User Data
        static let User = "user"
        static let FirstName = "first_name"
        static let LastName = "last_name"
    }

}