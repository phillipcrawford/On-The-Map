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