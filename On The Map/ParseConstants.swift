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
        static let AuthorizationURL : String = "https://www.themoviedb.org/authenticate/"
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK: Account
        static let Account = "/account"
        static let AccountIDFavoriteMovies = "/account/{id}/favorite/movies"
        static let AccountIDFavorite = "/account/{id}/favorite"
        static let AccountIDWatchlistMovies = "/account/{id}/watchlist/movies"
        static let AccountIDWatchlist = "/account/{id}/watchlist"
        
        // MARK: Authentication
        static let AuthenticationTokenNew = "/authentication/token/new"
        static let AuthenticationSessionNew = "/session"             ///////////
        static let StudentLocation = "/StudentLocation"              ///////////
        
        // MARK: Search
        static let SearchMovie = "/search/movie"
        
        // MARK: Config
        static let Config = "/configuration"
        
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "id"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let Username = "Username"            //////////////
        static let Password = "Password"            //////////////
        static let ApiKey = "api_key"
        static let SessionID = "session_id"
        
        static let RequestToken = "request_token"
        static let Query = "query"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let MediaType = "media_type"
        static let MediaID = "media_id"
        static let Favorite = "favorite"
        static let Watchlist = "watchlist"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        // MARK: Authorization
        static let SessionID = "session"            //////////////
        static let UserID = "id"                    //////////////
        static let Account = "account"              //////////////
        static let Key = "key"                      //////////////
        
        // MARK: StudentLocation Keys
        
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