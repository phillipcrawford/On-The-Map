//
//  StoredData.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/31/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

class StoredData {
    
    var studentInformation: [StudentInformation] = [StudentInformation]()

    func getStudentInformation(completionHandlerForWork:(error: String?) -> Void) {
        ParseClient.sharedInstance().getStudentInformation { (studentInformation, error) in
            if let studentInformation = studentInformation {
                self.studentInformation = studentInformation
                completionHandlerForWork(error: nil)
            } else {
                completionHandlerForWork(error: error)
            }
        }
    }
    
    class func sharedInstance() -> StoredData {
        struct Singleton {
            static var sharedInstance = StoredData()
        }
        return Singleton.sharedInstance
    }
    
}
