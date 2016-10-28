//
//  GCDBlackBox.swift
//  On The Map
//
//  Created by Phillip Crawford on 10/7/16.
//  Copyright © 2016 Phillip Crawford. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}

func performSlowUpdate(updates: () -> Void) {
    let seconds = 4.0
    let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    
    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
        updates()
    })
}